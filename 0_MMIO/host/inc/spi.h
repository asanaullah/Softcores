#include "mmio.h"



int spi(int cmd, int data){
	int* tx_cmd = SPI_TX_CMD;
	int* tx_data = SPI_TX_DATA;
	int* rx_data = SPI_RX_DATA;
	int* busy = SPI_BUSY;
	int* trigger = SPI_TRIGGER;
	*tx_cmd = cmd;
	*tx_data = data;
	while (*busy);
	*trigger = 1;
	while(*busy == 0);
	*trigger = 0;
	while (*busy);
	return *rx_data;
}

