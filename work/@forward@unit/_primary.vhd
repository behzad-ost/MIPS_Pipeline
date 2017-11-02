library verilog;
use verilog.vl_types.all;
entity ForwardUnit is
    port(
        MemRd           : in     vl_logic_vector(4 downto 0);
        WBRd            : in     vl_logic_vector(4 downto 0);
        EXRs            : in     vl_logic_vector(4 downto 0);
        EXRt            : in     vl_logic_vector(4 downto 0);
        Mem_regwrite    : in     vl_logic;
        WB_regwrite     : in     vl_logic;
        forwardA        : out    vl_logic_vector(1 downto 0);
        forwardB        : out    vl_logic_vector(1 downto 0)
    );
end ForwardUnit;
