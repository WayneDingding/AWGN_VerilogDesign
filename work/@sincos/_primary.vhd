library verilog;
use verilog.vl_types.all;
entity Sincos is
    generic(
        B_x_g_aa        : integer := 7;
        B_x_g_ba        : integer := 7
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sincos_in       : in     vl_logic_vector(15 downto 0);
        sincos_out01    : out    vl_logic_vector(15 downto 0);
        sincos_out02    : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of B_x_g_aa : constant is 1;
    attribute mti_svvh_generic_type of B_x_g_ba : constant is 1;
end Sincos;
