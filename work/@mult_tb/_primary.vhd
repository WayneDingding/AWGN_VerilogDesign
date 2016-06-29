library verilog;
use verilog.vl_types.all;
entity Mult_tb is
    generic(
        datasize        : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of datasize : constant is 1;
end Mult_tb;
