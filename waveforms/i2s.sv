module i2s_interface (
	input I2S_LRCLK, I2S_SCLK,
	input [31:0] sample,
	output I2S_DIN
);

logic [31:0] shift_reg;

//logic [5:0] sqrwv;              // Naive Square Wave generator
//logic [31:0] q;
//
//always_ff @ (posedge I2S_LRCLK)
//	begin
//		sqrwv <= sqrwv + 1;
//	end
//
//always_comb
//	begin
//		if (sqrwv[5])
//			q = 32'h00000000;
//		else
//			q = 32'h07ffffff;
//	end

logic [4:0] count;	// 5-bit counter (0-31)

always_ff @ (posedge I2S_SCLK) begin
	if (count == 0)
		begin
			shift_reg <= sample;
			count <= count + 1;
		end
	else
		begin
			shift_reg <= {shift_reg[30:0], 1'b0};
			count <= count + 1;
		end
end

assign	I2S_DIN = shift_reg[31];

endmodule
