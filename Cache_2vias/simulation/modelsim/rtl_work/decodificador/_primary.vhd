library verilog;
use verilog.vl_types.all;
entity decodificador is
    port(
        entrada         : in     vl_logic_vector(2 downto 0);
        saida           : out    vl_logic_vector(6 downto 0)
    );
end decodificador;
