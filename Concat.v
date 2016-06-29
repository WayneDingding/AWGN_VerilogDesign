//concat module is a 
module Concat(concat_in1,concat_in2,concat_out);
  parameter size1=32;
  parameter size2=16;
  input   [size1-1:0] concat_in1;
  input   [size2-1:0] concat_in2;
  output  [size1+size2-1:0] concat_out; 
  
  assign concat_out =  {concat_in1,concat_in2};
endmodule 