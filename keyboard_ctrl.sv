module keyboard_ctrl {
	input [7:0] keycode,
	input clk,
	
	output 	logic flat,
				logic [2:0] note,
				logic [2:0] octave
				logic instrument
};

// Code that takes keyboard input and converts into data used by waveform generator

//////////////////////// INSTRUMENTS ////////////////////////

always_ff @ (posedge clk)
	begin
	instrument <= 0;
		if (keycode == 8'h3a)
			begin
				instrument <= 0;
			end
		if (keycode == 8'h3b)
			begin
				instrument <= 1;
			end
	end


//////////////////////// NOTES ////////////////////////
always_comb
	begin
		case (keycode) begin
		
			8'h1d: // z: c1
				begin
					note = 3'b001;
					octave = 3'b001;
					flat = 0;
				end
			8'h1b: // x: d1
				begin
					note = 3'b010;
					octave = 3'b001;
					flat = 0;
				end
			8'h06: // c: e1
				begin
					note = 3'b011;
					octave = 3'b001;
					flat = 0;
				end
			8'h19: // v: f1
				begin
					note = 3'b100;
					octave = 3'b001;
					flat = 0;
				end
			8'h05: // b: g1
				begin
					note = 3'b101;
					octave = 3'b001;
					flat = 0;
				end
			8'h11: // n: a1
				begin
					note = 3'b110;
					octave = 3'b001;
					flat = 0;
				end
			8'h10: // m: b1
				begin
					note = 3'b111;
					octave = 3'b001;
					flat = 0;
				end
			
			8'h22: // s: d b1
				begin
					note = 3'b010;
					octave = 3'b001;
					flat = 1;
				end
			8'h07: // d: e b1
				begin
					note = 3'b011;
					octave = 3'b001;
					flat = 1;
				end
			8'h10: // g: g b1
				begin
					note = 3'b101;
					octave = 3'b001;
					flat = 1;
				end
			8'h04: // h: a b1
				begin
					note = 3'b110;
					octave = 3'b001;
					flat = 1;
				end
			8'h05: // j: b b1
				begin
					note = 3'b111;
					octave = 3'b001;
					flat = 1;
				end
			
			
			8'h36: // ,: c2
				begin
					note = 3'b001;
					octave = 3'b010;
					flat = 0;
				end
			8'h37: // .: d2
				begin
					note = 3'b010;
					octave = 3'b010;
					flat = 0;
				end
			8'h38: // /: e2
				begin
					note = 3'b011;
					octave = 3'b010;
					flat = 0;
				end
			8'h14: // q: f2
				begin
					note = 3'b100;
					octave = 3'b010;
					flat = 0;
				end
			8'h1a: // w: g2
				begin
					note = 3'b101;
					octave = 3'b010;
					flat = 0;
				end
			8'h08: // e: a2
				begin
					note = 3'b110;
					octave = 3'b010;
					flat = 0;
				end
			8'h15: // r: b2
				begin
					note = 3'b111;
					octave = 3'b010;
					flat = 0;
				end
			
			8'h15: // l: d b2
				begin
					note = 3'b010;
					octave = 3'b010;
					flat = 1;
				end
			8'h51: // ;: e b2
				begin
					note = 3'b011;
					octave = 3'b010;
					flat = 1;
				end
			8'h31: // 2: g b2
				begin
					note = 3'b101;
					octave = 3'b010;
					flat = 1;
				end
			8'h32: // 3: a b2
				begin
					note = 3'b110;
					octave = 3'b010;
					flat = 1;
				end
			8'h33: // 4: b b2
				begin
					note = 3'b111;
					octave = 3'b010;
					flat = 1;
				end
			
			8'h17: // t: c3
				begin
					note = 3'b001;
					octave = 3'b011;
					flat = 0;
				end
			8'h1c: // y: d3
				begin
					note = 3'b010;
					octave = 3'b011;
					flat = 0;
				end
			8'h18: // u: e3
				begin
					note = 3'b011;
					octave = 3'b011;
					flat = 0;
				end
			8'h1e: // i: f3
				begin
					note = 3'b100;
					octave = 3'b011;
					flat = 0;
				end
			8'h12: // o: g3
				begin
					note = 3'b101;
					octave = 3'b011;
					flat = 0;
				end
			8'h13: // p: a3
				begin
					note = 3'b110;
					octave = 3'b011;
					flat = 0;
				end
			8'h2f: // [: b3
				begin
					note = 3'b111;
					octave = 3'b011;
					flat = 0;
				end
			8'h30: // ]: c4
				begin
					note = 3'b001;
					octave = 3'b100;
					flat = 0;
				end
			
			8'h35: // 6: d b3
				begin
					note = 3'b010;
					octave = 3'b011;
					flat = 1;
				end
			8'h36: // 7: e b3
				begin
					note = 3'b011;
					octave = 3'b011;
					flat = 1;
				end
			8'h38: // 9: g b3
				begin
					note = 3'b101;
					octave = 3'b011;
					flat = 1;
				end
			8'h39: // 0: a b3
				begin
					note = 3'b110;
					octave = 3'b011;
					flat = 1;
				end
			8'h45: // -: b b3
				begin
					note = 3'b111;
					octave = 3'b011;
					flat = 1;
				end
			
		end
	end

endmodule
