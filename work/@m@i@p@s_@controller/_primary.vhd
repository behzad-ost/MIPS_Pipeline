library verilog;
use verilog.vl_types.all;
entity MIPS_Controller is
    port(
        opcode          : in     vl_logic_vector(5 downto 0);
        func            : in     vl_logic_vector(5 downto 0);
        zero            : in     vl_logic;
        wAddSel         : out    vl_logic_vector(1 downto 0);
        wDataSel        : out    vl_logic_vector(1 downto 0);
        PCMUXSel        : out    vl_logic_vector(1 downto 0);
        IDdatasel       : out    vl_logic_vector(1 downto 0);
        ALUfunc         : out    vl_logic_vector(2 downto 0);
        PCld            : out    vl_logic;
        regwrite        : out    vl_logic;
        bdsel           : out    vl_logic;
        dsel            : out    vl_logic;
        signextend      : out    vl_logic;
        memread         : out    vl_logic;
        memwrite        : out    vl_logic;
        beq             : out    vl_logic;
        bnq             : out    vl_logic
    );
end MIPS_Controller;
