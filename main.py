from pynq import Overlay
import PIL.Image
from pynq import MMIO
from pynq.lib.video import *
import cv2
import numpy as np
from time import sleep
import math

base = Overlay("/home/xilinx/pynq/overlays/base/toplala123.bit")
base.download()

led=base.leds_gpio.channel1##base.leds
led.setlength(4)
led.setdirection("out")
switches=base.switches_gpio.channel1##base.switches
switches.setlength(2)
switches.setdirection("in")
dram_ip=MMIO(0x7FFFF000,0x4000)

# camera (input) configuration
frame_in_w = 640
frame_in_h = 480

videoIn = cv2.VideoCapture(0)
videoIn.set(cv2.CAP_PROP_FRAME_WIDTH, frame_in_w)
videoIn.set(cv2.CAP_PROP_FRAME_HEIGHT, frame_in_h)
print("capture device is open: " + str(videoIn.isOpened()))

def dram_write(frame):
    #write=str(a[0,0])
    a=1
    Delay2 = 0.1
    add=0x0000
    for i in range(80):
        for j in range(5):
            for k in range(32):
                #print(frame[i,32*j+k])
                if(frame[i,32*j+k]==0):
                    a=0
                else:
                    a=1 
                    
                if i==0 or i==79:
                    a=0
                    #print("%%")
                    
                m=32*j+k 
                if m==0 or m==159:
                    a=0
                    #print("%")
                if i==1 and j==0 and k==1:
                    a=1
                
                if i==1 and j==0 and k==2:
                    a=1
                
                if not k:
                    write=str(a)
                else:
                    write=write+str(a)
                    
            #print(write)
            #print(str(i*160+32*j))
            write_ram=int(write,2)
            #print(write_ram)
            #print(add)
            dram_ip.write(add,write_ram)
            add=add+4
    
Mode = VideoMode(640,480,8)
hdmi_out = base.video.hdmi_out
hdmi_out.configure(Mode,PIXEL_GRAY)
hdmi_out.start()

gen_pic=False
finished=False
gen_array=False

#outframe=hdmi_out.newframe()
pic_array=np.zeros((80,160),np.uint8)
pic_frame=np.zeros((80,160,3),np.uint8)

bg = PIL.Image.open("/home/xilinx/jupyter_notebooks/func3_bg.png")
bg2=bg.convert("L")
bg3 = np.asarray(bg2)

while(1):
    if gen_pic:
        led[1].on()
    else:
        led[1].off()
        
    if finished:
        led[3].on()
    else:
        led[3].off()
    
    if not finished:
        if(switches[0].read()==1):#sw0截图
            if(gen_pic==False):
                gen_pic=True
        else:
            gen_pic=False
            
        if(switches[1].read()==1):#传输数据
            if (gen_array==False):
                gen_array=True
        else:
            gen_array=False
    else:
        if switches[0].read()==0 :
            if switches[1].read()==0:
                break
                
    ret, frame_webcam = videoIn.read()
    
    if(not gen_pic):    
        # read next image
        if (ret):
            outframe = hdmi_out.newframe()
            pic_frame=frame_webcam [200:280,240:400,:]
            cv2.Canny(pic_frame, 100, 110, edges=pic_array)
            #cv2.rectangle(outframe, (240, 280),(400, 200),(255, 255, 255), 1)
            outframe[0:480,0:640] = bg3
            img2=cv2.resize(pic_array, (320, 160), interpolation=cv2.INTER_AREA)
            outframe[160:320,160:480]=img2
            cv2.rectangle(outframe, (160, 160),(480, 320),(255, 255, 255), 1)
            #outframe[200:280,240:400]=pic_array
            hdmi_out.writeframe(outframe)
            
    if(gen_array):
        #pic_array=outframe[200:280,240:400]
        #pic_array=cv2.fastNlMeansDenoising(pic_array,None,9)
        dram_write(pic_array)
        gen_array=False
        finished=True

videoIn.release() 
hdmi_out.stop()
del hdmi_out         


##
hand_hist = None #
traverse_point = [] #
writed_point = [] #
writed = []
writing = [] #
writing_point = [] #
left_point =[] #

##
total_rectangle = 9
hand_rect_one_x = None
hand_rect_one_y = None
hand_rect_two_x = None
hand_rect_two_y = None

##
bg = PIL.Image.open("/home/xilinx/jupyter_notebooks/4.png")
bg1 = np.asarray(bg)
bg2=np.zeros((480,640,3),np.uint8)
bg2[:,:,0]=bg1[:,:,2]
bg2[:,:,1]=bg1[:,:,1]
bg2[:,:,2]=bg1[:,:,0]
bg2.flags.writeable = True

bg3=np.zeros((480,640,3),np.uint8)
bg3[:,:,0]=bg1[:,:,2]
bg3[:,:,1]=bg1[:,:,1]
bg3[:,:,2]=bg1[:,:,0]
bg3.flags.writeable = True


def contours(hist_mask_image):
    gray_hist_mask_image = cv2.cvtColor(hist_mask_image, cv2.COLOR_BGR2GRAY)
    ret, thresh = cv2.threshold(gray_hist_mask_image, 0, 255, 0)
    _, cont, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    return cont


def max_contour(contour_list):
    max_i = 0
    max_area = 0

    for i in range(len(contour_list)):
        cnt = contour_list[i]

        area_cnt = cv2.contourArea(cnt)

        if area_cnt > max_area:
            max_area = area_cnt
            max_i = i

        return contour_list[max_i]


def draw_rect(frame):
    rows, cols, _ = frame.shape
    global total_rectangle, hand_rect_one_x, hand_rect_one_y, hand_rect_two_x, hand_rect_two_y

    hand_rect_one_x = np.array(
        [8 * rows / 20, 8 * rows / 20, 8 * rows / 20, 9 * rows / 20, 9 * rows / 20, 9 * rows / 20, 10 * rows / 20,
         10 * rows / 20, 10 * rows / 20], dtype=np.uint32)

    hand_rect_one_y = np.array(
        [9 * cols / 20, 10 * cols / 20, 11 * cols / 20, 9 * cols / 20, 10 * cols / 20, 11 * cols / 20, 9 * cols / 20,
         10 * cols / 20, 11 * cols / 20], dtype=np.uint32)

    hand_rect_two_x = hand_rect_one_x + 10
    hand_rect_two_y = hand_rect_one_y + 10

    for i in range(total_rectangle):
        cv2.rectangle(frame, (hand_rect_one_y[i], hand_rect_one_x[i]),
                      (hand_rect_two_y[i], hand_rect_two_x[i]),
                      (24, 226, 253), 1)#BGR()

    return frame


def hand_histogram(frame):
    global hand_rect_one_x, hand_rect_one_y

    hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    roi = np.zeros([90, 10, 3], dtype=hsv_frame.dtype)

    for i in range(total_rectangle):
        roi[i * 10: i * 10 + 10, 0: 10] = hsv_frame[hand_rect_one_x[i]:hand_rect_one_x[i] + 10,
                                          hand_rect_one_y[i]:hand_rect_one_y[i] + 10]

    hand_hist = cv2.calcHist([roi], [0, 1], None, [180, 256], [0, 180, 0, 256])
    return cv2.normalize(hand_hist, hand_hist, 0, 255, cv2.NORM_MINMAX)


def hist_masking(frame, hist):
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    dst = cv2.calcBackProject([hsv], [0, 1], hist, [0, 180, 0, 256], 1)

    disc = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (31, 31))
    cv2.filter2D(dst, -1, disc, dst)

    ret, thresh = cv2.threshold(dst, 150, 255, cv2.THRESH_BINARY)

    # thresh = cv2.dilate(thresh, None, iterations=5)

    thresh = cv2.merge((thresh, thresh, thresh))

    return cv2.bitwise_and(frame, thresh)


def centroid(max_contour):
    moment = cv2.moments(max_contour)
    if moment['m00'] != 0:
        cx = int(moment['m10'] / moment['m00'])
        cy = int(moment['m01'] / moment['m00'])
        return cx, cy
    else:
        return None


def farthest_point(defects, contour, centroid):
    if defects is not None and centroid is not None:
        s = defects[:, 0][:, 0]
        cx, cy = centroid

        x = np.array(contour[s][:, 0][:, 0], dtype=np.float)
        y = np.array(contour[s][:, 0][:, 1], dtype=np.float)

        xp = cv2.pow(cv2.subtract(x, cx), 2)
        yp = cv2.pow(cv2.subtract(y, cy), 2)
        dist = cv2.sqrt(cv2.add(xp, yp))

        dist_max_i = np.argmax(dist)

        if dist_max_i < len(s):
            farthest_defect = s[dist_max_i]
            farthest_point = tuple(contour[farthest_defect][0])
            return farthest_point
        else:
            return None


def draw_circles(vali_frame, traverse_point):
    global writed_point
    if traverse_point is not None:
        a=np.array(traverse_point)
        cv2.polylines(vali_frame,[a],False,(255,255,255),2)
        
    if len(writed_point)>2:
        writed=writed_point.copy()
        writed.pop(0)
        writed.pop(0)
        a=np.array(writed)
        cv2.polylines(vali_frame,[a],False,(255,255,255),2)

def dis_check(traverse_points,point,cnt_centroid):

    if len(traverse_points)==0 :
        return True
    else:
        nx,ny=point
        cx,cy=cnt_centroid
        
        distc= math.hypot(nx - cx, ny - cy)
        if (distc<20):
            return False

        x1,y1=traverse_points[0]    
        dist1= math.hypot(nx - x1, ny - y1)
        if(dist1>100):
            return False
        
        return True
    
def manage_image_opr(vali_frame, hand_hist):
    hist_mask_image = hist_masking(vali_frame, hand_hist)
    contour_list = contours(hist_mask_image)
    max_cont = max_contour(contour_list)

    cnt_centroid = centroid(max_cont)
    cv2.circle(vali_frame, cnt_centroid, 5, [255, 0, 255], -1)

    if max_cont is not None:
        hull = cv2.convexHull(max_cont, returnPoints=False)
        defects = cv2.convexityDefects(max_cont, hull)
        far_point = farthest_point(defects, max_cont, cnt_centroid)
        if far_point is not None:
            if dis_check(traverse_point,far_point,cnt_centroid):
                #print("Centroid : " + str(cnt_centroid) + ", farthest Point : " + str(far_point))
                cv2.circle(vali_frame, far_point, 5, [0, 0, 255], -1)
                if len(traverse_point) < 20:
                    traverse_point.append(far_point)
                else:
                    traverse_point.pop(0)
                    traverse_point.append(far_point)

        draw_circles(vali_frame, traverse_point)
        
def dram_write1():
    #
    global writed_point
    
    if len(traverse_point)==0 :
        #print("traverse_point==0")
        return
    else:
        m,n=traverse_point[-1]
        x1=int(m/3)
        y1=int(n/3)
        #print("x1,y1 get")

    #  
    if len(writed_point)==0 :
        writed_point.append((1,1))
        writed_point.append((1,2))
        writed_point.append((x1,y1))
        #print("initial point")
        #print("first point infomation:")
        #print((x1,y1))
        #print(len(writed_point))
        x1=1
        y1=2
        x0=1
        y0=1
    else:
        x0,y0=writed_point[-1]
        # 
        if len(writed_point) < 30:
            #print("length")
            #print(len(writed_point))
            writed_point.append((x1,y1))
        else:
            #print(len(writed_point))
            #print("former")
            #print(writed_point[2])
            #print("change into")
            writed_point.pop(2)
            #print(writed_point[2])
            writed_point.append((x1,y1))
            #print("length")
            #print(len(writed_point))


    #print("later point infomation:")
    #print((x1,y1))
    #print("formal point infomation:")
    #print((x0,y0))
        
    temp=0
    data_add=0x0000    
    a=y0
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    write=d
    
    a=x0
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    #print(d)
    write=write+d
    
    a=y1
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    #print(d)
    write=write+d
    
    a=x1
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    #print(d)
    write=write+d
    
    write_ram=int(write,2)
    #print(write_ram)
    #print(data_add)
    dram_data.write(data_add,write_ram)
    #n=dram_data.read(data_add)
    #print(n)

            
def dram_write2():
    print("drame2")
    if len(writing_point)<3 :
        return
    elif len(writing_point)==3 :
        x1=2
        y1=1
        x0=1
        y0=1
    else:
        m,n=writing_point[-1]
        x1=int(m/3)
        y1=int(n/3)
        m,n=writing_point[-2]
        x0=int(m/3)
        y0=int(n/3)
        
    print("point infomation x0,x1:")
    print((x0,y0))
    print((x1,y1))    
    
    temp=0
    data_add=0x0000    
    a=y0
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    write=d
    
    a=x0
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    #print(d)
    write=write+d
    
    a=y1
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    #print(d)
    write=write+d
    
    a=x1
    b=bin(a)
    c=b[2:]
    i=8-len(c)
    c=str(0)*i+c
    d=c[::-1]
    #print(d)
    write=write+d
    
    write_ram=int(write,2)
    #print(write_ram)
    #print(data_add)
    dram_data.write(data_add,write_ram)
    #n=dram_data.read(data_add)
    #print(n)

###
##overlay
base = Overlay("/home/xilinx/pynq/overlays/base/topgailala3.bit")
base.download()

##set buttons

buttons =base.btns_gpio.channel1
buttons.setlength(4)
buttons.setdirection("in")

#initial
dram_data=MMIO(0x7FFFF000,0x4000)
dram_read=MMIO(0x40000000,0x1000)
enread_add=0x0010
enwrite_add=0x0000

##led
led=base.leds_gpio.channel1##base.leds
led.setlength(4)
led.setdirection("out")
    
Mode = VideoMode(640,480,24)
hdmi_out = base.video.hdmi_out
hdmi_out.configure(Mode,PIXEL_BGR)
hdmi_out.start()

#global hand_hist
##状态
is_hand_hist_created = False
is_repeat_line=False
begin=False
capture = cv2.VideoCapture(0)
print("capture device is open: " + str(capture.isOpened()))
    
while capture.isOpened():

    finger_chase = buttons[0].read()#
    reset_line = buttons[1].read()#
    repeat_line = buttons[2].read()#
        
    _, frame = capture.read()
    #frame=cv2.flip(frame0,1)
    ##
    #   
    if(reset_line): 
        #traverse_point[:] = []
        is_repeat_line=False
        #writed_point[:] = []
        #writing_point[:] = []
        #left_point[:]=[]
        traverse_point.clear()
        writed_point.clear()
        writing_point.clear()
        left_point.clear()
        writing.clear()
        writed.clear()

    #
    if (finger_chase):
        is_hand_hist_created = True
        hand_hist = hand_histogram(frame)

    #       
    if (repeat_line):
        is_repeat_line=True
        begin=True
        print("show writed")
        print(len(writed_point))
        traverse_point.clear()
        writing_point.clear()
        left_point.clear()
        writing.clear()
        writed.clear()
        left_point=writed_point.copy()
        print(len(writing_point))
        print(len(writing))
        #dram_data.write(0x0000,0x00000000)
        #dram_data.write(enread_add,0x00000000)
        print("num of leftpoint")
        print(len(left_point))

    ## 
    if not is_repeat_line:
        if is_hand_hist_created:
            #
            vali_frame=np.zeros((240,480,3),np.uint8)
            vali_frame=frame[120:360,80:560,:]
            manage_image_opr(vali_frame, hand_hist)
            bg2[120:360,80:560,:]=vali_frame
            cv2.rectangle(bg2, (80, 120),(560,360),(28, 201, 157), 3)#RGB(157, 201, 28)可改进
        else:
            #
            frame = draw_rect(frame)
            bg2[120:360,80:560,:]=frame[120:360,80:560,:]
            cv2.rectangle(bg2, (80, 120),(560,360),(28, 201, 157), 3)
                
        outframe = hdmi_out.newframe()
        outframe[:] = bg2
        hdmi_out.writeframe(outframe)

        ##   
        led[0].on()
        enwrite=dram_read.read(enwrite_add)
        if enwrite:
            #print("begin writing。。。 " )
            led[1].on()   
            led[0].off()
            dram_write1()
            dram_data.write(enread_add,0x00000001)
            #print('finish')
            led[1].off()
            led[0].on()
            
    else:
        #
        if begin:
            #
            cv2.rectangle(bg3,(80, 120),(560,360),(28, 201, 157), 3)
            #
            #
            led[0].on()
            enwrite=dram_read.read(enwrite_add)
            if enwrite:
                print("begin repeating。。。 " )
                led[1].on()   
                led[0].off()  
                if  len(left_point):
                    nx,ny=left_point.pop(0)
                    print("left num")
                    print(len(left_point))
                    a=nx*3
                    b=ny*3
                    writing_point.append((a,b))
                    print("point infomation x0,y0:")
                    print((a,b))
                else:
                    begin=False
                    writing_point.append((0,0))
                    print("end.return")
                             
                dram_write2()
                dram_data.write(enread_add,0x00000001)
                print('finish')
                led[1].off()
                led[0].on()

            #     
            if  len(writing_point)>2:
                #
                z,x=writing_point[-1]
                if z==0 and x==0 :
                    writing_point.pop(-1)
                        
                writing=writing_point.copy()
                writing.pop(0)
                writing.pop(0)
                c=np.array(writing)
                vali_frame1=np.zeros((240,480,3),np.uint8)
                cv2.polylines(vali_frame1,[c],False,(24,226,253),2)
                bg3[120:360,80:560,:]=vali_frame1
                    
            outframe = hdmi_out.newframe()
            outframe[:] = bg3
            hdmi_out.writeframe(outframe)
                   
    if buttons[3].read():#
        break
        
capture.release()
hdmi_out.stop()
del hdmi_out

base = Overlay("/home/xilinx/pynq/overlays/base/toplala123.bit")
base.download()

led=base.leds_gpio.channel1##
led.setlength(4)
led.setdirection("out")
switches=base.switches_gpio.channel1##base.switches
switches.setlength(2)
switches.setdirection("in")
dram_ip=MMIO(0x7FFFF000,0x4000)

# camera (input) configuration
frame_in_w = 640
frame_in_h = 480

Mode = VideoMode(640,480,8)
hdmi_out = base.video.hdmi_out
hdmi_out.configure(Mode,PIXEL_GRAY)
hdmi_out.start()

image = PIL.Image.open("/home/xilinx/jupyter_notebooks/EE1.png")
image2=image.convert("L")
img = np.asarray(image2)
img2=cv2.resize(img, (480, 240), interpolation=cv2.INTER_AREA)

bg = PIL.Image.open("/home/xilinx/jupyter_notebooks/bg.png")
bg2=bg.convert("L")
bg3 = np.asarray(bg2)

outframe = hdmi_out.newframe()
outframe[0:480,0:640] = bg3
#outframe[200:280,240:400]=img
outframe[80:320,80:560]=img2
            
hdmi_out.writeframe(outframe)
#hdmi_out.writeframe(bg3)

dram_write(img)
led[1].on()
while(switches[1].read()==0):
    a=1

hdmi_out.stop()
del hdmi_out