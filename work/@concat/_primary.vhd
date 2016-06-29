library verilog;
use verilog.vl_types.all;
entity Concat is
    generic(
        size1           : integer := 32;
        size2           : integer := 16
    );
    port(
        concat_in1      : in     vl_logic_vector;
        concat_in2      : in     vl_logic_vector;
        concat_out      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of size1 : constant is 1;
    attribute mti_svvh_generic_type of size2 : constant is 1;
end Concat;
