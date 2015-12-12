library verilog;
use verilog.vl_types.all;
entity main is
    port(
        CLK             : in     vl_logic;
        Mem_Data_X      : in     vl_logic_vector(15 downto 0);
        Mem_Data_Y      : in     vl_logic_vector(15 downto 0);
        OP_Code         : in     vl_logic_vector(11 downto 0);
        X               : out    vl_logic_vector(15 downto 0);
        Y               : out    vl_logic_vector(15 downto 0);
        Z               : out    vl_logic_vector(15 downto 0)
    );
end main;
