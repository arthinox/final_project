// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	int i = 0;
	volatile unsigned int *LED = (unsigned int*)0x80; //make a pointer to access the PIO block
	volatile unsigned int *SW = (unsigned int*)0x60; //make a pointer to access the PIO block
	volatile unsigned int *ACCU = (unsigned int*)0x50; //make a pointer to access the PIO block

	*LED = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{


		if (*ACCU == 0x0 && i == 0){
			*LED += *SW;
			*LED &= 0xff;
			i = 1;
		}

		if (*ACCU == 0x1){
			i = 0;
		}
//
//		for (i = 0; i < 100000; i++); //software delay
//		*LED |= 0x1; //set LSB
//		for (i = 0; i < 100000; i++); //software delay
//		*LED &= ~0x1; //clear LSB

	}
	return 1; //never gets here
}
