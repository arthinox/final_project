module i2s (
	input I2S_MCLK, I2S_DIN,
	input [23:0] sample;
	input I2S_LRCLK, I2S_SCLK,
	output I2S_DOUT
);

// Audio interface
// This module's job is to serialize parallel data to the SGTL5000.
// I2S_DIN is unused?

logic [31:0] shift_reg;

always_ff @ (posedge I2S_LRCLK) {				// Parallel load (right)
	shift_reg <= {1'b0, sample, 7'b0000000};
};

always_ff @ (negedge I2S_LRCLK) {				// Parallel load (left)
	shift_reg <= {1'b0, sample, 7'b0000000};
};

always_ff @ (posedge I2S_SCLK) {					// Left shift to I2S_DOUT
	I2S_DOUT <= shift_reg[31];
	shift_reg <= {shift_reg[30:0], 1'b0};
};


endmodule
