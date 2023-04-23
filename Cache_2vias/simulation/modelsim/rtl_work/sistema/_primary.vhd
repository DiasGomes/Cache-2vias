library verilog;
use verilog.vl_types.all;
entity sistema is
    port(
        clock           : in     vl_logic;
        tag             : in     vl_logic_vector(2 downto 0);
        indice          : in     vl_logic_vector(1 downto 0);
        data_in         : in     vl_logic_vector(2 downto 0);
        read_write      : in     vl_logic;
        hit_miss        : out    vl_logic;
        sinaisCache     : out    vl_logic_vector(5 downto 0);
        writeback       : out    vl_logic;
        tag_out         : out    vl_logic_vector(2 downto 0);
        data_out        : out    vl_logic_vector(2 downto 0)
    );
end sistema;
