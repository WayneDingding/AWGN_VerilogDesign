//concat module is a 
module Split(split_in,split_out1,split_out2);
  parameter size1=32;
  parameter size2=16;
  input   [size1-1:0] split_in;
  output  [size2-1:0] split_out1,split_out2; 

  assign split_out1  = split_in[size1-1:size2];
  assign split_out2  = split_in[size2-1:0];
endmodule 
