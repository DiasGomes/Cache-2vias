library verilog;
use verilog.vl_types.all;
entity controleCache is
    port(
        clock           : in     vl_logic;
        tag             : in     vl_logic_vector(2 downto 0);
        indice          : in     vl_logic_vector(1 downto 0);
        read_write      : in     vl_logic;
        hit_miss        : out    vl_logic;
        writeram        : out    vl_logic;
        address_cache   : out    vl_logic_vector(2 downto 0);
        address_ram     : out    vl_logic_vector(2 downto 0);
        writecache      : out    vl_logic;
        writeback       : out    vl_logic;
        sinaisCache     : out    vl_logic_vector(5 downto 0)
    );
end controleCache;
