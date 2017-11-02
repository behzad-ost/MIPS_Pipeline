library verilog;
use verilog.vl_types.all;
entity InstructionMemory is
    port(
        pc              : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        inst            : out    vl_logic_vector(31 downto 0)
    );
end InstructionMemory;
