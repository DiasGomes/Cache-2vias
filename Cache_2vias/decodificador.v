module decodificador(entrada, saida);
	input [2:0] entrada;
	output reg [6:0] saida;
	always @(*)
	// configurando display de 7 segmentos
		begin
			case(entrada)
				3'b000 : saida = 7'b1000000;
				3'b001 : saida = 7'b1111001;
				3'b010 : saida = 7'b0100100;
				3'b011 : saida = 7'b0110000;
				3'b100 : saida = 7'b0011001;
				3'b101 : saida = 7'b0010010;
				3'b110 : saida = 7'b0000010;
				3'b111 : saida = 7'b1111000;
				default : saida = 7'b0111111;
			endcase
	end
endmodule
