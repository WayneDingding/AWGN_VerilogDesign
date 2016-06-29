module Sqrt( clk,rst, sqrt_in, sqrt_out);
  parameter B_x_f_a=6;
  parameter Bus_size=31;
  input   clk,rst;
  input   [30:0] sqrt_in;
  output reg [16:0] sqrt_out;
  reg     [36:0] e_f;
  reg     [31:0] x_ff;
  reg     [31:0] x_f;
  reg     [7:0]  x_f_xa;
  reg     [23:0] x_f_xb;
  reg     [6:0]  index;
  reg     [11:0] C11_f;
  reg     [20:0] C00_f;
  reg     [29:0] y_f;
  reg     [5:0]  exp_ff;
  reg     [5:0]  exp_f;
  reg     [30:0] temp[128*2-1:0];
  reg     [11:0] C1_f[127:0];
  reg     [19:0] C0_f[127:0];
  reg     [47:0] yftemp;
  integer i;
  integer   calc;
  
initial

begin
  $readmemb("Cf.dat",temp,0,128*2-1);
  for (i=0;i<128;i=i+1)
  begin
    C1_f[i]=temp[i];
    C0_f[i]=temp[i+128];
  end
end
always @( posedge clk or negedge rst)begin
    if(!rst)
      e_f<= 31'b0;  
    else
      e_f<= sqrt_in<<6;
end

  always @( posedge clk )begin
    calc <=1'd0;
    for(i=36;i>0;i=i-1)begin
     if (e_f[i]==0) 
        calc=calc+1;
     else i=0;
    end
    
    if(calc>5)
     	begin 
        exp_f = calc-5;//5-calc
        x_ff  = e_f<<exp_f;
      end
    else
      begin
        exp_f = 5-calc;
        x_ff  = e_f>>exp_f;
      end
    x_f   = exp_f[0]? x_ff/2: x_ff;

    x_f_xa  = x_f[31:24];
    x_f_xb  = x_f[23:0];
    index   = x_f_xa[5:0]*exp_f[0]+(x_f_xa[6:1]+7'b1000000)*(1-exp_f[0]);
    C11_f   = C1_f[index];
    yftemp   = C1_f[index]*x_f_xa<<2;
    C00_f   =  yftemp+C0_f[index];
    yftemp  = (C11_f*x_f_xb)>>22;
    y_f     = yftemp+C00_f;

    if (calc>5)
    begin 
      exp_ff    = (exp_f-exp_f[0])>>1;
      yftemp  =y_f>>(exp_ff);
    end
    else
      begin
      exp_ff    = (exp_f+exp_f[0])>>1;
      yftemp  = y_f<<(exp_ff);
    end
    sqrt_out =  yftemp[23:7];
  end
endmodule