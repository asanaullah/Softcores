#include "mmio.h"
void writeUART(int data){
	int* tx_busy = UART_TX_BUSY;
	int* tx_data = UART_TX_DATA;
	int* tx_trigger = UART_TX_TRIGGER;
	while (*tx_busy);
	*tx_data = data;
	*tx_trigger = 1;
	while (*tx_busy == 0);
	*tx_trigger = 0;
	while (*tx_busy);
}


int readUART(){
	int* rx_flag = UART_RX_FLAG;
	int* rx_data = UART_RX_DATA;
	while (*rx_flag == 0);
	*rx_flag = 0;
	int data = *rx_data;
	return data; 
} 