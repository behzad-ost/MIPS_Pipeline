library verilog;
use verilog.vl_types.all;
entity Shifter is
    generic(
        busSize         : integer := 32
    );
    port(
        I               : in     vl_logic_vector;
        O               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of busSize : constant is 1;
end Shifter;
