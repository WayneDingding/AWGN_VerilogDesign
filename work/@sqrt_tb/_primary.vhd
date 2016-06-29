library verilog;
use verilog.vl_types.all;
entity Sqrt_tb is
    generic(
        datasize        : integer := 10;
        Bus_size_in     : integer := 30;
        Bus_size_out    : integer := 16;
        B_x_e_a         : integer := 8;
        B_x_f_a         : integer := 6
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of datasize : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_in : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_out : constant is 1;
    attribute mti_svvh_generic_type of B_x_e_a : constant is 1;
    attribute mti_svvh_generic_type of B_x_f_a : constant is 1;
end Sqrt_tb;
