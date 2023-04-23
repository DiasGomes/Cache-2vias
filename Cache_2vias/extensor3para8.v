module extensor3para8(sinal, out);

	input[2:0] sinal;		
	output reg[7:0] out;

	always @(sinal)
		begin
			out[2:0] <= sinal;
			out[7:3] <= 5'b00000;
		end

endmodule
