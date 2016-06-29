library verilog;
use verilog.vl_types.all;
entity AWGN_tb is
    generic(
        datasize        : integer := 10000;
        Bus_size_in     : integer := 31;
        Bus_size_out    : integer := 15
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of datasize : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_in : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_out : constant is 1;
end AWGN_tb;
