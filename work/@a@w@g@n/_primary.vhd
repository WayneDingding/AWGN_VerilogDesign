library verilog;
use verilog.vl_types.all;
entity AWGN is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        s0              : in     vl_logic_vector(31 downto 0);
        s1              : in     vl_logic_vector(31 downto 0);
        s2              : in     vl_logic_vector(31 downto 0);
        s3              : in     vl_logic_vector(31 downto 0);
        s4              : in     vl_logic_vector(31 downto 0);
        s5              : in     vl_logic_vector(31 downto 0);
        awgn1           : out    vl_logic_vector(15 downto 0);
        awgn2           : out    vl_logic_vector(15 downto 0)
    );
end AWGN;
