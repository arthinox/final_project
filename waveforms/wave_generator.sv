
module wave_generator (
	input		clk,
	input		flat,
	input		[2:0] note, octave,
	input		[1:0] wave_select,
	output	[11:0] addr
);

always_ff @ (posedge clk) begin
	addr <= addr + 1;
end

endmodule
