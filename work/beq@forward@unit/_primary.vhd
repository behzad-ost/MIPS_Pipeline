library verilog;
use verilog.vl_types.all;
entity beqForwardUnit is
    port(
        EXRd            : in     vl_logic_vector(4 downto 0);
        IDRs            : in     vl_logic_vector(4 downto 0);
        IDRt            : in     vl_logic_vector(4 downto 0);
        EX_regwrite     : in     vl_logic;
        beq             : in     vl_logic;
        bnq             : in     vl_logic;
        forwardA        : out    vl_logic_vector(1 downto 0);
        forwardB        : out    vl_logic_vector(1 downto 0)
    );
end beqForwardUnit;
