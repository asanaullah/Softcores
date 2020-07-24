#include "../inc/mmio.h"
#include "../inc/uart.h"
#include "../inc/i2c.h"
#include "../inc/spi.h"


void main(void){

int* upper_led = LED;
int* red_led = LED_R;
*upper_led = 8;

while (1){
	*red_led = 1;
	int cmd = readUART();
	int d1 = readUART();
	int d2 = readUART();
	int d3 = readUART();
	*red_led = 0;
	int data;
	if (cmd == 0){
		data = readi2c(d1,d2);
		writeUART(data);
	}
	else if (cmd == 1){
		writei2c(d1,d2,d3);
		data = d3;
		writeUART(data);
	}
	else if (cmd == 2){
		data = spi(d1,d2);
		writeUART(data);
	}
	else if (cmd == 3){
		int i;
		for (i=0; i < 2000; i++){
			data = spi(d1,d2);
			writeUART(data);
		}
	}
}

	

return;
}
