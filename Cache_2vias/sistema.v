module sistema(clock, tag, indice, data_in, read_write, hit_miss, sinaisCache, writeback,tag_out, data_out);
// inputs
	input	[2:0] tag, data_in; 
	input [1:0] indice;
	input clock, read_write;
	
// outputs
	output hit_miss, writeback;
	output[2:0] tag_out, data_out;
	// lru0 -> 0 | lru1 -> 1 | valido0 -> 2 | valido1 -> 3 | dirty0 -> 4 | dirty1 -> 5 |
	output[5:0] sinaisCache;
	
// conexões e sinais de controle
	wire[2:0] _address_cache, _address_ram, _dado_from_ram, _data_out;
	wire [4:0] _address;
	wire[7:0] _data_to_ram, _q;
	wire _hit, _writeram, _writecache, _writeback;
	wire[5:0] _sinaisCache;
	
// em caso de writeback pega o endereço da cache e não o da tag inserida
	assign _address[4:2] = (_writeback == 1'b1)? _address_ram: tag; 
	assign _address[1:0] = indice; 
		
// MEMORIA RAM
	memoriaRam ram(_address,clock,_data_to_ram,_writeram,_q);
// CACHE
	cache2vias cache(clock, _address_cache, data_in, _dado_from_ram, _hit, _writecache, _data_out);
// UNIDADE DE CONTROLE
	controleCache controle(clock, tag, indice, read_write, _hit, _writeram, _address_cache, _address_ram, _writecache, _writeback, _sinaisCache);
// EXTENSORES DE SINAL
	assign _dado_from_ram = _q[2:0];
	extensor3para8 data_cacheTOram(_data_out, _data_to_ram);
	
// saidas para a placa
assign hit_miss = _hit;
assign sinaisCache[0] = _sinaisCache[0];
assign sinaisCache[1] = _sinaisCache[1];
assign sinaisCache[2] = _sinaisCache[2];
assign sinaisCache[3] = _sinaisCache[3];
assign sinaisCache[4] = _sinaisCache[4];
assign sinaisCache[5] = _sinaisCache[5];
assign writeback = _writeback;
assign data_out = _data_out;
assign tag_out = _address[4:2];

endmodule
