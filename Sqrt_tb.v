`timescale  1 ns / 10 ps
module Sqrt_tb  ; 

 
parameter datasize      = 10;    
parameter Bus_size_in   = 31 - 1;
parameter Bus_size_out  = 17 - 1;
parameter B_x_e_a       = 8 ; 
parameter B_x_f_a       = 6;

  reg   [Bus_size_in:0]   sqrt_in; 
  reg   [Bus_size_in:0]   data_in[0:datasize-1];
  reg   [Bus_size_out:0]  data_out[2:datasize+1];
  wire  [Bus_size_out:0]  sqrt_out; 
  reg    rst   ; 
  reg    clk   ; 
 
  integer passed;
  integer i;
  
  task passTest;
        input [Bus_size_out:0] datav,datam;
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
    
  Sqrt    #(
          .Bus_size (Bus_size_in), 
          .B_x_f_a (B_x_f_a))
    DUT( 
      .sqrt_out (sqrt_out ) ,
      .sqrt_in (sqrt_in ) ,
      .clk (clk ));     
  
initial
  begin
    	   clk = 1'b0;
        rst = 1'b1;
        passed = 0;
        #2 rst = 1'b0;
        #2 rst = 1'b1;        
        $readmemb("Sqrt_test_in.dat",data_in);
//        $readmemb("Sqrt_test_out.dat",data_out);
        $readmemb("Sqrt_test_out.dat",data_out);
        #(datasize*2+2) allPassed(passed);
  end
      
      always #1 clk <= !clk;
      
      always @ (posedge clk or negedge rst)
      begin
        if(!rst)
          begin
            sqrt_in <=31'b0;
            i=0;
          end
        else
          begin
          sqrt_in <= data_in[i];
          i=i+1;
          end
      end
    
      always @(i)
      begin
        passTest(sqrt_out,data_out[i],i-1,passed);
      end
  
endmodule


