module top (input clk_i, input [3:0] sw, 
						 output [3:0] led, output  [3:0] led_r, output [3:0] led_b, output [3:0] led_g,
						 output uart_tx, input uart_rx,
						 inout i2c_sda, output i2c_scl, output i2c_sda_pup, output i2c_scl_pup,
						 input spi_miso, output spi_mosi, output spi_clk, output spi_cs
						 );


	
    wire clk;
    BUFGCTRL bufg_i (
        .I0(clk_i),
        .CE0(1'b1),
        .S0(1'b1),
        .O(clk)
    );

	assign i2c_sda_pup = 1'b1;
	assign i2c_scl_pup = 1'b1;

reg [24:0] divclk;

always @(posedge clk)
    divclk <= divclk + 25'd1;

 	wire [7:0] uart_rx_data;
	wire uart_rx_busy;
	wire uart_rx_dv;
	wire uart_tx_busy;
	wire [7:0] uart_tx_data;
	wire uart_tx_dv;
	
	wire [7:0] 			i2c_rx_data;
	wire						i2c_busy;
	wire						i2c_ack;
	wire  [7:0]	i2c_addr;
	wire  [7:0]	i2c_cmd;
	wire  [7:0]	i2c_tx_data;
	wire  			i2c_trigger;
	
	wire i2c_sda_sel;
	wire i2c_sda_in;
	wire i2c_sda_out;
	
    wire [7:0] spi_tx_cmd;
	wire [7:0] spi_tx_data;
	wire [7:0] spi_rx_data;
	wire spi_busy;
	wire spi_trigger;
	
	
	IOBUF sd (.T(i2c_sda_sel),  .IO(i2c_sda), .I(i2c_sda_out), .O(i2c_sda_in) );

   // assign led = {i2c_sda_sel, i2c_scl, i2c_sda_out, i2c_sda_in};
 attosoc  cpu(
	.clk(clk),
	 
	// GPIO
	.sw(sw),
	.pb(0),
	.led(led),
	.led_b(led_b),
	.led_g(led_g),
	.led_r(led_r),
	
	//UART
	.uart_rx_data(uart_rx_data),
	.uart_rx_busy(uart_rx_busy),
	.uart_rx_trigger(uart_rx_dv),
	.uart_tx_busy(uart_tx_busy),
	.uart_tx_data(uart_tx_data), 
	.uart_tx_trigger(uart_tx_dv),
	
	//I2C
	.i2c_rx_data(i2c_rx_data),
	.i2c_busy(i2c_busy),
	.i2c_ack(i2c_ack),
	.i2c_addr(i2c_addr),
	.i2c_cmd(i2c_cmd),
	.i2c_tx_data(i2c_tx_data),
	.i2c_trigger(i2c_trigger),
	
	// SPI
	.spi_tx_cmd(spi_tx_cmd),
	.spi_tx_data(spi_tx_data),
        .spi_rx_data(spi_rx_data),
    	.spi_trigger(spi_trigger),
    	.spi_busy(spi_busy)
);


   

uart_tx  utx
  (
   .i_Clock(clk),
   .i_Tx_DV(uart_tx_dv),
   .i_Tx_Byte(uart_tx_data),   
   .o_Tx_Active(uart_tx_busy),
   .o_Tx_Serial(uart_tx),
   .o_Tx_Done()
   );
 
  
uart_rx utr 
  (
   .i_Clock(clk),
   .i_Rx_Serial(uart_rx),
   .o_Rx_DV(uart_rx_dv),
   . o_Rx_Byte(uart_rx_data)
   );
  
  
  i2c i2c_fsm
  (
	.clk(clk),
	.sw(sw),
	.led(),
	
	.sda_in(i2c_sda_in),
	.sda_out(i2c_sda_out),
	.sda_sel(i2c_sda_sel),
	.scl(i2c_scl),
	
	.i2c_rx_data(i2c_rx_data),
	.i2c_busy(i2c_busy),
	.i2c_ack(i2c_ack),
	.i2c_addr(i2c_addr),
	.i2c_cmd(i2c_cmd),
	.i2c_tx_data(i2c_tx_data),
	.i2c_trigger(i2c_trigger)
  );


spi spi_fsm
  (
   // Control/Data Signals,
   .clk(clk),
   .rst(sw[0]),
   .tx_cmd(spi_tx_cmd),
   .tx_data(spi_tx_data),
   .rx_data(spi_rx_data),
   .trigger(spi_trigger),
   .busy(spi_busy),
   // SPI Interface
   .spi_clk(spi_clk),
   .spi_miso(spi_miso),
   .spi_mosi(spi_mosi),
   .spi_cs(spi_cs)
   );


endmodule


module debounce(input i, output reg o, input clk);
reg [22:0] counter;
initial counter = 0;
always @(posedge clk) counter <= counter + 23'd1;
always @(posedge counter[20]) o <= i;
endmodule
