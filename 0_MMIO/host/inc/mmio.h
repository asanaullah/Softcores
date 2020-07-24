#define OFFSET 	0x00001000							// RAM Width: 32 bit  , RAM Depth: 1024 words

// GPIO
#define	LED			OFFSET + (0 << 2)							//RW   0
#define LED_G 		OFFSET + (1 << 2)							//RW	4	
#define LED_R		OFFSET + (2 << 2)							//RW 8
#define LED_B	    OFFSET + (3 << 2)							//RW 12
#define SW			OFFSET + (4 << 2)							//R  16
#define PUSH_B	OFFSET + (5 << 2)							//R  20


// UART
#define UART_TX_DATA			OFFSET + (6 << 2)							//RW  24
#define UART_TX_BUSY				OFFSET + (7 << 2)							//RW 28
#define UART_TX_TRIGGER		OFFSET + (8 << 2)							//RW  32
#define UART_RX_DATA			OFFSET + (9 << 2)							//RW  36
#define UART_RX_FLAG				OFFSET + (10 << 2)							//RW   40


// I2C
#define I2C_RX_DATA			OFFSET + (11 << 2)							//RW   44
#define I2C_BUSY					OFFSET + (12 << 2)							//RW   48
#define I2C_ACK					OFFSET + (13 << 2)							//RW   52
#define I2C_ADDR				OFFSET + (14 << 2)							//R   56
#define I2C_CMD					OFFSET + (15 << 2)							//R   60
#define I2C_TX_DATA			OFFSET + (16 << 2)							//R   64
#define I2C_TRIGGER			OFFSET + (17 << 2)							//RW   68


// SPI
#define SPI_TX_CMD			OFFSET + (18 << 2)							//RW   72
#define SPI_TX_DATA			OFFSET + (19 << 2)							//R     76
#define SPI_RX_DATA			OFFSET + (20 << 2)							//RW   80
#define SPI_BUSY     			OFFSET + (21 << 2)							//R   84
#define SPI_TRIGGER			OFFSET + (22 << 2)							//R   88


