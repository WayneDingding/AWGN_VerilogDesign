//Testbench for Log.v
`timescale  1 ns / 10 ps
module Log_tb  ; 
  parameter ln2  = 32'hB17217F7 ;
  parameter Bus_size_in   = 48 -1  ;
  parameter Bus_size_out  = 31 -1  ;
  parameter B_x_e_a  = 8 ; 
  parameter datasize = 10;  
 
  reg  [Bus_size_in:0]    log_in  ; 
  reg  [Bus_size_in:0]    data_in[datasize:0];
  reg  [Bus_size_out:0]   data_out[datasize+1:2];
  wire [Bus_size_out:0]   log_out   ;

  reg               	   	 rst   ; 
  reg             	 	 	 	 clk   ; 
  integer                 i;
  integer                 passed;
 
      
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
           $display("%d failed",datasize+1-passed);
  endtask
    
  Log #(.ln2 (ln2),
      .Bus_size (Bus_size_in),
      .Bus_size_out (Bus_size_out), 
      .B_x_e_a (B_x_e_a))
  DUT( 
      .log_in (log_in) ,
      .log_out (log_out) ,
      .rst (rst) ,
      .clk (clk) 
       );     
  
  initial
   begin
  	   clk = 1'b0;
      rst = 1'b1;
      passed = 0;
      #2 rst = 1'b0;
      #2 rst = 1'b1;        
      $readmemb("Log_test_in.dat",data_in);
      $readmemb("Log_test_out.dat",data_out);
      #(datasize*2+2) allPassed(passed);
    end
      
  always #1 clk <= !clk;
      
  always @ (posedge clk or negedge rst)
      begin
        if(!rst)
          begin
            log_in <=48'h800000000000;
            i=0;
          end
        else
          begin
          log_in <= data_in[i];
          i=i+1;
          end
      end
    
  always @(i)
      begin
      passTest(log_out,data_out[i],i-1,passed);
      end
endmodule

