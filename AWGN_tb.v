//Testbench for AWGN
`timescale  1 ns / 10 ps
module AWGN_tb();
    parameter datasize=10000;
    parameter Bus_size_in   = 32 - 1;
    parameter Bus_size_out  = 16 - 1;

    reg clk;
    reg reset;
    reg [Bus_size_in:0] data_in1[datasize-1:0],data_in2[datasize-1:0];
    reg [Bus_size_in:0] data_in3[datasize-1:0],data_in4[datasize-1:0];
    reg [Bus_size_in:0] data_in5[datasize-1:0],data_in6[datasize-1:0];
    reg [Bus_size_in:0] in0,in1,in2,in3,in4,in5;
    reg [Bus_size_out:0] data_out1[2:datasize+1],data_out2[2:datasize+1];
    wire[Bus_size_out:0] awgn1,awgn2;
    integer i,passed,write_out_file;
    
    task passTest;
        input [Bus_size_out:0] datav1,datav2,datam1,datam2;
        input   i;
        inout  passed;
        integer i;
        integer passed ;
        begin
        if(datav1 == datam1)
            $display ("awgn1 passed");
        else
            $display ("awgn1 %d Failed: %b should be %b",i,datav1,datam1);
        if(datav2 == datam2)
              $display ("awgn2 passed");
        else
              $display ("awgn2 %d Failed: %b should be %b",i,datav2,datam2);
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
    
    
    AWGN test_AWGN(
    .clk(clk),
    .reset(reset),
    .s0(in0),
    .s1(in1),
    .s2(in2),
    .s3(in3),
    .s4(in4),
    .s5(in5),
    .awgn1(awgn1),
    .awgn2(awgn2)
    );
  //read input data  
    initial
    begin
       write_out_file = $fopen("verilog_data_out.dat","w");
        i = 0;
        passed= 0;
        clk = 1'b0;
        reset = 1'b1;
        #2 reset = 1'b0;
        #2 reset = 1'b1;        
        $readmemb("mat_data_in1.dat",data_in1);
        $readmemb("mat_data_in2.dat",data_in2);
        $readmemb("mat_data_in3.dat",data_in3);
        $readmemb("mat_data_in4.dat",data_in4);
        $readmemb("mat_data_in5.dat",data_in5);
        $readmemb("mat_data_in6.dat",data_in6);
        $readmemb("mat_data_out1.dat",data_out1);
        $readmemb("mat_data_out2.dat",data_out2);
        #(datasize*2+4) allPassed(passed);
        
    end
    
    always #1 clk <= !clk;
    always @ (posedge clk or negedge reset)
    begin
        if(!reset)
        begin
           in0 <=  {32{1'b0}};
           in1 <=  {32{1'b0}};
           in2 <=  {32{1'b0}};
           in3 <=  {32{1'b0}};
           in4 <=  {32{1'b0}};
           in5 <=  {32{1'b0}};
            i <= 0;
        end
        else
        begin
           in0 <= data_in1[i];
           in1 <= data_in2[i];
           in2 <= data_in3[i];
           in3 <= data_in4[i];
           in4 <= data_in5[i];
           in5 <= data_in6[i];
           i <= i + 1;
        
        $fdisplay(write_out_file,"%d %d \n",awgn1, awgn2);
        end
    end
    
    always @(i)
    begin
       passTest(awgn1,awgn2,data_out1[i],data_out2[i],i,passed);
    end
endmodule


  
