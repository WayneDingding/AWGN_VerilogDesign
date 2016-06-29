library verilog;
use verilog.vl_types.all;
entity Tausworthe is
    generic(
        Bus_size        : integer := 31
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        t0              : in     vl_logic_vector;
        t1              : in     vl_logic_vector;
        t2              : in     vl_logic_vector;
        t_out           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Bus_size : constant is 1;
end Tausworthe;
