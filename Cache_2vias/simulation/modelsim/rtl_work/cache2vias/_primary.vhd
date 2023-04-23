library verilog;
use verilog.vl_types.all;
entity cache2vias is
    port(
        clock           : in     vl_logic;
        address_cache   : in     vl_logic_vector(2 downto 0);
        dado            : in     vl_logic_vector(2 downto 0);
        dado_ram        : in     vl_logic_vector(2 downto 0);
        hit             : in     vl_logic;
        writecache      : in     vl_logic;
        data_out        : out    vl_logic_vector(2 downto 0)
    );
end cache2vias;
