//This model is use for evaluate Sin & Cos 
module Sincos(clk,rst, sincos_in, sincos_out01, sincos_out02);
  parameter B_x_g_aa=7;
  parameter B_x_g_ba=7;
  input   clk,rst;
  input   [15:0] sincos_in;
  output  reg [15:0] sincos_out01, sincos_out02;
  reg     [15:0] sincos_out11, sincos_out22; 
  reg     [15:0] sincos_out1, sincos_out2;
  reg     [1:0]  quad; 
  reg     [13:0] x_g_a;
  reg     [13:0] x_g_b;
  reg     [6:0]  x_g_a_xa;
  reg     [6:0]  x_g_a_xb;
  reg     [6:0]  x_g_b_xa;
  reg     [6:0]  x_g_b_xb;
  reg     [6:0]  index_a;
  reg     [18:0] C11_g_a;//000000+19FB 
  reg     [25:0] C00_g_a;//1IB+25FB
  reg     [31:0] y_g_a,y_g_a1,y_g_a2;//15FB
  reg     [6:0]  index_b;
  reg     [18:0] C11_g_b;//19FB
  reg     [25:0] C00_g_b;//1IB+25FB
  reg     [31:0] y_g_b,y_g_b1,y_g_b2;//15FB
  reg     [7:0]  i;
  reg     [18:0] temp[128*2-1:0];
  reg     [18:0] C1_g[127:0];//1IB+18FB
  reg     [17:0] C0_g[127:0];//18FB
//read in Coefficient matrix  
  initial
    begin
      $readmemb("Cg.dat",temp,0,128*2-1);
    for (i=0;i<128;i=i+1)
    begin
      C1_g[i]=temp[i];
      C0_g[i]=temp[i+128];
    end
end
  

//Range reduction
  always @( posedge clk or negedge rst)begin
    if(!rst)
      begin
        sincos_out1<=16'b0;
        sincos_out2<=16'b0;
      end
    else
      begin
        quad     = sincos_in[15:14];
        x_g_a    = sincos_in[13:0];
        x_g_b    = 14'h3fff-x_g_a;
//Approximate sin/cos
//for part-a
        x_g_a_xa  = x_g_a[13:7];
        x_g_a_xb  = x_g_a[6:0];
        index_a   = x_g_a_xa; 
        C11_g_a   = C1_g[index_a];
        C00_g_a   = C1_g[index_a]*x_g_a_xa+C0_g[index_a]*8'h80;
        y_g_a     = (C11_g_a*x_g_a_xb+C00_g_a*8'h80)>>17;

//for part-b
        x_g_b_xa  = x_g_b[13:7];
        x_g_b_xb  = x_g_b[6:0];
        index_b   = x_g_b_xa; 
        C11_g_b   = C1_g[index_b];
        C00_g_b   = C1_g[index_b]*x_g_b_xa+C0_g[index_b]*8'h80;  
        y_g_b     = (C11_g_b*x_g_b_xb+C00_g_b*8'h80)>>17;
      end
  end

//Range reconstruction
  always@*begin
    case (quad)
    2'b00: begin 
      sincos_out1  = y_g_b;  
      sincos_out2  = y_g_a;
        end 
    2'b01: begin 
      sincos_out1  = y_g_a;  
      sincos_out2  = ~y_g_b+1;
        end
    2'b10: begin 
      sincos_out1  = ~y_g_b+1; 
      sincos_out2  = ~y_g_a+1;
        end
    2'b11: begin 
      sincos_out1  = ~y_g_a+1; 
      sincos_out2  = y_g_b; 
        end 
    default;
  endcase
  end   
//2 clock cycle delay to match with the output of sqrt.v
  always @( posedge clk )
    begin
      sincos_out11 <= sincos_out1;  
      sincos_out22 <= sincos_out2 ; 
      sincos_out01 <= sincos_out11;  
      sincos_out02 <= sincos_out22 ; 
    end

endmodule
  
