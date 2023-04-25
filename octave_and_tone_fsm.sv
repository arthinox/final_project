module OctaveAndToneFSM (
	input keycode,
	input is_note_on,
	output [1:0] oct_range,
	output [1:0] tone
);
// OPTIONS:
//
// 3 Octave modes: C2-C5 (F10), C3-C6 (F11), C4-C7 (F12)
//
// 2 instrument modes: square (F1), saw (F2)


// If note is currently being played, ignore octave switches
// else
// 	unique case (keycode)
//			F10: oct_range = 2'b00;
//			F11: oct_range = 2'b01;
//			F12: oct_range = 2'b10;
//			default: oct_range = 2'b01;

// If note is currently being played, ignore instrument switches
// else
//		unique case (keycode)
//			F1: tone = 2'b00;
//			F2: tone = 2'b01;
//			default: tone = 2'b00;

endmodule
