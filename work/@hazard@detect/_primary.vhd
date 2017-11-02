library verilog;
use verilog.vl_types.all;
entity HazardDetect is
    port(
        R1              : in     vl_logic_vector(4 downto 0);
        R2              : in     vl_logic_vector(4 downto 0);
        Rw              : in     vl_logic_vector(4 downto 0);
        memread         : in     vl_logic;
        jump            : in     vl_logic;
        PCld            : out    vl_logic;
        IF_ID_ld        : out    vl_logic
    );
end HazardDetect;
