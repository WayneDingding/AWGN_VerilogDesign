library verilog;
use verilog.vl_types.all;
entity Log_tb is
    generic(
        ln2             : vl_logic_vector(31 downto 0) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1);
        Bus_size_in     : integer := 47;
        Bus_size_out    : integer := 30;
        B_x_e_a         : integer := 8;
        datasize        : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ln2 : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_in : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_out : constant is 1;
    attribute mti_svvh_generic_type of B_x_e_a : constant is 1;
    attribute mti_svvh_generic_type of datasize : constant is 1;
end Log_tb;
