module Log( clk, rst, log_in, log_out);
parameter ln2  = 32'hB17217F7 ;
parameter Bus_size   = 48 -1  ;
parameter B_x_e_a  = 8 ; 
parameter datasize = 254;  
parameter Bus_size_out=69 -1;
  input   clk,rst;
  input   [Bus_size:0]  log_in;
  output reg [30:0]     log_out; //35bits>>4--->31bits
 // output reg [Bus_size_out:0]   eetemp  ;
  reg     [Bus_size+1:0] x_e;  //49,48
  reg     [B_x_e_a:0] x_e_xa;
  reg     [39:0] x_e_xb;
  reg     [B_x_e_a-1:0] index;
  reg     [28:0] C22_e;//(29FB)13FB 
  reg     [31:0] C11_e;//1 sign bit+1IB+22FB
  reg     [31:0] C00_e;//1 sign bit+1IB+30FB
  reg     [31:0] y_e;//1 sign bit+1IB+30FB
  reg     [37:0] ee;
  reg     [69:0] etemp;
  reg     [30:0] temp[256*3-1:0];
  reg     [12:0] C2_e[255:0];//13FB
  reg     [23:0] C1_e[255:0];//1sign bit +1IB+22FB
  reg     [30:0] C0_e[255:0];//1IB+30FB
  integer i,calc;
  
initial
begin
  $readmemb("Ce.dat",temp,0,256*3-1);
  for (i=0;i<256;i=i+1)
  begin
    C2_e[i]=temp[i];
    C1_e[i]=temp[i+256];
    C0_e[i]=temp[i+512];
  end
end


//Range Reduction
/*exp_e =LZD(u0)+1;
x_e   =u0.*2.^exp_e;
*/
  always @( posedge clk or negedge rst)begin
    if(!rst)begin
      log_out<=32'b0;
    end
    else
    begin
    calc =0;
    for(i=47;i>0;i=i-1)begin
     if (log_in[i]==0)
      calc=calc+1;
     else i=0;
    end
    x_e = log_in<<(calc+1);
    
//Approximate -ln(x_e) where x_e=[1,2)
//Degree-2 piecewise polynomial
/*
//x_e_xa =floor(x_e/2^(48-B_x_e_a))/2^(B_x_e_a);
//x_e_xb =(x_e-x_e_xa*2^48)/2^(48-B_x_e_a);%%

xexa=x_e_xa*2^(B_x_e_a)-256;

C22_e =C2_e(xexa+1)/(4^B_x_e_a);   
C11_e=(2*C2_e(xexa+1).*x_e_xa+C1_e(xexa+1))/(2^B_x_e_a);    
C00_e=C2_e(xexa+1).*x_e_xa.^2+C1_e(xexa+1).*x_e_xa+C0_e(xexa+1);
y_e   =floor((((C22_e.*x_e_xb)+C11_e).*x_e_xb+C00_e)*2^27)/2^27;
*/
  x_e_xa = x_e[Bus_size+1:1+Bus_size-B_x_e_a];
  x_e_xb = x_e[Bus_size-B_x_e_a:0];
  index  = x_e_xa[B_x_e_a-1:0];

  C22_e  = {16'b0,C2_e[index]};  
  C11_e  =32'hFF000000+C2_e[index]*x_e_xa*4 + C1_e[index];
  
  C00_e  = C2_e[index]*x_e_xa*x_e_xa*2+(32'hff000000+C1_e[index])*x_e_xa+C0_e[index];
  
  etemp  = (C22_e*x_e_xb)>>39;
  etemp  = ((72'hffffffffff00000000+etemp+C11_e)*x_e_xb)>>40;
  y_e    = etemp+C00_e;
 /*  
%range reconstruction
ln2   =floor(log(2)*2^32)/2^32;
ee    =floor(exp_e*ln2*2^28)/2^28;
e     =floor((ee+y_e)*2*2^24)/2^24;
if e<0
    e=0;
end
*/  
  ee      = ((calc+1)*ln2)>>5;
  etemp   = ({ee,3'b0}+{7'b1111111,y_e})*2;
  log_out = etemp[36:6];
//  eetemp  = log_out;
  
  end 
end
endmodule