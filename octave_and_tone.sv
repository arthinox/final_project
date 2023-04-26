module OctaveAndTone (
	input clk,
	input [3:0] input1, input0,
	input is_note_on,
	output [1:0] oct_range,
	output [1:0] tone
);

// This module should be called within the keyboard_ctrl module.

// OPTIONS:
//
// 3 Octave modes: C2-C5 (F10), C3-C6 (F11), C4-C7 (F12)
//
// 2 instrument modes: square (F1), saw (F2)


logic [1:0] oct, inst;							// Octave and tone registers
logic [7:0] keycode;

assign keycode = {input1, input0};			// Concatenate hex inputs		

assign oct_range = oct;							// Wire registers to outputs
assign tone = inst;

always_ff @ (posedge clk)
	begin
		if (~is_note_on)
			begin
				if (keycode == 2'h43)			// Octaves
					oct <= 2'b00;
				else if (keycode == 2'h44)
					oct <= 2'b01;
				else if (keycode == 2'h45)
					oct <= 2'b10;
				if (keycode == 2'h3A)			// Tones
					inst <= 2'b00;
				else if (keycode == 2'h3B)
					inst <= 2'b01;
			end
	end


endmodule
