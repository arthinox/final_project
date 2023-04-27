module fetch_sample (
	input I2S_LRCLK,
	input [5:0] note,
	output [15:0] sample
);

logic [15:0] rom [6006];

logic [15:0] c2_start, d_2_start, d2_start, e_2_start, e2_start, f2_start, g_2_start, g2_start, a_2_start, a2_start, b_2_start, b2_start;

assign c2_start 	= 16'h0000;
assign d_2_start 	= 16'h02a2;
assign d2_start 	= 16'h051e;
assign e_2_start 	= 16'h0777;
assign e2_start 	= 16'h09ae;
assign f2_start 	= 16'h0bc5;
assign g_2_start 	= 16'h0dbe;
assign g2_start 	= 16'h0f9b;
assign a_2_start 	= 16'h115d;
assign a2_start 	= 16'h1306;
assign b_2_start 	= 16'h1493;
assign b2_start 	= 16'h1611;

// if note is C2
//		start_index = c2_start;
//		end_index = d_2_start - 1;
// else if note is D_2
// 	start_index = d_2_start;
//		end_index = d2_start - 1;
//	...
//	else if note is B2
// 	start_index = b2_start;
//		end_index = 16'h1776 - 1;
//	else
//			start_index = 0;
//			end_index = 0;

logic [15:0] start_index, end_index;

always_comb
	begin
	unique case (note)
	6'b000000: // c2
		begin
			start_index = c2_start;
			end_index = d_2_start - 1;
		end
	6'b000001: // d_2
		begin
			start_index = d_2_start;
			end_index = d2_start - 1;
		end
	6'b000010: // d2
		begin
			start_index = d2_start;
			end_index = e_2_start - 1;
		end
	6'b000011: // e_2
		begin
			start_index = e_2_start;
			end_index = e2_start - 1;
		end
	6'b000100: // e2
		begin
			start_index = e2_start;
			end_index = f2_start - 1;
		end
	6'b000101: // f2
		begin
			start_index = f2_start;
			end_index = g_2_start - 1;
		end
	6'b000110: // g_2
		begin
			start_index = g_2_start;
			end_index = g2_start - 1;
		end
	6'b000111: // g2
		begin
			start_index = g2_start;
			end_index = a_2_start - 1;
		end
	6'b001000: // a_2
		begin
			start_index = a_2_start;
			end_index = a2_start - 1;
		end
	6'b001001: // a2
		begin
			start_index = a2_start;
			end_index = b_2_start - 1;
		end
	6'b001010: // b_2
		begin
			start_index = b_2_start;
			end_index = b2_start - 1;
		end
	6'b001011: // b2
		begin
			start_index = b_2_start;
			end_index = 16'h1776 - 1;
		end
	6'b111111: // b2
		begin
			start_index = 0;
			end_index = 0;
		end
	endcase
	end

logic [15:0] addr;
logic end_of_period;

always_ff @ (posedge I2S_LRCLK)
	begin
			if (addr < start_index)
				addr <= start_index;
			else if (addr >= end_index)
				addr <= start_index;
			else if (addr < end_index)
				addr <= addr + 1;
	end
	
always_comb
	begin
		sample = rom[addr];
	end

initial begin $readmemh("combined_notes.txt", rom); end

endmodule
