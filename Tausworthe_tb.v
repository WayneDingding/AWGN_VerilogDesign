module Tausworthe_tb  ; 
parameter datasize      = 10;    
parameter Bus_size_in   = 32 - 1;
parameter Bus_size_out  = 32 - 1;
  
  reg  clk,rst; 
  reg  [Bus_size_in:0]  t0   ; 
  reg  [Bus_size_in:0]  t1   ; 
  reg  [Bus_size_in:0]  t2   ;

  reg   [Bus_size_in:0]   data_in[0:3*datasize-1];
  reg   [Bus_size_out:0]  data_out[2:datasize+1];
  wire  [Bus_size_out:0]  t_out; 

  integer passed;
  integer i;
  
  
  Tausworthe    #( .Bus_size (Bus_size_in) )
   DUT  ( .clk(clk),
       .rst(rst),
       .t0 (t0 ) ,
      .t1 (t1 ) ,
      .t2 (t2 ) ,
      .t_out (t_out ) ); 
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
           $display("%d failed",datasize-passed);
    endtask    
initial
  begin
    	   clk = 1'b0;
        rst = 1'b1;
        passed = 0;
        #2 rst = 1'b0;
        #2 rst = 1'b1;        
        $readmemb("TWs_test_in.dat",data_in);
        $readmemb("TWs_test_out.dat",data_out);
        #(datasize*2+2) allPassed(passed);
  end
      
      always #1 clk <= !clk;
      
      always @ (posedge clk or negedge rst)
      begin
        if(!rst)
          begin
            t0 <=32'b0;
            t1 <=32'b0;
            t2 <=32'b0;
           
            i=0;
          end
        else
          begin
            t0 <=data_in[i];
            t1 <=data_in[i+datasize];
            t2 <=data_in[i+2*datasize];
            i=i+1;
          end
      end
    
      always @(i)
      begin
        passTest(t_out,data_out[i],i-1,passed);
      end
   
endmodule

