
`timescale 1ns / 1ps

module xiaoxiaxiahavenobf(clk,rst,start,cpl,cpr,dirl,dirr,C1,C2,pwm1,doutb,dinb,rstb,enb,addrb,web,web1,doutb1,dinb1,enb1,addrb1,d1,d2,d3,d4,d5);
input clk;    
input rst; 
input start;
input C1; 
input C2;
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
integer  first;
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
integer  finish1,finish2;
integer xx,yy,xxx,yyy;
integer stepxy;
integer stepx,stepy;
integer a1,b1,c1;   
reg[31:0] en_read,en_write;         
integer pread,pwrite;     
integer cnt_read;
integer finish0;

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
reg [15:0] mema0[0:94];  reg[15:0] mema1[0:94];
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
   reg [15:0] self_row;   
   reg [15:0] self_col;   
   reg [15:0] des_row;     
   reg [15:0] des_col;   
reg en_front;   
  reg en_behind;  
  integer step_x;  
  integer c_x;    
  integer x_state; 
   reg en_left; 
   reg en_right; //
   integer step_y;  //
   integer c_y; 
   integer y_state;

integer zdown_state;
reg[32:0] counter=0£»
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
       
 if((rst==1)&&(rst_en==1))
             begin 
          
                start_en<=1;
                start_s<=0;       
                rst_en<=0;
                addr=32'h7FFF_F000;  dinb=0;  rstb=0;  enb=0;  web=4'b0000;   

                cnt_mem=0;    qq=0;  qq1=0;         
  enb1=0; web=4'b0000;  cnt_mem1=0;addrb1=32'h40000000;   cnt_read=0;
            
   main_state<=Idle;
                  self_row<=16'd0;
                  self_col<=16'd0;
                 d5=1;

mema0[0][15:8]  = 8'd5;  mema0[0][7:0]  = 8'd55;
mema0[1][15:8]  = 8'd22; mema0[1][7:0]  = 8'd55;
mema0[2][15:8]  = 8'd34; mema0[2][7:0]  = 8'd43; 
mema0[3][15:8]  = 8'd22; mema0[3][7:0]  = 8'd55;
mema0[4][15:8]  = 8'd34; mema0[4][7:0]  = 8'd67;
mema1[0][15:8]  = 8'd22; mema1[0][7:0]  = 8'd55;
mema1[1][15:8]  = 8'd34; mema1[1][7:0]  = 8'd43;
mema1[2][15:8]  = 8'd34; mema1[2][7:0]  = 8'd36;
mema1[3][15:8]  = 8'd34; mema1[3][7:0]  = 8'd67;
mema1[4][15:8]  = 8'd34; mema1[4][7:0]  = 8'd74;
mema0[5][15:8]  = 8'd10; mema0[5][7:0]  = 8'd90;
mema0[6][15:8]  = 8'd5; mema0[6][7:0]  = 8'd105; 
mema0[7][15:8]  = 8'd10; mema0[7][7:0]  = 8'd105;
mema0[8][15:8]  = 8'd22; mema0[8][7:0]  = 8'd93;
mema0[9][15:8]  = 8'd10; mema0[9][7:0]  = 8'd105;
mema0[10][15:8] = 8'd22; mema0[10][7:0] = 8'd117;
mema0[11][15:8]  = 8'd26; mema0[11][7:0]  = 8'd95; 
mema0[12][15:8]  = 8'd26;mema0[12][7:0]  = 8'd100;
mema0[13][15:8]  = 8'd26; mema0[13][7:0]  = 8'd110; 
mema0[14][15:8]  = 8'd26; mema0[14][7:0]  = 8'd115;
mema1[5][15:8]  = 8'd10; mema1[5][7:0]  = 8'd120;
mema1[6][15:8]  = 8'd26; mema1[6][7:0]  = 8'd105;
mema1[7][15:8]  = 8'd22; mema1[7][7:0]  = 8'd93; 
mema1[8][15:8]  = 8'd22; mema1[8][7:0]  = 8'd88;
mema1[9][15:8]  = 8'd22; mema1[9][7:0]  = 8'd117; 
mema1[10][15:8] = 8'd22; mema1[10][7:0] = 8'd122;
mema1[11][15:8]  = 8'd31; mema1[11][7:0]  = 8'd90; 
mema1[12][15:8]  = 8'd31; mema1[12][7:0]  = 8'd100;
mema1[13][15:8]  = 8'd31; mema1[13][7:0]  = 8'd110; 
mema1[14][15:8]  = 8'd31; mema1[14][7:0]  = 8'd120;
mema0[15][15:8]  = 8'd53;mema0[15][7:0]  = 8'd42;
mema0[16][15:8]  = 8'd53;mema0[16][7:0]  = 8'd45;
mema0[17][15:8]  = 8'd46; mema0[17][7:0]  = 8'd45; 
mema0[18][15:8]  = 8'd75; mema0[18][7:0]  = 8'd40;
mema0[19][15:8]  = 8'd53; mema0[19][7:0]  = 8'd51; 
mema0[20][15:8]  = 8'd53; mema0[20][7:0]  = 8'd69;
mema0[21][15:8]  = 8'd64; mema0[21][7:0]  = 8'd69; 
mema0[22][15:8]  = 8'd45; mema0[22][7:0]  = 8'd62;
mema0[23][15:8]  = 8'd45; mema0[23][7:0]  = 8'd55; 
mema0[24][15:8]  = 8'd70; mema0[24][7:0]  = 8'd55;
mema0[25][15:8]  = 8'd70; mema0[25][7:0]  = 8'd73; 
mema1[15][15:8]  = 8'd53;mema1[15][7:0]  = 8'd45;
mema1[16][15:8]  = 8'd53; mema1[16][7:0]  = 8'd48;
mema1[17][15:8]  = 8'd70; mema1[17][7:0]  = 8'd45; 
mema1[18][15:8]  = 8'd64; mema1[18][7:0]  = 8'd51;
mema1[19][15:8]  = 8'd53; mema1[19][7:0]  = 8'd69; 
mema1[20][15:8]  = 8'd64; mema1[20][7:0]  = 8'd69;
mema1[21][15:8]  = 8'd62; mema1[21][7:0]  = 8'd67; 
mema1[22][15:8]  = 8'd62; mema1[22][7:0]  = 8'd62;
mema1[23][15:8]  = 8'd70; mema1[23][7:0]  = 8'd55; 
mema1[24][15:8]  = 8'd70; mema1[24][7:0]  = 8'd73;
mema1[25][15:8]  = 8'd66; mema1[25][7:0]  = 8'd73;
mema0[26][15:8]  = 8'd45; mema0[26][7:0]  = 8'd95;
mema0[27][15:8]  = 8'd45; mema0[27][7:0]  = 8'd115;
mema0[28][15:8]  = 8'd50; mema0[28][7:0]  = 8'd95;
mema0[29][15:8]  = 8'd55; mema0[29][7:0]  = 8'd95;
mema0[30][15:8] = 8'd58; mema0[30][7:0] = 8'd100;
mema0[31][15:8] = 8'd60; mema0[31][7:0] = 8'd100;
mema0[32][15:8] = 8'd58; mema0[32][7:0] = 8'd110; 
mema0[33][15:8] = 8'd60; mema0[33][7:0] = 8'd110;
mema0[34][15:8] = 8'd55; mema0[34][7:0] = 8'd105;
mema0[35][15:8] = 8'd64; mema0[35][7:0] = 8'd105;
mema0[36][15:8] = 8'd74; mema0[36][7:0] = 8'd95;
mema0[37][15:8] = 8'd64; mema0[37][7:0] = 8'd105;
mema0[38][15:8] = 8'd74; mema0[38][7:0] = 8'd114; 
mema1[26][15:8]  = 8'd45; mema1[26][7:0]  = 8'd115; 
mema1[27][15:8]  = 8'd55; mema1[27][7:0]  = 8'd115;
mema1[28][15:8]  = 8'd50; mema1[28][7:0]  = 8'd115; 
mema1[29][15:8]  = 8'd55; mema1[29][7:0]  = 8'd115;
mema1[30][15:8] = 8'd60; mema1[30][7:0] = 8'd100;
mema1[31][15:8] = 8'd63; mema1[31][7:0] = 8'd97;
mema1[32][15:8] = 8'd60; mema1[32][7:0] = 8'd110; 
mema1[33][15:8] = 8'd63; mema1[33][7:0] = 8'd113;
mema1[34][15:8] = 8'd64; mema1[34][7:0] = 8'd105;
mema1[35][15:8] = 8'd74; mema1[35][7:0] = 8'd95;
mema1[36][15:8] = 8'd74; mema1[36][7:0] = 8'd89;
mema1[37][15:8] = 8'd74; mema1[37][7:0] = 8'd114;
mema1[38][15:8] = 8'd74; mema1[38][7:0] = 8'd122;
mema0[39][15:8] = 8'd82; mema0[39][7:0] = 8'd80;
mema0[40][15:8] = 8'd82; mema0[40][7:0] = 8'd82; 
mema0[41][15:8] = 8'd84; mema0[41][7:0] = 8'd82;
mema0[42][15:8] = 8'd84; mema0[42][7:0] = 8'd80;
mema0[43][15:8] = 8'd86; mema0[43][7:0] = 8'd80;
mema1[39][15:8] = 8'd82; mema1[39][7:0] = 8'd82;
mema1[40][15:8] = 8'd84; mema1[40][7:0] = 8'd82; 
mema1[41][15:8] = 8'd84; mema1[41][7:0] = 8'd80;
mema1[42][15:8] = 8'd86; mema1[42][7:0] = 8'd80;
mema1[43][15:8] = 8'd86; mema1[43][7:0] = 8'd82;
mema0[44][15:8] = 8'd82; mema0[44][7:0] = 8'd90;
mema0[45][15:8] = 8'd82; mema0[45][7:0] = 8'd88;
mema0[46][15:8] = 8'd86; mema0[46][7:0] = 8'd88;
mema0[47][15:8] = 8'd86; mema0[47][7:0] = 8'd90;
mema1[44][15:8] = 8'd82; mema1[44][7:0] = 8'd88;
mema1[45][15:8] = 8'd86; mema1[45][7:0] = 8'd88;
mema1[46][15:8] = 8'd86; mema1[46][7:0] = 8'd90;
mema1[47][15:8] = 8'd82; mema1[47][7:0] = 8'd90;
mema0[48][15:8] = 8'd82;   mema0[48][7:0] = 8'd96; 
mema1[48][15:8] = 8'd86;  mema1[48][7:0] = 8'd96;
mema0[49][15:8] = 8'd84;   mema0[49][7:0] = 8'd104;
mema0[50][15:8] = 8'd82;   mema0[50][7:0] = 8'd104; 
mema0[51][15:8] = 8'd82;  mema0[51][7:0] = 8'd102;
mema0[52][15:8] = 8'd84;   mema0[52][7:0] = 8'd102; 
mema0[53][15:8] = 8'd84;   mema0[53][7:0] = 8'd104;
mema0[54][15:8] = 8'd86;  mema0[54][7:0] = 8'd104; 
mema0[55][15:8] = 8'd86;   mema0[55][7:0] = 8'd102;
mema1[49][15:8] = 8'd82;   mema1[49][7:0] = 8'd104; 
mema1[50][15:8] = 8'd82;  mema1[50][7:0] = 8'd102;
mema1[51][15:8] = 8'd84;  mema1[51][7:0] = 8'd102;
mema1[52][15:8] = 8'd84;  mema1[52][7:0] = 8'd104;
mema1[53][15:8] = 8'd86;  mema1[53][7:0] = 8'd104;
mema1[54][15:8] = 8'd86;  mema1[54][7:0] = 8'd102;
mema1[55][15:8] = 8'd84;  mema1[55][7:0] = 8'd102;
mema0[56][15:8] = 8'd84;   mema0[56][7:0] = 8'd110;
mema1[56][15:8] = 8'd85;  mema1[56][7:0] = 8'd110;
mema0[57][15:8] = 8'd82;   mema0[57][7:0] = 8'd116;
mema0[58][15:8] = 8'd82;  mema0[58][7:0] = 8'd118;
mema0[59][15:8] =8'd84; mema0[59][7:0] = 8'd118;
mema0[60][15:8] =8'd82; mema0[60][7:0] = 8'd116;
mema1[57][15:8] = 8'd82;  mema1[57][7:0] = 8'd118;
mema1[58][15:8] =8'd84; mema1[58][7:0] = 8'd118;
mema1[59][15:8] =8'd84; mema1[59][7:0] = 8'd116;
mema1[60][15:8] = 8'd86;  mema1[60][7:0] = 8'd116;
mema0[61][15:8] = 8'd82;  mema0[61][7:0] = 8'd124;
mema0[62][15:8] = 8'd82; mema0[62][7:0] = 8'd126;
mema0[63][15:8] = 8'd83;  mema0[63][7:0] = 8'd125;
mema1[61][15:8] = 8'd83;  mema1[61][7:0] = 8'd125;
mema1[62][15:8] = 8'd83; mema1[62][7:0] = 8'd125;
mema1[63][15:8] =8'd86; mema1[63][7:0] = 8'd125;
mema0[64][15:8] = 8'd82; mema0[64][7:0] = 8'd132;
mema0[65][15:8] = 8'd82; mema0[65][7:0] = 8'd132;
mema0[66][15:8] = 8'd86; mema0[66][7:0] = 8'd136;
mema1[64][15:8] = 8'd86; mema1[64][7:0] = 8'd132;
mema1[65][15:8] = 8'd86; mema1[65][7:0] = 8'd136;
mema1[66][15:8] = 8'd82; mema1[66][7:0] = 8'd136;
mema0[67][15:8] = 8'd82; mema0[67][7:0] = 8'd142;
mema0[68][15:8] = 8'd86; mema0[68][7:0] = 8'd142;
mema0[69][15:8] = 8'd86; mema0[69][7:0] = 8'd144;
mema0[70][15:8] = 8'd82;   mema0[70][7:0] = 8'd144; 
mema0[71][15:8] = 8'd85;   mema0[71][7:0] = 8'd143;
mema1[67][15:8] = 8'd86; mema1[67][7:0] = 8'd142;
mema1[68][15:8] = 8'd86; mema1[68][7:0] = 8'd144;
mema1[69][15:8] = 8'd82; mema1[69][7:0] = 8'd144;
mema1[70][15:8] = 8'd82;  mema1[70][7:0] = 8'd142;
mema1[71][15:8] = 8'd87;  mema1[71][7:0] = 8'd145;
mema0[72][15:8] = 8'd92; mema0[72][7:0] = 8'd78; 
mema1[72][15:8] = 8'd92;  mema1[72][7:0] = 8'd85;
mema0[73][15:8]=8'd90;mema0[73][7:0]=8'd88;
mema0[74][15:8]=8'd90;mema0[74][7:0]=8'd88;
mema0[75][15:8]=8'd90;mema0[75][7:0]=8'd90;
mema0[76][15:8]=8'd92;mema0[76][7:0]=8'd90;
mema0[77][15:8]=8'd92;mema0[77][7:0]=8'd90; 
mema0[78][15:8]=8'd94;mema0[78][7:0]=8'd90;
mema1[73][15:8]=8'd94;mema1[73][7:0]=8'd88;
mema1[74][15:8]=8'd90;mema1[74][7:0]=8'd90;
mema1[75][15:8]=8'd92;mema1[75][7:0]=8'd90;
mema1[76][15:8]=8'd92;mema1[76][7:0]=8'd88;
mema1[77][15:8]=8'd94;mema1[77][7:0]=8'd90;
mema1[78][15:8]=8'd94;mema1[78][7:0]=8'd88;
mema0[79][15:8] = 8'd90; mema0[79][7:0] = 8'd96;
mema0[80][15:8] = 8'd90; mema0[80][7:0] = 8'd98; 
mema0[81][15:8] = 8'd90; mema0[81][7:0] = 8'd97;
mema1[79][15:8] = 8'd91;  mema1[79][7:0] = 8'd97;
mema1[80][15:8] = 8'd91;  mema1[80][7:0] = 8'd97;
mema1[81][15:8] = 8'd94; mema1[81][7:0] = 8'd97;
mema0[82][15:8] = 8'd92; mema0[82][7:0] = 8'd101;
mema1[82][15:8] = 8'd92; mema1[82][7:0] = 8'd102;
mema0[83][15:8] = 8'd90; mema0[83][7:0] = 8'd108;
mema0[84][15:8] = 8'd94; mema0[84][7:0] = 8'd108;
mema0[85][15:8] = 8'd94; mema0[85][7:0] = 8'd110;
mema0[86][15:8] = 8'd94; mema0[86][7:0] = 8'd110;
mema0[87][15:8] = 8'd94; mema0[87][7:0] = 8'd112;
mema1[83][15:8] = 8'd94; mema1[83][7:0] = 8'd108;
mema1[84][15:8] = 8'd94; mema1[84][7:0] = 8'd110;
mema1[85][15:8] = 8'd90; mema1[85][7:0] = 8'd110;
mema1[86][15:8] = 8'd94; mema1[86][7:0] = 8'd112;
mema1[87][15:8] = 8'd90; mema1[87][7:0] = 8'd112;
mema0[88][15:8] = 8'd90; mema0[88][7:0] = 8'd118;
mema0[89][15:8] = 8'd90; mema0[89][7:0] = 8'd118;
mema1[88][15:8] = 8'd94; mema1[88][7:0] = 8'd118;
mema1[89][15:8] = 8'd90; mema1[89][7:0] = 8'd120;
mema0[90][15:8] = 8'd90; mema0[90][7:0] = 8'd120;
mema1[90][15:8] = 8'd94; mema1[90][7:0] = 8'd120;
mema0[91][15:8] = 8'd92; mema0[91][7:0] = 8'd118;
mema1[91][15:8] = 8'd92; mema1[91][7:0] = 8'd120;
mema0[92][15:8] = 8'd90; mema0[92][7:0] = 8'd126;
mema1[92][15:8] = 8'd94; mema1[92][7:0] = 8'd126;
mema0[93][15:8] = 8'd90; mema0[93][7:0] = 8'd132;
mema0[94][15:8] = 8'd90; mema0[94][7:0] = 8'd133;

mema1[93][15:8] = 8'd90; mema1[93][7:0] = 8'd135;
mema1[94][15:8] = 8'd94; mema1[94][7:0] = 8'd133;
ok=0;
finish0=0;
first=1;
en_read=0; en_write=1; 
desx_to10=0;  desy_to10=0;
selfx_to10=0; selfy_to10=0; 
stepx=0;stepy=0;stepxy=0;
xx=0;yy=0;xxx=0;yyy=0;
finish1=0; finish2=0;
a1=0;   b1=0;  c1=0;

state_1=0;       
judge_1=0;
d1=0;
d2=0;
d3=0;
d4=0;
en_button1=1;
cnt_button=0;

mx<=0;
game_end<=0;
l_cp<=0;
r_cp<=0;
r_dir<=0;
l_dir<=0;
xys_state<=0;
xy_state<=0;
en_xy<=1;data=0;
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
zdown_state<=0;
  counter<=0;
  counter1<=0;
  counterd<=0;
  counterd1<=0;
     end         
 
 else if((start==1)&&(start_en==1))
 begin
    start_s<=1;    game_end<=0;  start_en<=0; d5=0;
 end
 
else if ((game_end==0)&&(start_s==1))                // 
 begin
     d5=0;
    rst_en<=1;
   if(judge_1==0)
    begin
             if((C1==1)&&(en_button1==1))  
             begin 
                         en_button1<=2;
                         state_1=state_1+1; 
                 if(state_1==1)  begin d1=1; d2=0;d3=0;end
                 else if(state_1==2)  begin d2=1;d1=0;d3=0;end
                  else if(state_1==3)  begin d3=1;d1=0;d2=0; end  
                  else if(state_1==4)  begin d3=0;d1=0;d2=0; end 
              end
              else if(en_button1==2)    begin     if(cnt_button==50000)  begin en_button1<=0; cnt_button<=0; end  else cnt_button<=cnt_button+1;          end
              else if((C1==0)&&(en_button1==0))  en_button1<=1;
              if(C2==1) 
               begin   judge_1<=1;  end
 
     end 
   
 else if(judge_1==1)
 begin
        if(state_1==2)
         begin
               enb=1;
                if(cnt_mem==0) begin   addrb=addr;  addr=addr+32'h0000_0004; cnt_mem =1; end
               else if(cnt_mem==1)  cnt_mem=2;
               else if(cnt_mem==2)  cnt_mem=3;
                else if(cnt_mem==3)
                begin
                         if(qq<=79)
                            begin
                                if(qq1==0)
                                  begin   zancun1[31:0]=doutb;  qq1=1; end
                                else if(qq1==1)
                                     begin   zancun2[31:0]=doutb;  qq1=2; end
                                 else if(qq1==2)
                                      begin   zancun3[31:0]=doutb;  qq1=3; end
                                 else if(qq1==3)
                                         begin   zancun4[31:0]=doutb;  qq1=4; end
                                  else if(qq1==4)
                                         begin   zancun5[31:0]=doutb;  qq1=0; 
                                          mema[qq]={zancun1[31:0],zancun2[31:0],zancun3[31:0],zancun4[31:0],zancun5[31:0]};
                                               qq<=qq+1;
                                           end
                             cnt_mem=0;  
                               end          
                        else begin   judge_1=2;  d4=1;  zdown_state=0;   self_row=0;self_col=0; ok=0;end                        
           end
        end
        else if((state_1==1)||(state_1==3))
       begin    judge_1=2;  zdown_state=0;ok=0; self_row=0;self_col=0; end    
       else if(state_1==4)
       begin
       judge_1=2;  zdown_state=0;ok=0; self_row=0;self_col=0;
              mema0[0][15:8]  = 8'd8;  mema0[0][7:0]  = 8'd13; mema0[1][15:8]  = 8'd12; mema0[1][7:0]  = 8'd24;
              mema0[2][15:8]  = 8'd12; mema0[2][7:0]  = 8'd24; mema0[3][15:8]  = 8'd12; mema0[3][7:0]  = 8'd57;
              mema0[4][15:8]  = 8'd16; mema0[4][7:0]  = 8'd24; mema0[5][15:8]  = 8'd20; mema0[5][7:0]  = 8'd24;
              mema0[6][15:8]  = 8'd1;  mema0[6][7:0]  = 8'd39; mema0[7][15:8]  = 8'd20; mema0[7][7:0]  = 8'd39;
              mema0[8][15:8]  = 8'd31; mema0[8][7:0]  = 8'd28; mema0[9][15:8]  = 8'd20; mema0[9][7:0]  = 8'd39;
              mema0[10][15:8] = 8'd31; mema0[10][7:0] = 8'd50;
              
              mema1[0][15:8]  = 8'd8;  mema1[0][7:0]  = 8'd65; mema1[1][15:8]  = 8'd20; mema1[1][7:0]  = 8'd24;
              mema1[2][15:8]  = 8'd12; mema1[2][7:0]  = 8'd57; mema1[3][15:8]  = 8'd20; mema1[3][7:0]  = 8'd57; 
              mema1[4][15:8]  = 8'd16; mema1[4][7:0]  = 8'd57; mema1[5][15:8]  = 8'd20; mema1[5][7:0]  = 8'd57;
              mema1[6][15:8]  = 8'd34; mema1[6][7:0]  = 8'd39; mema1[7][15:8]  = 8'd31; mema1[7][7:0]  = 8'd28;
              mema1[8][15:8]  = 8'd31; mema1[8][7:0]  = 8'd18; mema1[9][15:8]  = 8'd31; mema1[9][7:0]  = 8'd50; 
              mema1[10][15:8] = 8'd31; mema1[10][7:0] = 8'd60;

              
              
              mema0[11][15:8]  = 8'd13;  mema0[11][7:0]  = 8'd100; mema0[12][15:8]  = 8'd1; mema0[12][7:0]  = 8'd121;
              mema0[13][15:8]  = 8'd20; mema0[13][7:0]  = 8'd121; mema0[14][15:8]  = 8'd33; mema0[14][7:0]  = 8'd108;
              mema0[15][15:8]  = 8'd20; mema0[15][7:0]  = 8'd121; mema0[16][15:8]  = 8'd33;  mema0[16][7:0]  = 8'd134;
              
              mema1[11][15:8]  = 8'd13; mema1[11][7:0]  = 8'd142; mema1[12][15:8]  = 8'd20; mema1[12][7:0]  = 8'd121;
              mema1[13][15:8]  = 8'd33; mema1[13][7:0]  = 8'd108; mema1[14][15:8]  = 8'd33; mema1[14][7:0]  = 8'd101;
              mema1[15][15:8]  = 8'd33; mema1[15][7:0]  = 8'd134; mema1[16][15:8]  = 8'd33; mema1[16][7:0]  = 8'd141;
              
              mema0[17][15:8]  = 8'd50; mema0[17][7:0]  = 8'd22; mema0[18][15:8]  = 8'd50; mema0[18][7:0]  = 8'd22;
              mema0[19][15:8]  = 8'd50; mema0[19][7:0]  = 8'd59; mema0[20][15:8]  = 8'd56; mema0[20][7:0]  = 8'd22;
              mema0[21][15:8]  = 8'd62; mema0[21][7:0]  = 8'd22; mema0[22][15:8]  = 8'd41; mema0[22][7:0]  = 8'd39;
              mema0[23][15:8]  = 8'd70; mema0[23][7:0]  = 8'd39; mema0[24][15:8]  = 8'd70; mema0[24][7:0]  = 8'd75;
              
              mema1[17][15:8]  = 8'd62; mema1[17][7:0]  = 8'd22; mema1[18][15:8]  = 8'd50; mema1[18][7:0]  = 8'd59;
              mema1[19][15:8]  = 8'd62; mema1[19][7:0]  = 8'd59; mema1[20][15:8]  = 8'd56; mema1[20][7:0]  = 8'd59;
              mema1[21][15:8]  = 8'd62; mema1[21][7:0]  = 8'd59; mema1[22][15:8]  = 8'd70; mema1[22][7:0]  = 8'd39;
              mema1[23][15:8]  = 8'd70; mema1[23][7:0]  = 8'd75; mema1[24][15:8]  = 8'd63; mema1[24][7:0]  = 8'd75;
              
              mema0[25][15:8]  = 8'd46; mema0[25][7:0]  = 8'd113; mema0[26][15:8]  = 8'd46; mema0[26][7:0]  = 8'd130;
              mema0[27][15:8]  = 8'd55; mema0[27][7:0]  = 8'd121; mema0[28][15:8]  = 8'd71; mema0[28][7:0]  = 8'd121;
              mema0[29][15:8]  = 8'd56; mema0[29][7:0]  = 8'd105;  mema1[25][15:8]  = 8'd46; mema1[25][7:0]  = 8'd130;
              mema1[26][15:8]  = 8'd55; mema1[26][7:0]  = 8'd121; mema1[27][15:8]  = 8'd71; mema1[27][7:0]  = 8'd121;
              mema1[28][15:8]  = 8'd65; mema1[28][7:0]  = 8'd117; mema1[29][15:8]  = 8'd56; mema1[29][7:0]  = 8'd137;

       end
 end
 
 
else if(judge_1==2)
 begin
 
 case(main_state)
 Idle: 
 begin  
 des_row<=16'd0;des_col<=16'd0;
 enb1=1; web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000001; 
  if(zdown_state)         begin z_up; countera = countera + 1;
                                if(countera ==64'd1000000)    begin lala=1;countera=0;end end  
  if(!x_state)            begin x_step;end
  if((mx==1)&&(!y_state)) begin y_step;end                                                                                     
  if((!zdown_state) && (x_state) && (y_state)) begin main_state<=Scan; x_state<=0; y_state<=0; end
  else begin  main_state<=Idle;end                             
 //if((!zdown_state) && (x_state) && (y_state)) begin main_state<=Scan; x_state<=0; y_state<=0; end
end

 Scan:
 begin   
 enb1=0;    
 if(state_1==2)    
 begin    

 if(!data) 
 begin    
 row=mema[x];data=row[159-y];                  
 if(y<159)                begin y<=y+1;x<=x;   end
 else if(y==159 && x<79)  begin y<=0;  x<=x+1; end
 else if(y==159 && x==79) begin x<=0;  y<=0;   game_end <=1;end end  
 else if(data) 
 begin
row1=mema[x];   data44=row1[159-(y-2)]; data66=row1[159-(y)];
  row2=mema[x-1]; data11=row2[159-(y-2)]; data22=row2[160-y]; data33=row2[159-(y)];                    
  row3=mema[x+1]; data77=row3[159-(y-2)]; data88=row3[160-y]; data99=row3[159-(y)];
 if(!data11 && !data22 && !data33 && !data44 && !data66 && !data77 && !data88 && !data99)   begin data =0; end

 else 
 begin
     des_row<=x; des_col<=y-1;         
                                           
     if(!x_state)  begin x_step;end
     if((mx==1)&&(!y_state))  begin y_step; end                                            
     if((!zdown_state)&& x_state && y_state) begin  z_down; countera = countera + 1; 
                                                     if(countera ==64'd1000000) begin lala=0;countera=0; end   end  end
 end
 
 if((zdown_state) && (x_state) &&(y_state))
  begin          

 main_state<=Write; x_state<=0; y_state<=0;

 row[159-y+1]=0;  mema[x]=row;   data=0;  x<=x; y<=y-1; end
 
 else begin main_state<=Scan;end  
 end      

 else if((state_1==1)||(state_1==4))
 begin
 if(state_1==1) 
 begin
 if(c1<95)
  begin
   selfx_to10=mema0[c1][8]+mema0[c1][9]*2+mema0[c1][10]*4+mema0[c1][11]*8+mema0[c1][12]*16+mema0[c1][13]*32+mema0[c1][14]*64;
   selfy_to10=mema0[c1][0]+mema0[c1][1]*2+mema0[c1][2]*4+mema0[c1][3]*8+mema0[c1][4]*16+mema0[c1][5]*32+mema0[c1][6]*64+mema0[c1][7]*128;
   desx_to10=mema1[c1][8]+mema1[c1][9]*2+mema1[c1][10]*4+mema1[c1][11]*8+mema1[c1][12]*16+mema1[c1][13]*32+mema1[c1][14]*64;
   desy_to10=mema1[c1][0]+mema1[c1][1]*2+mema1[c1][2]*4+mema1[c1][3]*8+mema1[c1][4]*16+mema1[c1][5]*32+mema1[c1][6]*64+mema1[c1][7]*128;
   c1=c1+1;
   main_state=Write;
  end
 else  game_end=1;
 end

 else 
 begin 
 
 if(c1<30)
   begin
    selfx_to10=mema0[c1][8]+mema0[c1][9]*2+mema0[c1][10]*4+mema0[c1][11]*8+mema0[c1][12]*16+mema0[c1][13]*32+mema0[c1][14]*64;
    selfy_to10=mema0[c1][0]+mema0[c1][1]*2+mema0[c1][2]*4+mema0[c1][3]*8+mema0[c1][4]*16+mema0[c1][5]*32+mema0[c1][6]*64+mema0[c1][7]*128;
    desx_to10=mema1[c1][8]+mema1[c1][9]*2+mema1[c1][10]*4+mema1[c1][11]*8+mema1[c1][12]*16+mema1[c1][13]*32+mema1[c1][14]*64;
    desy_to10=mema1[c1][0]+mema1[c1][1]*2+mema1[c1][2]*4+mema1[c1][3]*8+mema1[c1][4]*16+mema1[c1][5]*32+mema1[c1][6]*64+mema1[c1][7]*128;
    c1=c1+1;
    main_state=Write;
   end
  else  game_end=1;
     
 end
 end
 
 else    //state_1==3
     begin 
                    if((en_read==0))
                         begin
                         
                            if(cnt_read==0) begin   addrb=addr+32'b00000000_00000000_00000000_00010000; enb=1;web=4'b0000;  cnt_read =1; end
                            else if(cnt_read==1)  cnt_read=2;
                            else if(cnt_read==2)  cnt_read=3;
                             else if(cnt_read==3) begin     en_read=doutb;     enb=0; cnt_read=0;  end
                          end
                     
                   if(en_read==1)
                         begin       enb1=1; web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000000;   
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
                                            main_state=Write;
                                            cnt_mem=0; en_read=0; enb=0; 
                                            pread=0;
                                            enb1=1; web1=4'b0001; dinb1=32'b00000000_00000000_00000000_00000001;
                                            if((desx_to10==0)&&(desy_to10==0))  game_end=1; 
                                            end   
                                      end    
                                              
      end       
 end                 
 
 
 
 Write:  begin         
  if(state_1==2)     
  begin                          
 if((!data1) &&(!data2) && (!data3) && (!data4) && (!data6) && (!data7) && (!data8) && (!data9) &&(!data_flag)) begin

 row1=mema[x];   data4=row1[159-(y-1)]; data6=row1[159-(y+1)];
 row2=mema[x-1]; data1=row2[159-(y-1)]; data2=row2[159-y]; data3=row2[159-(y+1)];                    
 row3=mema[x+1]; data7=row3[159-(y-1)]; data8=row3[159-y]; data9=row3[159-(y+1)];
 data_flag<=1; 
 end
 else   
 begin
  if(data6) 
      begin
          des_row=x; des_col=y+1;
          if(!y_state) begin y_step;end
          if(y_state) begin
             main_state<=Write; y_state<=0;
             row1[159-(y+1)]=0; mema[x]=row1;
             data4=0;data6=0;data1=0;data2=0;data7=0;data8=0;data9=0;
             data3=0;data_flag<=0;                                                                                          
             self_row<=x;self_col<=y+1;
             x<=x;y<=y+1;end
          else main_state<=Write;end    
 
  else if(data4) 
                                 begin
                                                          des_row=x; des_col=y-1;
                                                          if(!y_state) begin y_step;end
                                                          if(y_state)  begin
                                                             main_state<=Write; y_state<=0;
                                                             row1[159-(y-1)]=0; mema[x]=row1;
                                                             data4=0;data1=0;data2=0;data7=0;data8=0;data9=0;
                                                              data3=0;data_flag<=0;                                                                                     
                                                             self_row<=x;self_col<=y-1;
                                                             x<=x;y<=y-1;end
                                                           else main_state<=Write; end   
 
 else if(data8)  
 begin  
 mx=0;    
 des_row=x+1; des_col=y;                  
 if(!x_state) begin  x_step;end
 if(x_state) begin
 main_state<=Write;                              
 x_state<=0;                             
 row3[159-y]=0; mema[x+1]=row3;
 data8=0; data7=0;   data9=0; data1=0; data2=0; data3=0; 
   data_flag<=0;                                  
 self_row<=x+1; self_col<=y;
 x<=x+1; y<=y; end
 else main_state<=Write;
 end                 
 
  else if(data2)
                            begin 
                           mx=0; 
                                     des_row=x-1;des_col=y;                                     
                                     if(!x_state)begin x_step;end
                                     if(x_state) begin
                                          main_state<=Write; x_state<=0;                                     
                                          row2[159-y]=0;mema[x-1]=row2;
                                   data7=0;   data9=0; data1=0; data2=0; data3=0;data_flag<=0;                                                         
                                          self_row<=x-1;self_col<=y;
                                          x<=x-1;y<=y;end
                                     else main_state<=Write;end 
                                     
 else if(data9) 
 begin                                                       
          if(!xys_state) begin
           xy_state=2'b10; xy_step; end
          if(xys_state==1) begin
           main_state<=Write;
           xys_state<=0;en_xy<=1; 
           row3[159-(y+1)]=0; mema[x+1]=row3;
           data9=0;data1=0;  
           data3=0;
          data7=0;data_flag<=0;  
           self_row<=x+1;self_col<=y+1;
           des_row<=x+1;des_col<=y+1;
           x<=x+1;y<=y+1;end
       else main_state<=Write;end                 
 else   if(data7)
  begin      
 if((!xys_state))  begin   
    xy_state=2'b11;
    xy_step;end
 if(xys_state==1)  begin
     main_state<=Write;                              
     xys_state<=0; en_xy<=1;       
     row3[159-(y-1)]=0; 
     mema[x+1]=row3;
     data7=0;     
data1=0; data3=0;
     data_flag<=0;                           
   self_row<=x+1; self_col<=y-1;
     des_row<=x+1; des_col<=y-1;
    x<=x+1; y<=y-1;   end
 else main_state<=Write;end 
 
 
                             
                           else if(data3)
                             begin                                     
                                     if(!xys_state) begin  xy_state=2'b00;xy_step;end
                                     if(xys_state)  begin 
                                         main_state<=Write;en_xy<=1; xys_state<=0;
                                         row2[159-(y+1)]=0;mema[x-1]=row2;
                                        data3=0;data1=0; data_flag<=0;                                                   
                                         self_row<=x-1;self_col<=y+1;
                                         des_row<=x-1;des_col<=y+1;
                                         x<=x-1;y<=y+1;end
                                      else main_state<=Write;end     
                           
                           else if(data1) 
                            begin            
                                      if(!xys_state) begin  xy_state=2'b01; xy_step; end
                                      if(xys_state)  begin
                                           main_state<=Write;xys_state<=0;en_xy<=1; 
                                           row2[159-(y-1)]=0;mema[x-1]=row2;
                                           data1=0;data_flag<=0;  
                                           des_row<=x-1;des_col<=y-1;
                                           self_row<=x-1;self_col<=y-1;
                                           x<=x-1;y<=y-1;end
                                       else main_state<=Write;end    
                        
                            else  begin                                                                                
                                       if(zdown_state) begin 
                                               z_up; countera = countera + 1;
                                               if(countera ==64'd1000000)   begin  lala=1;countera=0;  end end
                                       if((!zdown_state))  begin   
                                               main_state<=Scan;
                                               data_flag<=0;
                                               x<=0;y<=0; end  end   
 end  
 end  

 else        

 begin
  if(finish1==0)
        begin
        if((self_row==selfx_to10)&&(self_col==selfy_to10))   begin finish1=1; finish2=0; x_state=0; y_state=0; main_state=Write; first=0; finish0=0;   end
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
         if(!xx && !yy) begin main_state<=Scan; finish1<=0; end  
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

       
       
       end 

      else if(finish2==1)
        begin     
           finish1=0;    finish2=0;  main_state=Scan;  
   
        end  

       
     
 end

 
 
  end 

 
 
 default:  main_state<=Idle;
 endcase
 end
end  
 else if(game_end==1)      
  begin
  des_row<=0;
  des_col<=0;
  d5=0;
   if(zdown_state)         begin z_up; countera = countera + 1;
                                 if(countera ==64'd1000000)    begin lala=1;countera=0;end end  
   else 
   begin
   if(!x_state)            begin x_step;end
   if((mx==1)&&(!y_state)) begin y_step;end                  
   end                                                                   
 
  end        
end
task z_up; 
begin
counterd = 0; counterd1 = 0; counter = counter + 1;
if(counter ==32'd100)      begin counter <= 0; counter1<= counter1 + 1; end
if(counter1 == 8'd1)       begin pwm1<= 1;end
else if(counter1==8'd10)   begin pwm1<= 0;end
else if(counter1==64'd300) begin counter1<=0; if (lala==1) begin  zdown_state<=0;end end end
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