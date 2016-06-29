library verilog;
use verilog.vl_types.all;
entity Tausworthe_tb is
    generic(
        datasize        : integer := 10;
        Bus_size_in     : integer := 31;
        Bus_size_out    : integer := 31
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of datasize : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_in : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_out : constant is 1;
end Tausworthe_tb;
