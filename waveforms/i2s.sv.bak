module i2s_interface (
	input I2S_LRCLK, I2S_SCLK,
	input [31:0] sample,
	output I2S_DIN
);

logic [31:0] shift_reg;

//always_ff @ (posedge I2S_LRCLK) begin
////	shift_reg <= {9'b000000000, sample, 7'b0000000};
//	shift_reg <= sample;
//end
//
//always_ff @ (negedge I2S_LRCLK) begin
////	shift_reg <= {9'b000000000, sample, 7'b0000000};
//	shift_reg <= sample;
//end

logic [5:0] sqrwv;
logic [31:0] q;

always_ff @ (posedge I2S_LRCLK)
	begin
		sqrwv <= sqrwv + 1;
	end

always_comb
	begin
		if (sqrwv[5])
			q = 32'h00000000;
		else
			q = 32'h07ffffff;
	end

logic [4:0] count;

always_ff @ (posedge I2S_SCLK) begin
	if (count == 0)
		begin
			shift_reg <= q;
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


//	counter resets every 32 clock cycles of SCLK (0 - 31)
// if counter = 0, load shift_reg with sample
// else left shift