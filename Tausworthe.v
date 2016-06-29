//Tausworthe module is 32 bit width random number generater
module Tausworthe(clk,rst,t0,t1,t2,t_out);
  parameter Bus_size=32-1;
  input  clk,rst;
  input  [Bus_size:0] t0,t1,t2;
  output reg[Bus_size:0]  t_out;
  
  reg  [Bus_size:0] tmp0;
  reg  [Bus_size:0] tmp1;
  reg  [Bus_size:0] tmp2;
  reg    [Bus_size*2:0] tmp;
  reg   [Bus_size:0] b;
  
//  assign tmp0=t0;
  //assign tmp1=t1;
  //assign tmp2=t2;
always @( posedge clk or negedge rst)begin
    if(!rst)begin
      tmp0<=32'b0;
      tmp1<=32'b0;
      tmp2<=32'b0;
    end
    else

  begin
  tmp0=t0;
  tmp1=t1;
  tmp2=t2;
//s0 
    tmp  = tmp0<<13;
    b    = (tmp^tmp0)>>19;
    tmp  = (tmp0 & 32'hFFFFFFFE)<<12;
    tmp0   = tmp^b;
//s1
    tmp  = tmp1<<2;
    b    = (tmp^tmp1)>>25;
    tmp  = (tmp1 & 32'hFFFFFFF8)<<4;
    tmp1   = tmp^b;
//s2    
    tmp  = tmp2<<3;
    b    = (tmp^tmp2)>>11;
    tmp  = (tmp2 & 32'hFFFFFFF0)<<17;
    tmp2   = tmp^b;
//out
    t_out=tmp0^tmp1^tmp2;
end
end
endmodule 