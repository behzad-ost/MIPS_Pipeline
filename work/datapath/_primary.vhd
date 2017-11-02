library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        regWrite        : in     vl_logic;
        PCrst           : in     vl_logic;
        wAddSel         : in     vl_logic_vector(1 downto 0);
        wDataSel        : in     vl_logic_vector(1 downto 0);
        signOrZero      : in     vl_logic;
        bdsel           : in     vl_logic;
        ALUfunc         : in     vl_logic_vector(2 downto 0);
        PCMUXSel        : in     vl_logic_vector(1 downto 0);
        memRead         : in     vl_logic;
        IDdatasel       : in     vl_logic_vector(1 downto 0);
        memWrite        : in     vl_logic;
        dSel            : in     vl_logic;
        beq             : in     vl_logic;
        bnq             : in     vl_logic;
        OPcode          : out    vl_logic_vector(5 downto 0);
        func            : out    vl_logic_vector(5 downto 0);
        zero            : out    vl_logic
    );
end datapath;
