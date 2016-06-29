library verilog;
use verilog.vl_types.all;
entity Sincos_tb is
    generic(
        datasize        : integer := 10;
        Bus_size_in     : integer := 15;
        Bus_size_out    : integer := 15;
        B_x_g_aa        : integer := 7;
        B_x_g_ba        : integer := 7
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of datasize : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_in : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_out : constant is 1;
    attribute mti_svvh_generic_type of B_x_g_aa : constant is 1;
    attribute mti_svvh_generic_type of B_x_g_ba : constant is 1;
end Sincos_tb;
