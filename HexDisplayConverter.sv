module HexDisplayConverter (
	input	[2:0]  In0,
	input	[2:0] command, // numbers, notes, flat
   output logic [6:0]  Out0);
	
always_comb
	begin

	//				1
	//			-------
	//		 	|     |
	//		 6	|		| 2
	//			|	7	|
	//			-------
	//			|		|
	//		 5	|		| 3
	//			|		|
	//			-------
	//				4
	
		if (command[2] == 1)
			begin
				case (In0)
				// NUMBERS
				
					3'b000   : Out0 = 7'b1111111; // '7'
					3'b001   : Out0 = 7'b1111001; // '1'
					3'b010   : Out0 = 7'b0100100; // '2'
					3'b011   : Out0 = 7'b0110000; // '3'
					3'b100   : Out0 = 7'b0011001; // '4'
					3'b101   : Out0 = 7'b0010010; // '5'
					3'b110   : Out0 = 7'b0000010; // '6'
					3'b111   : Out0 = 7'b1111000; // '7'
					
					default   : Out0 = 7'b1111111;
				 endcase
			 end
		else if (command[1] == 1)
			begin
				case (In0)
				// NOTES
					3'b001   : Out0 = 7'b1000110; // 'c'
					3'b010   : Out0 = 7'b0100001; // 'd'
					3'b011   : Out0 = 7'b0000110; // 'e'
					3'b100   : Out0 = 7'b0001110; // 'f'
					3'b101   : Out0 = 7'b1000010; // 'g'
					3'b110   : Out0 = 7'b0001000; // 'a'
					3'b111   : Out0 = 7'b0000011; // 'b'
					default   : Out0 = 7'b1111111;
				 endcase
			end
		else if (command[0] == 1)
			begin
				Out0 = 7'b1110111;
			end
		else 
			begin
				Out0 = 7'b1111111;
			end
		
		
	end

endmodule
