
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <stdbool.h>
#include "mmap_hw_regs.h"
#include "led.h"
#include "dipsw_pio.h"
#include "key_pio.h"
#include "pio_reg_in.h"
//#include "pio_reg_out.h"
//#include "pio_reg_inout.h"
#include "led_gpio.h"
#include "key_gpio.h"
#include "driver.h"


void test_all();


unsigned int DRIVER_read_pio_reg_inout();
void write_pi_reg_inout( unsigned int pio_reg_inout );
void write_pio_reg_out( unsigned int pio_reg_out );
unsigned int DRIVER_read_pio_reg_in();
void DRIVER_out_write_data( unsigned int data );	

void *h2p_lw_reg3_addr;
void *h2p_lw_reg4_addr;

int main(int argc, char **argv) {
	MMAP_open();
	LEDR_setup();
	DIPSW_setup();
	KEY_PIO_setup();
	LED_gpio_setup();
	KEY_gpio_setup();
	DRIVER_setup();

	// while(1) {	
		// test_all();
	// }
	MMAP_close();
	int i =0;
	int n= 0;
	printf("Inserez le nombre de valeur de robert ");
	scanf("%d", &n);
	printf("La valeur que vous avez entrée est : %d\n", n);
	
	
	for(i=0;i<n;i++) {
		servo_robert();
		sleep(1);
	}
	return 0;
}

void test_all() {	
	
	unsigned int dipsw_reg = 0;
	unsigned int key_pio_reg = 0;
	// unsigned int pio_reg_in = 0;
	unsigned int pio_reg_out = 0;
	// unsigned int pio_reg_inout = 0;
	// unsigned int data = 0;

	// int i;
	// /*dipsw_reg = DIPSW_read();
	// printf ("dipsw_reg  %s\n", DIPSW_binary_string( dipsw_reg ) );
	// key_pio_reg = KEY_PIO_read();
	// printf ("key_pio_reg  %s\n", KEY_PIO_binary_string( key_pio_reg ) );
	// */
	
	
	//test writing data 
	// data = 0xAA;
	// DRIVER_out_write_data( data );	
	// printf("read data\r\n");
	// if ( ( pio_reg_in = DRIVER_read_pio_reg_in() ) != data ) {	
		// printf("***ERROR data not written %X\r\n", data );
	// }
	
	//test writing data 
	// data = 0x55;
	// DRIVER_out_write_data( data );	
	// printf("read data\r\n");
	// if ( ( pio_reg_in = DRIVER_read_pio_reg_in() ) != data ) {	
		// printf("***ERROR data not written %X\r\n", data );
	// }
	
	// test writing data 
	// data = 0xF0;
	// DRIVER_out_write_data( data );	
	// printf("read data\r\n");
	// if ( ( pio_reg_in = DRIVER_read_pio_reg_in() ) != data ) {	
		// printf("***ERROR data not written %X\r\n", data );
	// }
		
	// printf("LED gpio on\r\n");
	// LED_gpio_on();
	// printf("LED ON \r\n");
	// for(i=0;i<=8;i++){
		// LEDR_LightCount(i);
		// usleep(100*1000);
	// }
	// printf("LED gpio off\r\n");
	// LED_gpio_off();
	// printf("LED OFF \r\n");
	// for(i=0;i<=8;i++){
		// LEDR_OffCount(i);
		// usleep(100*1000);
	// }
		
 }
