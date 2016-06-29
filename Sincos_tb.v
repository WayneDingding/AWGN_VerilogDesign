module Sincos_tb  ; 
parameter datasize      = 10;    
parameter Bus_size_in   = 16 - 1;
parameter Bus_size_out  = 16 - 1;
parameter B_x_g_aa  = 7 ;
parameter B_x_g_ba  = 7 ; 

  reg   [Bus_size_in:0]   sincos_in; 
  reg   [Bus_size_in:0]   data_in[0:datasize-1];
  reg   [Bus_size_out:0]  data_out1[2:datasize+1];
  reg   [Bus_size_out:0]  data_out2[2:datasize+1];
  wire  [Bus_size_out:0]  sincos_out1,sincos_out2; 
  reg    rst   ; 
  reg    clk   ; 
 
  integer passed;
  integer i;
  
  
  Sincos    #( B_x_g_aa , B_x_g_ba  )
   DUT  ( 
       .sincos_out2 (sincos_out2 ) ,
      .sincos_in (sincos_in ) ,
      .clk (clk ) ,
      .sincos_out1 (sincos_out1 ) ); 
      
    task passTest;
        input [Bus_size_out:0] datav1,datav2,datam1,datam2;
        input   i;
        inout  passed;
        integer i;
        integer passed ;
        begin
        if(datav1 == datam1)
            $display ("g0 passed");
        else
            $display ("g0 %d Failed: %b should be %b",i,datav1,datam1);
        if(datav2 == datam2)
              $display ("g1 passed");
        else
              $display ("g1 %d Failed: %b should be %b",i,datav2,datam2);
        if((datav1 == datam1) & (datav2 == datam2))
         passed=passed+1;
        end
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
        $readmemb("Sincos_test_in.dat",data_in);
        $readmemb("Sincos_test_out1.dat",data_out1);
        $readmemb("Sincos_test_out2.dat",data_out2);
        #(datasize*2+2) allPassed(passed);
  end
    always #1 clk <= ~clk;
      
      always @ (posedge clk or negedge rst)
      begin
        if(!rst)
          begin
            sincos_in <=16'b0;
            i=0;
          end
        else
          begin
          sincos_in <= data_in[i];
          i=i+1;
          end
      end
      
      always @(i)
      begin
        passTest(sincos_out1,sincos_out2,data_out1[i],data_out2[i],i-1,passed);
      end
   
endmodule

