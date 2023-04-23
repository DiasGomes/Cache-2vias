module controleCache(clock, tag, indice, read_write, hit_miss, writeram, address_cache, address_ram, writecache, writeback, sinaisCache);
// inputs
	input	[2:0] tag; 
	input [1:0] indice;
	input clock, read_write;
	
// outputs -> sinais de controle
	output reg hit_miss, writeram, writeback, writecache;
	output reg[2:0] address_cache, address_ram;
// lru0 -> 0 | lru1 -> 1 | valido0 -> 2 | valido1 -> 3 | dirty0 -> 4 | dirty1 -> 5 |
	output reg[5:0] sinaisCache;

// caches --> são matrizes de 4 linhas por propriedade e por cache
	reg [2:0] tag0[3:0];
	reg [2:0] tag1[3:0];
	reg valido0 [3:0];
	reg valido1 [3:0];
	reg dirty0 [3:0];
	reg dirty1 [3:0];
	reg lru0 [3:0];
	reg lru1 [3:0];
	
// Considerando as tags já preenchidos nas caches
	initial
	  begin	  
			// instancia a cache 0
			tag0[0] = 3'b100;	tag0[1] = 3'b000;	tag0[2] = 3'b101;	tag0[3] = 3'bxxx;
			valido0[0] = 1'b0;	valido0[1] = 1'b1;	valido0[2] = 1'b1;	valido0[3] = 1'b0;
			dirty0[0] = 1'b0;	dirty0[1] = 1'b0;	dirty0[2] = 1'b1;	dirty0[3] = 1'bx;
			lru0[0] = 1'b0;	lru0[1] = 1'b1;	lru0[2] = 1'b0;	lru0[3] = 1'bx;
			// instancia a cache 1
			tag1[0] = 3'bxxx;	tag1[1] = 3'bxxx;	tag1[2] = 3'b111;	tag1[3] = 3'bxxx;	
			valido1[0] = 1'b0;	valido1[1] = 1'b0;	valido1[2] = 1'b1;	valido1[3] = 1'b0;
			dirty1[0] = 1'b0;	dirty1[1] = 1'b0;	dirty1[2] = 1'b0;	dirty1[3] = 1'bx;
			lru1[0] = 1'b0;	lru1[1] = 1'b0;	lru1[2] = 1'b1;	lru1[3] = 1'bx;
			// inicializa sinais de controle
			writeback = 1'b0;
	 end
	 
// logica da cache na borda de subida
	always @(negedge clock)
		begin
			// sem write back
			if(writeback == 1'b0)
				begin 
					// ================== ESCRITA ==================
					if(read_write == 1'b1) 
						begin
							// cache 0
							if(tag0[indice] == tag) 
								begin
									// desabilita escrita na ram
									writeram = 1'b0;
									// deu hit
									hit_miss = 1'b1; 
									// escrita na cache 0
									writecache = 1'b1;
									// atualiza dirty
									dirty0[indice] = 1'b1;
									// atualiza lru
									lru0[indice] = 1'b1;
									lru1[indice] = 1'b0;
									// determina o indice do registrador da cache
									address_cache[1:0] = indice;
									address_cache[2] = 1'b0;
								end 
								
							// cache 1
							else if(tag1[indice] == tag) 
								begin
									// desabilita escrita na ram
									writeram = 1'b0;
									// deu hit
									hit_miss = 1'b1;
									// escrita na cache 1
									writecache = 1'b1;
									// atualiza dirty
									dirty1[indice] = 1'b1;
									// atualiza lru
									lru0[indice] = 1'b0;
									lru1[indice] = 1'b1;
									// determina o indice do registrador da cache
									address_cache[1:0] = indice;
									address_cache[2] = 1'b1;
								end
								
							// Write Miss – com write back
							else
								begin
									// Habilita write back
									writeback = 1'b1;
									// Habilita escrita na ram
									writeram = 1'b1;
									// leitura na cache
									writecache = 1'b0;
									// deu miss
									hit_miss = 1'b0;
									// determina o indice da cache
									address_cache[1:0] = indice;
									// verifica bloco mais antigo
									if(lru0[indice] == 1'b0)	// cache 0 mais antiga
										begin 
											// atualiza lru
											lru0[indice] = 1'b1;
											lru1[indice] = 1'b0;
											// determina qual cache
											address_cache[2] = 1'b0;
											// informa a ram o endereço do dado da cache
											address_ram = tag0[indice];
										end
									else
										begin 						// cache 1 mais antiga
											// atualiza lru
											lru0[indice] = 1'b0;
											lru1[indice] = 1'b1;
											// determina qual cache
											address_cache[2] = 1'b1;
											// informa a ram o endereço do dado da cache
											address_ram = tag1[indice];
										end
								end
						end 
					// ================== LEITURA ==================
					else 
						begin
							// cache 0
							if(tag0[indice] == tag) 
								begin
									// leitura na cache
									writecache = 1'b0;
									// leitura da minha ram
									writeram = 1'b0;
									// determina o indice do registrador da cache
									address_cache[1:0] = indice;
									address_cache[2] = 1'b0;
									// atualiza lru
									lru0[indice] = 1'b1;
									lru1[indice] = 1'b0;
									// verifica se deu hit=1 ou miss=0
									hit_miss = (valido0[indice] == 1'b1)? 1'b1 : 1'b0; 
									// atualiza valido
									valido0[indice] = 1'b1;
								end 
							// cache 1
							else if(tag1[indice] == tag)
								begin
									// leitura na cache
									writecache = 1'b0;
									// leitura da minha ram
									writeram = 1'b0;
									// determina o indice do registrador da cache
									address_cache[1:0] = indice;
									address_cache[2] = 1'b1;	// equivalente a somar a 4
									// atualiza lru
									lru0[indice] = 1'b0;
									lru1[indice] = 1'b1;
									// verifica se deu hit=1 ou miss=0
									hit_miss = (valido1[indice] == 1'b1)? 1'b1 : 1'b0; 
									// atualiza valido
									valido1[indice] = 1'b1;
								end
							// não bateu a nenhuma tag, mas ainda tem que verificar se o conteudo é valido
							else 
								begin
									// deu miss
									hit_miss = 1'b0;
									// leitura na cache
									writecache = 1'b0;
									// leitura da ram
									writeram = 1'b0;
									// verifica se algum é invalido para atualizar a tag
									if (valido0[indice] == 1'b0)
										begin 
											// determina o indice do registrador da cache
											address_cache[1:0] = indice;
											address_cache[2] = 1'b0;
											// atualiza a tag
											tag0[indice] = tag;
											// atualiza lru
											lru0[indice] = 1'b1;
											lru1[indice] = 1'b0;
											// atualiza valido
											valido0[indice] = 1'b1;
										end
									else if (valido1[indice] == 1'b0)
										begin 
											// determina o indice do registrador da cache
											address_cache[1:0] = indice;
											address_cache[2] = 1'b1;
											// atualiza a tag
											tag1[indice] = tag;
											// atualiza lru
											lru0[indice] = 1'b0;
											lru1[indice] = 1'b1;
											// atualiza valido
											valido1[indice] = 1'b1;
										end
									// é invalido, então
									// read miss com write back
									else
										begin 
											// Habilita write back
											writeback = 1'b1;
											// Habilita escrita na ram
											writeram = 1'b1;
											// leitura na cache
											writecache = 1'b0;
											// deu miss
											hit_miss = 1'b0;
											// determina o indice da cache
											address_cache[1:0] = indice;
											// verifica bloco mais antigo
											if(lru0[indice] == 1'b0)	// cache 0 mais antiga
												begin 
													// atualiza lru
													lru0[indice] = 1'b1;
													lru1[indice] = 1'b0;
													// determina qual cache
													address_cache[2] = 1'b0;
													// informa a ram o endereço do dado da cache
													address_ram = tag0[indice];
												end
											else
												begin 						// cache 1 mais antiga
													// atualiza lru
													lru0[indice] = 1'b0;
													lru1[indice] = 1'b1;
													// determina qual cache
													address_cache[2] = 1'b1;
													// informa a ram o endereço do dado da cache
													address_ram = tag1[indice];
												end
										end
								end
						end
				end
				// com writeback
				else 
					begin 
						// Desabilita o write back
						writeback = 1'b0;
						// habilita hit para escrever e ler
						hit_miss = 1'b1;
						// le ou escreve no novo bloco
						writecache = (read_write == 1'b1)? 1'b1: 1'b0;
						// descobre qual a cache mais recente para trazer o bloco
						if(lru0[indice] == 1'b1)	
							begin 
								// atualiza tag
								tag0[indice] = tag;
								// leitura da ram
								writeram = 1'b0;
								// atualiza dirty
								dirty0[indice] = 1'b1;
								// determina o indice do registrador da cache
								address_cache[1:0] = indice;
								address_cache[2] = 1'b0;	
								// atualiza dirty se read
								dirty0[indice] = (read_write == 1'b1)? 1'b1: 1'b0;
							end
						else
							begin 
								// atualiza tag
								tag1[indice] = tag;
								// leitura da ram
								writeram = 1'b0;
								// atualiza dirty
								dirty1[indice] = 1'b1;
								// determina o indice do registrador da cache
								address_cache[1:0] = indice;
								address_cache[2] = 1'b1;	
								// atualiza dirty se read
								dirty1[indice] = (read_write == 1'b1)? 1'b1: 1'b0;	
							end
					end
			
			// sinais a serem mostrados na placa		
			sinaisCache[0] = lru0[indice];
			sinaisCache[1] = lru1[indice];
			sinaisCache[2] = valido0[indice];
			sinaisCache[3] = valido1[indice];
			sinaisCache[4] = dirty0[indice];
			sinaisCache[5] = dirty1[indice];
					
		end	

endmodule

