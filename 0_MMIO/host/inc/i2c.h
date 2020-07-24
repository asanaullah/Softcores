#include "mmio.h"
int readi2c(int address, int command){
int* rdata = I2C_RX_DATA;
int* addr = I2C_ADDR;
int* cmd  = I2C_CMD;
int* trigger = I2C_TRIGGER;	
int* busy = I2C_BUSY;

*addr = address;
*cmd = command;
while (*busy);
*trigger = 1;
while ((*busy) == 0);
*trigger = 0;
while (*busy);
return *rdata;
}


void writei2c(int address, int command, int data){
int* tdata = I2C_TX_DATA;
int* addr = I2C_ADDR;
int* cmd  = I2C_CMD;
int* trigger = I2C_TRIGGER;	
int* busy = I2C_BUSY;

*addr = address;
*cmd = command;
*tdata = data;
while (*busy);
*trigger = 1;
while ((*busy) == 0);
*trigger = 0;
while (*busy);
return; 
}