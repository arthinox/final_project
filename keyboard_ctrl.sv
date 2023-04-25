module keyboard_ctrl (
	input		clk,
	input		[3:0] input1, input2,
//	input		[1:0] oct_range,
	output 	flat, instrument,
	output	[2:0] note,
	output	[2:0] octave
				
);

// Code that takes keyboard input and converts into data used by waveform generator

//	4/25/23 Need to expand to support octave switching
//				This means taking oct_range as input

//////////////////////// INSTRUMENTS ////////////////////////

logic [7:0] keycode;
assign keycode = 8'b00000000;
		

always_ff @ (posedge clk)
	begin
		if (input1 == 4'b0101 & input2 == 4'b1000)
			begin
				instrument <= 0;
			end
		if (input1 == 4'b0101 & input2 == 4'b1001)
			begin
				instrument <= 1;
			end
	end


//////////////////////// NOTES ////////////////////////
always_comb
	begin

//////////////////////// FIRST OCTAVE ////////////////////////
	
		if (input1 == 4'b0010 & input2 == 4'b1001) // Z (29) => C1
			begin
				note = 3'b001;
				octave = 3'b001;
				flat = 0;
			end
		else if (input1 == 4'b0010 & input2 == 4'b0010) // S (22) => _D1
			begin
				note = 3'b010;
				octave = 3'b001;
				flat = 1;
			end
		else if (input1 == 4'b0010 & input2 == 4'b0111) // X (27) => D1
			begin
				note = 3'b010;
				octave = 3'b001;
				flat = 0;
			end
		else if (input1 == 4'b0000 & input2 == 4'b0110) // C (06) => E1
			begin
				note = 3'b011;
				octave = 3'b001;
				flat = 0;
			end
		else if (input1 == 4'b0000 & input2 == 4'b0111) // D (07) => _E1
			begin
				note = 3'b011;
				octave = 3'b001;
				flat = 1;
			end
		else if (input1 == 4'b0010 & input2 == 4'b0101) // V (25) => F1
			begin
				note = 3'b100;
				octave = 3'b001;
				flat = 0;
			end
		else if (input1 == 4'b0000 & input2 == 4'b0101) // B (05) => G1
			begin
				note = 3'b101;
				octave = 3'b001;
				flat = 0;
			end
		else if (input1 == 4'b0001 & input2 == 4'b0000) // G (10) => _G1
			begin
				note = 3'b101;
				octave = 3'b001;
				flat = 1;
			end
		else if (input1 == 4'b0001 & input2 == 4'b0111) // N (17) => A1
			begin
				note = 3'b110;
				octave = 3'b001;
				flat = 0;
			end
		else if (input1 == 4'b0001 & input2 == 4'b0001) // H (11) => _A1
			begin
				note = 3'b110;
				octave = 3'b001;
				flat = 1;
			end
		else if (input1 == 4'b0001 & input2 == 4'b0110) // M (16) => B1
			begin
				note = 3'b111;
				octave = 3'b001;
				flat = 0;
			end
		else if (input1 == 4'b0001 & input2 == 4'b0011) // J (16) => _B1
			begin
				note = 3'b111;
				octave = 3'b001;
				flat = 1;
			end

			
//////////////////////// SECOND OCTAVE ////////////////////////

		else if (input1 == 4'b0101 & input2 == 4'b0100) // , (54) => C2
			begin
				note = 3'b001;
				octave = 3'b010;
				flat = 0;
			end
		else if (input1 == 4'b0001 & input2 == 4'b0101) // L (15) => _D2
			begin
				note = 3'b010;
				octave = 3'b010;
				flat = 1;
			end
		else if (input1 == 4'b0101 & input2 == 4'b0101) // . (55) => D2
			begin
				note = 3'b010;
				octave = 3'b010;
				flat = 0;
			end
		else if (input1 == 4'b0101 & input2 == 4'b0110) // / (56) => E2
			begin
				note = 3'b011;
				octave = 3'b010;
				flat = 0;
			end
		else if (input1 == 4'b0101 & input2 == 4'b0001) // ; (51) => _E2
			begin
				note = 3'b011;
				octave = 3'b010;
				flat = 1;
			end
		else if (input1 == 4'b0010 & input2 == 4'b0000) // Q (20) => F2
			begin
				note = 3'b100;
				octave = 3'b010;
				flat = 0;
			end
		else if (input1 == 4'b0010 & input2 == 4'b0110) // W (26) => G2
			begin
				note = 3'b101;
				octave = 3'b010;
				flat = 0;
			end
		else if (input1 == 4'b0011 & input2 == 4'b0001) // 2 (31) => _G2
			begin
				note = 3'b101;
				octave = 3'b010;
				flat = 1;
			end
		else if (input1 == 4'b0000 & input2 == 4'b1000) // E (8) => A2
			begin
				note = 3'b110;
				octave = 3'b010;
				flat = 0;
			end
		else if (input1 == 4'b0011 & input2 == 4'b0010) // 3 (32) => _A2
			begin
				note = 3'b110;
				octave = 3'b010;
				flat = 1;
			end
		else if (input1 == 4'b0010 & input2 == 4'b0001) // R (21) => B2
			begin
				note = 3'b111;
				octave = 3'b010;
				flat = 0;
			end
		else if (input1 == 4'b0011 & input2 == 4'b0011) // 4 (33) => _B2
			begin
				note = 3'b111;
				octave = 3'b010;
				flat = 1;
			end
			
//////////////////////// THIRD OCTAVE ////////////////////////

		else if (input1 == 4'b0010 & input2 == 4'b0011) // T (23) => C3
			begin
				note = 3'b001;
				octave = 3'b011;
				flat = 0;
			end
		else if (input1 == 4'b0011 & input2 == 4'b0101) // 6 (35) => _D3
			begin
				note = 3'b010;
				octave = 3'b011;
				flat = 1;
			end
		else if (input1 == 4'b0010 & input2 == 4'b1000) // Y (28) => D3
			begin
				note = 3'b010;
				octave = 3'b011;
				flat = 0;
			end
		else if (input1 == 4'b0010 & input2 == 4'b0100) // U (24) => E3
			begin
				note = 3'b011;
				octave = 3'b011;
				flat = 0;
			end
		else if (input1 == 4'b0011 & input2 == 4'b0110) // 7 (36) => _E3
			begin
				note = 3'b011;
				octave = 3'b011;
				flat = 1;
			end
		else if (input1 == 4'b0001 & input2 == 4'b0010) // I (12) => F3
			begin
				note = 3'b100;
				octave = 3'b011;
				flat = 0;
			end
		else if (input1 == 4'b0001 & input2 == 4'b1000) // O (18) => G3
			begin
				note = 3'b101;
				octave = 3'b011;
				flat = 0;
			end
		else if (input1 == 4'b0011 & input2 == 4'b1000) // 9 (38) => _G3
			begin
				note = 3'b101;
				octave = 3'b011;
				flat = 1;
			end
		else if (input1 == 4'b0001 & input2 == 4'b1001) // P (19) => A3
			begin
				note = 3'b110;
				octave = 3'b011;
				flat = 0;
			end
		else if (input1 == 4'b0011 & input2 == 4'b1001) // 0 (39) => _A3
			begin
				note = 3'b110;
				octave = 3'b011;
				flat = 1;
			end
		else if (input1 == 4'b0100 & input2 == 4'b0111) // [ (47) => B3
			begin
				note = 3'b111;
				octave = 3'b011;
				flat = 0;
			end
		else if (input1 == 4'b0100 & input2 == 4'b0101) // - (45) => _B3
			begin
				note = 3'b111;
				octave = 3'b011;
				flat = 1;
			end
		else if (input1 == 4'b0100 & input2 == 4'b1000) // ] (48) => C4
			begin
				note = 3'b001;
				octave = 3'b100;
				flat = 0;
			end
			
			
			
			
		else
			begin
				note = 3'b000;
				octave = 3'b000;
				flat = 0;
			end
			
	end

endmodule
