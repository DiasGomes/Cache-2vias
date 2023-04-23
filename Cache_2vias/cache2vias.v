module cache2vias(clock, address_cache, dado, dado_ram, hit, writecache, data_out);
// inputs
	input	[2:0] dado, dado_ram, address_cache; 
	input clock, hit, writecache;
	
// outputs
	output [2:0] data_out;

// caches 
	reg [2:0] cache[7:0];

// Considerando os dados já preenchidos nas caches
	initial
	  begin	  
			// instancia a cache 1
			cache[0] = 3'b001;	
			cache[1] = 3'b011;	
			cache[2] = 3'b101;	
			cache[3] = 3'bxxx;
			// instancia a cache 2
			cache[4] = 3'b010;	
			cache[5] = 3'b100;	
			cache[6] = 3'b110;	
			cache[7] = 3'bxxx;	
	 end

	//escrita na cache
	always @(posedge clock)
		begin
			// escrita habilitada
			if(writecache == 1'b1) 
				begin
					// write hit ou miss
					cache[address_cache] = (hit == 1'b1)? dado : dado_ram; 
				end 
			else 
				begin
					// read miss
					if(hit == 1'b0) 
						begin
							cache[address_cache] = dado_ram; 
						end 
				end 
		end
		
//leitura do valor da cache 
assign data_out = cache[address_cache]; 

endmodule
