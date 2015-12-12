library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        op_code_alu     : in     vl_logic_vector(3 downto 0);
        aregread        : in     vl_logic;
        cregread        : in     vl_logic;
        aregwrite       : in     vl_logic;
        bregwrite       : in     vl_logic;
        cregwrite       : in     vl_logic;
        aoutregread     : in     vl_logic;
        boutregread     : in     vl_logic;
        coutregread     : in     vl_logic;
        outregwrite     : in     vl_logic_vector(1 downto 0);
        Mem_Dat_X       : in     vl_logic_vector(15 downto 0);
        Mem_Dat_Y       : in     vl_logic_vector(15 downto 0);
        Aout            : out    vl_logic_vector(15 downto 0);
        Bout            : out    vl_logic_vector(15 downto 0);
        Cout            : out    vl_logic_vector(15 downto 0);
        Areg            : out    vl_logic_vector(15 downto 0);
        Breg            : out    vl_logic_vector(15 downto 0);
        Creg            : out    vl_logic_vector(15 downto 0)
    );
end datapath;
