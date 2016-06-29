//This model is use for multiply 
module Mult(clk,mult_in1, mult_in2,mult_out);
  input   clk;
  input   [16:0] mult_in1;
  input   [15:0] mult_in2;
  output  reg [15:0] mult_out;
  
  reg     [32:0] x;
  reg     [32:0] tmp; 
 
always @(posedge clk) 
  begin
   x = mult_in2[15]?33'h1ffff0000+mult_in2:mult_in2;//detect sign bit
   tmp      = mult_in1*x;
   mult_out = tmp[32:17];//output(5IB+11FB)  
  end
endmodule