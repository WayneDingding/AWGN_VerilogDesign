library verilog;
use verilog.vl_types.all;
entity Sqrt is
    generic(
        B_x_f_a         : integer := 6;
        Bus_size        : integer := 31
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sqrt_in         : in     vl_logic_vector(30 downto 0);
        sqrt_out        : out    vl_logic_vector(16 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of B_x_f_a : constant is 1;
    attribute mti_svvh_generic_type of Bus_size : constant is 1;
end Sqrt;
