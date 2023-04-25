//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h;
logic [9:0] blank;



//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic I2C_SCLIN, I2C_SCLOE, I2C_SDAIN, I2C_SDAOE;
	logic I2S_LRCLK, I2S_SCLK, I2S_DIN, I2S_DOUT, I2S_MCLK;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [7:0] keycode;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;

	
	////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////
	logic flat, instrument1, flat1, instrument2, flat2;
	logic [2:0] note1, octave1, note2, octave2;
	
	keyboard_ctrl KC2 (	.input1(hex_num_1),
								.input2(hex_num_0),
								.clk(MAX10_CLK1_50),
								.flat(flat2),
								.instrument(instrument2),
								.note(note2),
								.octave(octave2));
		
	keyboard_ctrl KC1 (	.input1(hex_num_4),
								.input2(hex_num_3),
								.clk(MAX10_CLK1_50),
								.flat(flat1),
								.instrument(instrument1),
								.note(note1),
								.octave(octave1));
	
	// HDC numbers, notes, flat
	HexDisplayConverter HDC5 (.In0(note1), .command(3'b000 + flat2), .Out0(HEX5[6:0]));
	HexDisplayConverter HDC4 (.In0(note2), .command(3'b010), .Out0(HEX4[6:0]));
	HexDisplayConverter HDC3 (.In0(octave2), .command(3'b100), .Out0(HEX3[6:0]));
	
	HexDisplayConverter HDC2 (.In0(note1), .command(3'b000 + flat1), .Out0(HEX2[6:0]));
	HexDisplayConverter HDC1 (.In0(note1), .command(3'b010), .Out0(HEX1[6:0]));
	HexDisplayConverter HDC0 (.In0(octave1), .command(3'b100), .Out0(HEX0[6:0]));
	
	always_comb
		begin
			if (instrument1 == 0)
				LEDR = 10'b0000011111;
			else if (instrument1 == 1)
				LEDR = 10'b1111100000;
			else 
				LEDR = 10'b0000000000;
		end
	
	assign HEX0[7] = 1'b1;
	assign HEX1[7] = 1'b1;
	assign HEX2[7] = 1'b1;
	assign HEX4[7] = 1'b1;
	assign HEX3[7] = 1'b1;
	assign HEX5[7] = 1'b1;
	
	////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////
	


	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);
	
	
	//Connect I2C signals
	assign I2C_SCLIN = ARDUINO_IO[15];
	assign I2C_SDAIN = ARDUINO_IO[14];

	assign ARDUINO_IO[15] = I2C_SCLOE ? 1'b0 : 1'bZ;
	assign ARDUINO_IO[14] = I2C_SDAOE ? 1'b0 : 1'bZ;

	assign  I2S_SCLK = ARDUINO_IO[5] ;
	assign  I2S_LRCLK = ARDUINO_IO[4];
	assign ARDUINO_IO[2] = I2S_DIN;
	assign ARDUINO_IO[1] = I2S_DOUT;
	
	// Feed Data In to Data Out (comment out unless testing codec)
//	assign ARDUINO_IO[1] = 1'bZ;
//	assign ARDUINO_IO[2] = ARDUINO_IO[1];
	
	logic [1:0] aud_mclk_ctr;								// Straight from lecture slides
	assign ARDUINO_IO[3] = aud_mclk_ctr[1];

	// generate 12.5MHz CODEC mclk
	always_ff @ (posedge MAX10_CLK1_50) begin
		aud_mclk_ctr <= aud_mclk_ctr + 1;
	end
	
	
	lab62_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, blank}),
		.keycode_export(keycode),
		
		.i2c_wire_sda_in(I2C_SDAIN),
		.i2c_wire_scl_in(I2C_SCLIN),
		.i2c_wire_sda_oe(I2C_SDAOE),
		.i2c_wire_scl_oe(I2C_SCLOE), 
		
	 );

	 /////////////////////////////////////////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////////////////////////////////////////
	 
	 
// I2S interface
	i2s_interface i2s0 (
		.I2S_LRCLK,
		.I2S_SCLK,
		.sample(),
		.I2S_DIN
	);
	
	




endmodule
