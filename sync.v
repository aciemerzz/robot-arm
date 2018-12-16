`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/16 13:30:34
// Design Name: 
// Module Name: xiaoxiaxiadahuaidan
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/04 19:08:00
// Design Name: 
// Module Name: aa
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module xiaoxiaxiadahuaidan(clk,rst,zero,cpl,cpr,dirl,dirr,pwm1,doutb,dinb,rstb,enb,addrb,web,web1,doutb1,dinb1,enb1,addrb1,d1,d2,d3,d4,d5);
input clk;    
input rst; 
input zero;
input[31:0] doutb;
input[31:0] doutb1;
output reg[31:0] dinb;
output reg rstb;
output reg enb;
output reg[31:0] addrb;
output reg[3:0] web;
output reg[31:0] dinb1;
output reg enb1;
output reg[3:0] web1;
output reg[31:0] addrb1;
output cpl;   
output cpr;
output dirl; 
output dirr;
output pwm1;
output d1;   output d2;  output d3;  output d4; output d5;
reg cpl;
reg cpr;
reg dirl;
reg dirr;
reg pwm1;
reg d1; reg d2; reg d3; reg d4;reg d5;

reg[31:0] addr;   
integer ok;
integer start_en=0;
integer start_s=0;
integer rst_en=1;

integer cnt_mem=0;    
integer cnt_mem1=0;  

integer qq=0;         
integer qq1=0;
integer judge_1=0;
integer state_1=0;   
integer en_button1;
integer cnt_button;

integer  desx_to10,desy_to10;
integer selfx_to10,selfy_to10;
integer  finish1,finish2,finish0,first;
integer xx,yy,xxx,yyy;
integer stepxy;
integer stepx,stepy;
integer a1,b1,c1;   
reg[31:0] en_read,en_write;         
integer pread,pwrite;        
integer cnt_read;
integer remindsx,remindsy,reminddx,reminddy;
integer abcd=0;
integer x,y;
 integer mx=0;            
 integer game_end;          
 reg[2:0] xy_state;  
 integer l_dir;          
 integer r_dir;
 integer l_cp;
 integer r_cp;
 integer xys_state;        
 integer en_xy;           
reg[159:0] mema [0:79];  
reg [15:0] mema0[0:84];  reg[15:0] mema1[0:84];
reg[31:0] zancun1;
reg[31:0] zancun2;
reg[31:0] zancun3;
reg[31:0] zancun4;
reg[31:0] zancun5;

 reg [159:0] row;     
 reg [159:0] row1;
 reg [159:0] row2;
 reg [159:0] row3;
 
 reg[16:0] dx=0;     
 reg[16:0] dy=0;
 
reg data;
 reg data1,data11;
 reg data2,data22;
 reg data3,data33;
 reg data4,data44;
 reg data6,data66;
 reg data7,data77;
 reg data8,data88;
 reg data9,data99;
 reg data_flag;
 reg [3:0] main_state;
reg [15:0] self_row=0; 
reg [15:0] self_col=0;   
reg [15:0] des_row;   
reg [15:0] des_col;   
  reg en_front;  
  reg en_behind;  
  integer step_x;
  integer c_x;    
  integer x_state;
reg en_left;  
   reg en_right; 
   integer step_y;  
   integer c_y; 
   integer y_state;
integer zdown_state;
reg[32:0] counter=0; 
reg[32:0] counter1=0;
reg[32:0] counterd=0;
reg[32:0] counterd1=0;
reg[64:0] countera=0;  
integer lala=0;
parameter 
   Idle=4'b0001,     
   Scan=4'b0010,    
   Write=4'b0100; 
integer clk_cnt;
   reg clk_1MHz;
   always @(posedge clk)
   if(clk_cnt==32'd50)
   begin clk_cnt <= 1'b0; clk_1MHz <= ~clk_1MHz;end
   else
   clk_cnt <= clk_cnt + 1'b1;
always @(posedge clk_1MHz)
        begin
if((rst==0)&&(zero==0))
             begin
             if(zero==1)  game_end=1; 
           else   game_end=0;    
                   ok=0;
                start_en<=1;
                start_s<=0;       
             //   rst_en<=0;
                addr=32'h7FFF_F000;  dinb=0;  rstb=0;  enb=0;  web=4'b0000;  
                cnt_mem=0;    qq=0;  qq1=0;        
            enb1=0; web=4'b0000;  cnt_mem1=0;addrb1=32'h40000000;   cnt_read=0;
              main_state<=Idle;
                  //self_row<=16'd0;
                 //self_col<=16'd0;
                 d5=1;
     first=1; finish0=0;            
en_read=0; en_write=1; 
desx_to10=0;  desy_to10=0;
selfx_to10=0; selfy_to10=0; 
stepx=0;stepy=0;stepxy=0;
xx=0;yy=0;xxx=0;yyy=0;
finish1=0; finish2=0;
a1=0;   b1=0;  c1=0;
abcd=0;
state_1=0;       
judge_1=0;
d1=0;
d2=0;
d3=0;
d4=0;
remindsx=0;remindsy=0;reminddx=0;reminddy=0;
mx<=0;
//game_end<=0;
l_cp<=0;
r_cp<=0;
r_dir<=0;
l_dir<=0;
xys_state<=0;
xy_state<=0;
en_xy<=1;

         data=0;
          x<=0;
          y<=0;  
          data1=0; data11=0;
          data2=0; data22=0;
          data3=0; data33=0;
          data4=0; data44=0;
          data6=0; data66=0;
          data7=0; data77=0;
          data8=0; data88=0;
          data9=0; data99=0;
          data_flag<=0;
          row=0;
          row1=0;
          row2=0;
          row3=0;
   en_front<=0;
      en_behind<=0;  
      step_x<=0;
      c_x<=0;
      x_state<=0;
 en_left<=0;
       en_right<=0; 
       step_y<=0;
       c_y<=0;
       y_state<=0;

 enb1=1; web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000000;  //       zdown_state<=0;
  counter<=0;
  counter1<=0;
  counterd<=0;
  counterd1<=0;
end         
 
 
 
else if ((rst==1)&&(game_end==0))               
 begin

 
 case(main_state)
 Idle: 
 begin  
 des_row<=16'd0;des_col<=16'd0;   
 self_row<=16'd0;self_col<=16'd0;zdown_state<=0;
 enb1=1; web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000001;  //       
 if(zdown_state)         begin z_up; countera = countera + 1;
                                if(countera ==64'd1000000)    begin lala=1;countera=0;end end  
  if(!x_state)            begin x_step;end
  if((mx==1)&&(!y_state)) begin y_step;end                                                                                     
  if((!zdown_state) && (x_state) && (y_state)) begin main_state<=Scan; x_state<=0; y_state<=0; end
  else begin  main_state<=Idle;end 
 end

 Scan:
 begin   
                    enb1=0;    
                    if((en_read==0))  
                         begin
                        d1=1;d2=0;d3=0;d4=0;
                            if(cnt_read==0) begin   addrb=addr+32'b00000000_00000000_00000000_00010000; enb=1;web=4'b0000;  cnt_read =1; end
                            else if(cnt_read==1)  cnt_read=2;
                            else if(cnt_read==2)  cnt_read=3;
                             else if(cnt_read==3) begin     en_read=doutb;     enb=0; cnt_read=0;  end
                          end
                     
                   if(en_read==1)
                         begin      d1=0;d2=1;d3=0;d4=0;enb1=1; web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000000;   
                                       if(cnt_mem==0) begin   addrb=addr;  enb=1; cnt_mem =1; end
                                        else if(cnt_mem==1)  cnt_mem=2;
                                        else if(cnt_mem==2)  cnt_mem=3;
                                        else if(cnt_mem==3)
                                             begin
                                            zancun1[31:0]=doutb;
                                           selfx_to10=zancun1[31]+zancun1[30]*2+zancun1[29]*4+zancun1[28]*8+zancun1[27]*16+zancun1[26]*32+zancun1[25]*64;
                                           selfy_to10=zancun1[23]+zancun1[22]*2+zancun1[21]*4+zancun1[20]*8+zancun1[19]*16+zancun1[18]*32+zancun1[17]*64+zancun1[16]*128;
                                           desx_to10=zancun1[15]+zancun1[14]*2+zancun1[13]*4+zancun1[12]*8+zancun1[11]*16+zancun1[10]*32+zancun1[9]*64;
                                           desy_to10=zancun1[7]+zancun1[6]*2+zancun1[5]*4+zancun1[4]*8+zancun1[3]*16+zancun1[2]*32+zancun1[1]*64+zancun1[0]*128;

                                           if((remindsx==selfx_to10)&&(remindsy==selfy_to10)&&(reminddx==desx_to10)&&(reminddy==desy_to10))     begin    main_state=Scan;  enb1=1;web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000001;     end
                                       else begin
                                             remindsx=selfx_to10;remindsy=selfy_to10;reminddx=desx_to10;reminddy=desy_to10;  
                                            main_state=Write; 
                                            //en_write=1;
                                             end
                                            cnt_mem=0; en_read=0; enb=0; 
                                            pread=0;
                                           // enb1=1; //web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000001;
                                            if((desx_to10==0)&&(desy_to10==0))  game_end=1; 
                                            end   
                                      end    
                                              
      
 end                 
 
 
 
 Write: 
  begin         
   
if(finish1==0)
                begin
                if((self_row==selfx_to10)&&(self_col==selfy_to10))   begin finish1=1; finish2=0; x_state=0; y_state=0; first=0; finish0=0;main_state=Write;  end
                 else    
                   begin   
                      if((first==0)&&(finish0==0))  
                        begin
                        if(zdown_state) begin   z_up; countera = countera + 1;
                               if(countera ==64'd1000000)   begin  lala=1;countera=0;  end end
                        else begin  finish0=1;  end
                        
                        end
                        
                        if((first==1)||(finish0==1))
                        begin
                        des_col=selfy_to10; des_row=selfx_to10;  
                         if(!x_state)            begin x_step;end
                         if((mx==1)&&(!y_state)) begin y_step;end                                                                                     
                         if(x_state && y_state) begin  finish1=1;finish2=0;x_state=0; y_state=0;main_state=Write;first=0; finish0=0; end  
                       end
                   //       if(zdown_state)  begin finish1=1;x_state<=0; y_state<=0;   end
                    end
                  end 
   
   else if((finish1==1)&&(finish2==0))
               begin
                 des_col=desy_to10; des_row=desx_to10;   
                 xx=desx_to10-selfx_to10;    yy=desy_to10-selfy_to10;  
                     if(xx>0) xxx=xx;  else xxx=selfx_to10-desx_to10;      
                     if(yy>0) yyy=yy;  else yyy=selfy_to10-desy_to10;      
                     if((xx>0)&&(yy>0)) xy_state=2'b10;  else if((xx>0)&&(yy<0)) xy_state=2'b11;  else if((xx<0)&&(yy<0))  xy_state=2'b01;  else if((xx<0)&&(yy>0)) begin xy_state=2'b00;end
                 if(!xx && !yy) begin main_state<=Scan; finish1<=0;enb1=1;    web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000001; end 
                 else   
                 begin
                  
                   if(!zdown_state)  begin  z_down; countera = countera + 1;   if(countera ==64'd1000000) begin lala=0;countera=0; end   end 
                    if(zdown_state)
                     begin
                       if(xx==0) begin    if(!y_state) begin  y_step; end
                                          if(y_state)  begin   y_state=0;    finish2=1;  end       
                                  end
                                  
                       else if(yy==0)  begin  if(!x_state) begin x_step;end
                                              if(x_state)  begin   x_state=0; mx=0;   finish2=1; end  
                                        end
                       else if(xxx==yyy) begin    if(!xys_state) begin b1=1; stepxy=xxx; xy_step;  end   
                                                if(xys_state)  begin  xys_state=0; finish2=1; b1=0; self_col=des_col; self_row=des_row; en_xy<=1; end
                                         end
                      else 
                         begin 
                           if(xxx<yyy)   
                                begin
                                   if(a1==0) begin     if(!y_state) begin  b1=1; stepy=(yyy-xxx)/2;  y_step;end
                                                       if(y_state)  begin   y_state=0;   a1=1;b1=0; end   end    
                                   else if(a1==1) begin   if(!xys_state) begin b1=1; stepxy=xxx; xy_step;  end   
                                                          if(xys_state)  begin  xys_state=0; a1=2;b1=0; en_xy<=1;  end   end  
                                    else if(a1==2) begin if(!y_state) begin  b1=1;  stepy=yyy-xxx-((yyy-xxx)/2);   y_step;end
                                                          if(y_state)  begin   y_state=0;    finish2=1; a1=0;  b1=0;self_col=des_col; self_row=des_row; end   end
                                  end
                          else 
                                 begin 
                                 if(a1==0) begin     if(!x_state) begin  b1=1; stepx=(xxx-yyy)/2;  x_step;end
                                                      if(x_state)  begin   x_state=0; mx=0;   a1=1; b1=0;  end   end    
                                 else if(a1==1) begin   if(!xys_state) begin  b1=1;  stepxy=yyy; xy_step;  end   
                                                        if(xys_state)  begin  xys_state=0; a1=2; b1=0;en_xy<=1;   end   end  
                                 else if(a1==2) begin if(!x_state) begin  b1=1;   stepx=xxx-yyy-((xxx-yyy)/2);   x_step;end
                                                       if(x_state)  begin   x_state=0; mx=0;   finish2=1; a1=0;b1=0; self_col=des_col; self_row=des_row; end   end
                                 
                                 end
                      
                         end  
                     end   
                 end     
               
               
               end //duiying    finish1=1
    else if(finish2==1)
                begin     
                   finish1=0;    finish2=0;  main_state=Scan;  
               enb1=1;    web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000001;
                end   
 
 
 
  end 

 
 
 default:  main_state<=Idle;
 endcase
 
end  

 else if((game_end==1)||(zero==1))      
  begin
  d1=0;d2=0;d3=1;d4=0;
  des_row<=0;
  des_col<=0;
 if((zdown_state))         begin z_up; countera = countera + 1;
                                 if(countera ==64'd1000000)    begin lala=1;countera=0;end end  

if((!zdown_state))
begin   
  if(!x_state)            begin x_step;end
  if((mx==1)&&(!y_state)) begin y_step;end             
  end
   //if((!zdown_state) && (x_state) && (y_state)) begin end
  end      
  
end



task z_up; 
begin
counterd = 0; counterd1 = 0; counter = counter + 1;
if(counter ==32'd100)      begin counter <= 0; counter1<= counter1 + 1; end
if(counter1 == 8'd1)       begin pwm1<= 1;end
else if(counter1==8'd10)   begin pwm1<= 0;end
else if(counter1==64'd300) begin counter1<=0; if (lala==1) begin  zdown_state<=0; if((game_end==1)||(zero==1)) abcd=1;
                                                                    end end end
endtask

task z_down;
begin 
counter=0; counter1=0; counterd <= counterd + 1;
if(counterd ==32'd100)       begin counterd <= 0; counterd1<= counterd1 + 1; end
if(counterd1 == 8'd1)        begin pwm1 <= 1;end
else if(counterd1 ==8'd20)   begin pwm1 <= 0;end
else if(counterd1 ==16'd300) begin counterd1<=0; if(lala==0)begin zdown_state<=1;end end end
endtask 


task y_step;
 begin
     if(b1==0)
      begin
         if(des_col>self_col)  begin en_right<=0;en_left<=1;step_y<=((des_col-self_col)*10);end
         if(des_col<self_col)  begin en_left<=0;en_right<=1;step_y<=((self_col-des_col)*10);end    
         if(des_col==self_col) begin en_left<=0;en_right<=0;step_y<=0;end       
       end
    else begin
        if(yy>0 && yy<256)  begin  en_right<=0;en_left<=1;step_y<=stepy*10;end
        else                begin  en_left<=0;en_right<=1;step_y<=stepy*10;end
     end
 if(dy==16'd2000)
    begin
    cpl<=0;
    cpr<=0;
    dy<=0;
    end
    else 
    dy<=dy+1;
    
    if(dy==0)
    begin
 if((c_y==step_y-1)||(step_y==0))    
             begin
             c_y<=0;
             en_left<= 0;
             en_right <= 0;
             y_state<=1;
             mx<=0;   
             self_col<=des_col;
             end
   else    c_y <= c_y +1;
 
 
 if(en_right==1)
 begin
 dirl<=0; 
 dirr<=0;
  cpl=1;
  cpr=1;
 
 end
else if(en_left==1)
begin
 dirl<=1;  

 dirr<=1;
  cpl=1;
  cpr=1;
 end 
 end
 end    

 endtask 


task x_step;
  begin
  if(b1==0)
  begin
     if(des_row>self_row)  begin en_front<=0;en_behind<=1;step_x<=((des_row-self_row)*10);end
     if(des_row<self_row)  begin en_front<=1;en_behind<=0;step_x<=((self_row-des_row)*10);end    
     if(des_row==self_row) begin en_front<=0;en_behind<=0;step_x<=0;end     
  end
   else begin
     if(xx>0 && xx<256)  begin en_front<=0;en_behind<=1;step_x<=stepx*10; end
     else begin en_front<=1;en_behind<=0;step_x<=stepx*10; end
   end

if(dx==16'd2000)
begin

cpl<=0;
cpr<=0;
dx<=0;
end
else 
dx<=dx+1;

if(dx==0)
begin

  if((c_x==step_x-1)||(step_x==0))    
              begin
              c_x<=0;
              en_front<= 0;
              en_behind<= 0;
              x_state<=1;

              mx<=1;
   
              self_row<=des_row;
              end
          else    c_x <= c_x +1;
 
  if(en_front==1)
  begin
 
  dirl<=0; 
  dirr<=1;
  cpl=1;
  cpr=1;
  end
 else if(en_behind==1)
 begin
  dirl<=1; 
  dirr<=0;
   cpl=1;
   cpr=1;
  
   
  end
  end
  end     

  
   
  endtask 


task xy_step;
 begin
   if(b1==0) step_x=20;     
   else step_x=stepxy*20;
    case(xy_state)
  2'b00: 
      begin
      l_cp<=0;
      r_cp<=1;    
      l_dir<=1;
      r_dir<=1;    
      end
  2'b01:       
     begin
     l_cp<=1;
      r_cp<=0;  
     l_dir<=0;
     r_dir<=1;     
     end
  2'b10: 
     begin

     l_cp<=1;
      r_cp<=0;  
     l_dir<=1;
     r_dir<=1; 
     end
  2'b11: 
     begin
     l_cp<=0;
      r_cp<=1;  
     l_dir<=1;
     r_dir<=0;
     end
  endcase


 if(dx==2000)
 begin
 cpl<=0;
 cpr<=0;
 dx<=0;
 end
 else 
 dx<=dx+1;
 

 if(dx==0)
 begin
  
   if(c_x==step_x-1)   
               begin
               c_x<=0;
               xys_state<=1;
               en_xy<=0;
               end
           else    c_x <= c_x +1;
 if(en_xy==1)
 begin
 dirl<=l_dir;
 dirr<=r_dir;
 cpl<=l_cp;
 cpr<=r_cp;
 end
end         

   end     
   
    
   endtask 

endmodule
