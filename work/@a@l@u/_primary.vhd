library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        dataA           : in     vl_logic_vector(31 downto 0);
        dataB           : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic_vector(2 downto 0);
        O               : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic
    );
end ALU;
