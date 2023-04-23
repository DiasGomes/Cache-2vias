module parteIII(SW, HEX0, HEX1, HEX2, HEX3, LEDG);
	// inputs
	input[17:0] SW; 
	
	// outputs
	output[6:0] HEX0, HEX1, HEX2, HEX3;
	output [17:0] LEDG;
	
	// wires
	wire[2:0] _tag, _data, _tag_out, _data_out;
	wire[1:0] _indice;
	wire clock, _hit_miss, _read_write, _writeback;
	wire[5:0] _sinaisCache;
	
	// associando wires com as entradas da placa
	assign _read_write = SW[8];	// 0 leitura e 1 escrita
	assign _tag = SW[7:5];
	assign _indice = SW[4:3];
	assign _data = SW[2:0];
	assign clock = SW[17];
	
	// associando wires com as saÃƒÆ’Ã‚Â­das da placa
	assign LEDG[0] = _hit_miss;	// hit == 1 miss == 0
	assign LEDG[1] = _writeback;	// writeback
	assign LEDG[2] = _sinaisCache[0];		// lru0 
	assign LEDG[3] = _sinaisCache[1];			// Lru1
	assign LEDG[4] = _sinaisCache[2];		// valido0 
	assign LEDG[5] = _sinaisCache[3];	// valido1
	assign LEDG[6] = _sinaisCache[4];		// dirty0 
	assign LEDG[7] = _sinaisCache[5];	// dirty1
	
	// conecta o modulo
	sistema sys(clock, _tag, _indice, _data, _read_write, _hit_miss, _sinaisCache, _writeback, _tag_out, _data_out);
	
	// gera saida dodisplay de 7 segmentos 
	// HEX0 = dado e HEX2 = tag
	decodificador display2(_tag_out, HEX2);
	decodificador display0(_data_out, HEX0);
	
	// Desabilita os displays que nÃƒÆ’Ã‚Â£o serÃƒÆ’Ã‚Â£o usados
	assign HEX1 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	// Desabilita os LEDs que nÃƒÆ’Ã‚Â£o serÃƒÆ’Ã‚Â£o usados
	assign LEDG[17:8] = 10'b0000000000;
	
endmodule

