library verilog;
use verilog.vl_types.all;
entity Log is
    generic(
        ln2             : vl_logic_vector(31 downto 0) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1);
        Bus_size        : integer := 47;
        B_x_e_a         : integer := 8;
        datasize        : integer := 254;
        Bus_size_out    : integer := 68
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        log_in          : in     vl_logic_vector;
        log_out         : out    vl_logic_vector(30 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ln2 : constant is 1;
    attribute mti_svvh_generic_type of Bus_size : constant is 1;
    attribute mti_svvh_generic_type of B_x_e_a : constant is 1;
    attribute mti_svvh_generic_type of datasize : constant is 1;
    attribute mti_svvh_generic_type of Bus_size_out : constant is 1;
end Log;
