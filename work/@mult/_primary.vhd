library verilog;
use verilog.vl_types.all;
entity Mult is
    port(
        clk             : in     vl_logic;
        mult_in1        : in     vl_logic_vector(16 downto 0);
        mult_in2        : in     vl_logic_vector(15 downto 0);
        mult_out        : out    vl_logic_vector(15 downto 0)
    );
end Mult;
