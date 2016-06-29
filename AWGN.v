module AWGN(clk,reset,s0,s1,s2,s3,s4,s5,awgn1,awgn2);//,temp);
  input    clk;
  input    reset;
  input  [31:0] s0,s1,s2,s3,s4,s5;
  output [15:0] awgn1,awgn2;
//output [47:0] temp;
  wire    [31:0] taus1_concat,taus2_split;
  wire    [15:0] split_concat;
  wire    [47:0] concat_log;
  wire    [15:0] split_sincos;
  wire    [30:0] log_sqrt;
  wire    [16:0] sqrt_mult;
  wire    [15:0] sincos_mult1,sincos_mult2;

      
    
    Tausworthe T1(
    .clk(clk),
    .rst(reset),
    .t0(s0),
    .t1(s1),
    .t2(s2),
    .t_out(taus1_concat));
    
    Tausworthe T2(
    .clk(clk),
    .rst(reset),
    .t0(s3),
    .t1(s4),
    .t2(s5),
    .t_out(taus2_split));
    
    Concat c(
    .concat_in1(taus1_concat),
    .concat_in2(split_concat),
    .concat_out(concat_log));
    
    Split sp(
    .split_in(taus2_split),
    .split_out1(split_concat),
    .split_out2(split_sincos));
    
    Log l(
    .clk(clk), 
    .rst(reset),
    .log_in(concat_log), 
    .log_out(log_sqrt));
    
    Sqrt sq(
    .clk(clk), 
    .rst(reset),
    .sqrt_in(log_sqrt), 
    .sqrt_out(sqrt_mult));
    
    Sincos sc(
    .clk(clk), 
    .rst(reset),
    .sincos_in(split_sincos), 
    .sincos_out01(sincos_mult1), 
    .sincos_out02(sincos_mult2));
    
    Mult m1(
    .clk(clk),
    .mult_in1(sqrt_mult), 
    .mult_in2(sincos_mult1),
    .mult_out(awgn1));
  
    Mult m2(
    .clk(clk),
    .mult_in1(sqrt_mult), 
    .mult_in2(sincos_mult2),
    .mult_out(awgn2));
//   assign temp=awgn1;
  endmodule