module synthesizer (
	input		clk,
	input		flat,
	input		[5:0] note,
//	input		[???:0] sample_num,
	input		[1:0] wave_select,
	output	[11:0] addr
);

// BLOCK DIAGRAM:		keyboard --> synthesizer --> modulation (if implemented) --> DSP (I2C)

// Samples for all 61 notes stored in on-chip RAM
// Each sample has a different period, so loop times will differ



endmodule
