//Testbench for Mult.v
`timescale  1 ns / 10 ps
module Mult_tb  ; 
  parameter datasize      = 10;//test 10 samples  

  reg   [16:0]  mult_in1   ; 
  reg   [15:0]  mult_in2   ; 
  reg   [16:0]  data_in1[0:datasize-1]; 
  reg   [15:0]  data_in2[0:datasize-1];
  reg   [15:0]  data_out[2:datasize+1];
  wire  [15:0]  mult_out; 
  reg    rst   ; 
  reg    clk   ; 
 
  integer passed;
  integer i;
  
  task passTest;
        input [15:0] datav,datam;
        input   i;
        inout  passed;
        integer i;
        integer passed;
        
        if(datav == datam)
          begin
            $display ("passed");
            passed=passed+1;
          end
        else
            $display ("%d Failed: %b should be %b",i,datav,datam);
  endtask
    
  task allPassed;
        input passed;
        integer passed;
        
        if(passed == datasize)
           $display("All passed");
        else
           $display("%d failed",datasize-passed+1);
  endtask    
 
    
  Mult  DUT  ( 
      .clk(clk),
      .mult_out (mult_out ) ,
      .mult_in1 (mult_in1 ) ,
      .mult_in2 (mult_in2 ) ); 
  initial
    begin
    	   clk = 1'b0;
        rst = 1'b1;
        passed = 0;
        #2 rst = 1'b0;
        #2 rst = 1'b1;        
        $readmemb("mult_test_in1.dat",data_in1);
        $readmemb("mult_test_in2.dat",data_in2);
        $readmemb("mult_test_out.dat",data_out);
        #(datasize*2+2) allPassed(passed);
    end
      
  always #1 clk <= !clk;
      
  always @ (posedge clk or negedge rst)
      begin
        if(!rst)
          begin
            mult_in1 <=17'b0;
            mult_in2 <=16'b0;
            i=0;
          end
        else
          begin
          mult_in1 <= data_in1[i];
          mult_in2 <= data_in2[i];
          i=i+1;
          end
      end
    
  always @(i)
      begin
        passTest(mult_out,data_out[i],i,passed);
      end
endmodule




