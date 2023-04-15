module HexDriver (
	input  [3:0]  In0,
	input	logic numbers,
	input logic notes,
	input logic flat,
   output logic [6:0]  Out0);
	
always_comb
	begin
		unique case (In0)
	 	   4'b0000   : Out0 = 7'b1000000; // '0'
	 	   4'b0001   : Out0 = 7'b1111001; // '1'
		   4'b0010   : Out0 = 7'b0100100; // '2'
	 	   4'b0011   : Out0 = 7'b0110000; // '3'
	 	   4'b0100   : Out0 = 7'b0011001; // '4'
		   4'b0101   : Out0 = 7'b0010010; // '5'
	 	   4'b0110   : Out0 = 7'b0000010; // '6'
	 	   4'b0111   : Out0 = 7'b1111000; // '7'
	 	   4'b1000   : Out0 = 7'b0000000; // '8'
		   4'b1001   : Out0 = 7'b0010000; // '9'
	 	   4'b1010   : Out0 = 7'b0001000; // 'A'
	 	   4'b1011   : Out0 = 7'b0000011; // 'b'
	 	   4'b1100   : Out0 = 7'b1000110; // 'C'
		   4'b1101   : Out0 = 7'b0100001; // 'd'
	 	   4'b1110   : Out0 = 7'b0000110; // 'E'
	 	   4'b1111   : Out0 = 7'b0001110; // 'F'
	 	   default   : Out0 = 7'bX;
	  	 endcase
	
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
	
		if (numbers)
			begin
				unique case (In0)
				// NUMBERS
					4'b0000   : Out0 = 7'b1000000; // '0'
					4'b0001   : Out0 = 7'b1111001; // '1'
					4'b0010   : Out0 = 7'b0100100; // '2'
					4'b0011   : Out0 = 7'b0110000; // '3'
					4'b0100   : Out0 = 7'b0011001; // '4'
					4'b0101   : Out0 = 7'b0010010; // '5'
					4'b0110   : Out0 = 7'b0000010; // '6'
					4'b0111   : Out0 = 7'b1111000; // '7'
					4'b1000   : Out0 = 7'b0000000; // '8'
					default   : Out0 = 7'b1111111;
				 endcase
			 end
		if (notes)
			begin
				unique case (In0)
				// NUMBERS
					4'b0001   : Out0 = 7'b1000110; // 'c'
					4'b0010   : Out0 = 7'b0100001; // 'd'
					4'b0011   : Out0 = 7'b0000110; // 'e'
					4'b0100   : Out0 = 7'b0001110; // 'f'
					4'b0101   : Out0 = 7'b1000010; // 'g'
					4'b0110   : Out0 = 7'b0001000; // 'a'
					4'b0111   : Out0 = 7'b0000011; // 'b'
					default   : Out0 = 7'b1111111;
				 endcase
			end
		if (flat) begin
			Out0 = 7'b1110111;
		end
		else begin
			Out0 = 7'b1111111;
		end
		
		
	end

endmodule