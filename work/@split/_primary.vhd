library verilog;
use verilog.vl_types.all;
entity Split is
    generic(
        size1           : integer := 32;
        size2           : integer := 16
    );
    port(
        split_in        : in     vl_logic_vector;
        split_out1      : out    vl_logic_vector;
        split_out2      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of size1 : constant is 1;
    attribute mti_svvh_generic_type of size2 : constant is 1;
end Split;
