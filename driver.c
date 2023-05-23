
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
//#include <time.h>
//#include <sys/mman.h>
//#include <stdbool.h>
//#include "mmap_hw_regs.h"
//#include "led.h"
//#include "dipsw_pio.h"
//#include "key_pio.h"
#include "pio_reg_in.h"
//#include "pio_reg_out.h"
#include "pio_reg_inout.h"
//#include "led_gpio.h"
//#include "key_gpio.h"
#include "driver.h"


unsigned int read_pio_reg_inout();
void write_pi_reg_inout( unsigned int pio_reg_inout );
void write_pio_reg_out( unsigned int pio_reg_out );
unsigned int read_pio_reg_in();	

void DRIVER_setup();

void DRIVER_setup() {
	PIO_REG_IN_setup();
	//PIO_REG_OUT_setup();
	PIO_REG_INOUT_setup();
}

unsigned int read_pio_reg_inout() {
	unsigned int pio_reg_inout = PIO_REG_INOUT_read();
	printf ("read pio_reg_inout\t%s\n", PIO_REG_INOUT_binary_string( pio_reg_inout ) );
	return pio_reg_inout;
}

unsigned int DRIVER_read_pio_reg_in() {
	return read_pio_reg_in();
}

unsigned int read_pio_reg_in() {
	unsigned int pio_reg_in = PIO_REG_IN_read();
	printf ("read pio_reg_in\t%s\n", PIO_REG_IN_binary_string( pio_reg_in  ) );
	return pio_reg_in;
}

void servo_robert(){
	unsigned int robert = PIO_REG_IN_read();
	int angle = robert*180/255;
	printf("Angle:\n%d", angle);
	usleep(100*1000);
}
/* 
void lecture(){
 
 
	int x = 0;
	for (;x<iter;x++) {
	 
	   //Lire les résultats des deux registres
	   printf( "Valeur reçue servo   :%d\n", servo_robert());
	   printf( "Freq reçue (Hz) :%d\n", read_pio_reg_inout() );
	   sleep(1);
	}
	
	printf("\n\n\n-----------Fin de la lecture-------------\n\n");
	
} */