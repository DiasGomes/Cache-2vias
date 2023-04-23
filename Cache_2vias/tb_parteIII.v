module tb_parteIII(); 
	
	reg[17:0] SW; 
	wire[6:0] HEX0, HEX1, HEX2, HEX3;
	wire [17:0] LEDG;
	
	parteIII p(SW, HEX0, HEX1, HEX2, HEX3, LEDG);
	
	// clock
	initial
	begin
		#0 SW[17] = 1;
		forever	
			begin
				#50 SW[17] = ~SW[17]; 
			end
	end

	
	// mostra os resultados
	initial 
	begin			
		$display("===========================================================");
		$display("------------------- INICIO DA SIMULACAO -------------------");
		$display("===========================================================\n");
		
		forever
			begin
					#50 
					$display("-------------- CLOCK 0%b ----------------", p.clock);
					$display("\nENTRADA");
					$display("WRITE %b TAG %3b INDICE %0d DADO %0d", p._read_write, p._tag, p._indice ,p._data);
					$display("\nSAIDA");
					$display("HIT %b 	WRITEBACK %b ", p.sys.cache.hit, p.sys.controle.writeback);
					$display("ADDRESS_CACHE %0d DADO-CACHE %0d", p.sys.cache.address_cache, p.sys.cache.data_out);		
					$display("\nRAM");
					$display("WREN %b DADO-IN %0d ADDRESS %0d DADO-RAM %0d", p.sys._writeram, p.sys._data_to_ram, p.sys._address, p.sys._q);
					$display("\nCACHE 0");
					$display("INDICE VALIDO DIRTY LRU TAG DADO");
					$display("  0      %b      %b    %b  %3b  %0d", p.sys.controle.valido0[0], p.sys.controle.dirty0[0], p.sys.controle.lru0[0], p.sys.controle.tag0[0], p.sys.cache.cache[0]);
					$display("  1      %b      %b    %b  %3b  %0d", p.sys.controle.valido0[1], p.sys.controle.dirty0[1], p.sys.controle.lru0[1], p.sys.controle.tag0[1], p.sys.cache.cache[1]);
					$display("  2      %b      %b    %b  %3b  %0d", p.sys.controle.valido0[2], p.sys.controle.dirty0[2], p.sys.controle.lru0[2], p.sys.controle.tag0[2], p.sys.cache.cache[2]);
					$display("  3      %b      %b    %b  %3b  %0d", p.sys.controle.valido0[3], p.sys.controle.dirty0[3], p.sys.controle.lru0[3], p.sys.controle.tag0[3], p.sys.cache.cache[3]);
					$display("\nCACHE 1");
					$display("INDICE VALIDO DIRTY LRU TAG DADO");
					$display("  0      %b      %b    %b  %3b  %0d", p.sys.controle.valido1[0], p.sys.controle.dirty1[0], p.sys.controle.lru1[0], p.sys.controle.tag1[0], p.sys.cache.cache[4]);
					$display("  1      %b      %b    %b  %3b  %0d", p.sys.controle.valido1[1], p.sys.controle.dirty1[1], p.sys.controle.lru1[1], p.sys.controle.tag1[1], p.sys.cache.cache[5]);
					$display("  2      %b      %b    %b  %3b  %0d", p.sys.controle.valido1[2], p.sys.controle.dirty1[2], p.sys.controle.lru1[2], p.sys.controle.tag1[2], p.sys.cache.cache[6]);
					$display("  3      %b      %b    %b  %3b  %0d", p.sys.controle.valido1[3], p.sys.controle.dirty1[3], p.sys.controle.lru1[3], p.sys.controle.tag1[3], p.sys.cache.cache[7]);
					
					
			end
		
	end
	
	// insere dados do teste
	initial 
		begin
			// teste original
			#0 SW[16:0] = 17'b00000000010000xxx;
			#150 SW[16:0] = 17'b00000000010100xxx;
			#100 SW[16:0] = 17'b00000000010000xxx;
			#100 SW[16:0] = 17'b00000000100001111;
			#100 SW[16:0] = 17'b00000000111110010;
			#100 SW[16:0] = 17'b00000000111010011;
			#200 SW[16:0] = 17'b00000000000110xxx;
			#200 $stop();
		end

endmodule
