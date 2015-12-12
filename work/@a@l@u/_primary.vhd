library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        X               : in     vl_logic_vector(15 downto 0);
        Y               : in     vl_logic_vector(15 downto 0);
        op_code         : in     vl_logic_vector(3 downto 0);
        Z               : out    vl_logic_vector(15 downto 0)
    );
end ALU;
