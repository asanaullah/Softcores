module spi
  (
   // Control/Data Signals,
   input clk,
   input rst,
   input [7:0] tx_cmd,
   input [7:0] tx_data,
   output reg [7:0] rx_data,
   input trigger,
   output busy, 
   
   output spi_clk,
   input spi_miso,
   output spi_mosi,
   output  spi_cs
 ); 


reg [31:0] div_clk;
  initial div_clk = 32'd0;
  always @(posedge clk) div_clk <= div_clk + 32'd1; 
  
 
  
  wire reset = rst;
  

  reg [64:0] data_reg;
  reg [64:0] clk_reg;
  reg [7:0] state;
  
 assign spi_cs = (state == 8'd0) ?  1'b1 : 1'b0;
 assign spi_mosi =  data_reg[state];
 assign spi_clk =   clk_reg[state];
 wire finish =  (state >= 8'd64) ?  1'b1 : 1'b0;
 wire capture_data_input = (state > 0) ? 1'b1 : 1'b0;
 assign busy = (state == 8'd0) ?  1'b0 : 1'b1;
  
  always @(posedge spi_clk) begin
	if (capture_data_input)
			rx_data <= {rx_data[6:0], spi_miso};
   end
   
  
  always @(posedge  div_clk[3] ) begin   //8
		if (reset || finish) begin
				state <= 0;
				data_reg <= 0;
				clk_reg <= 0;

		end else if (state == 0) begin
				state <= {7'd0,trigger};
				data_reg <= {
				{4{tx_data[0]}},  {4{tx_data[1]}}, {4{tx_data[2]}}, {4{tx_data[3]}}, {4{tx_data[4]}}, {4{tx_data[5]}}, {4{tx_data[6]}}, {4{tx_data[7]}},
                {4{tx_cmd[0]}},  {4{tx_cmd[1]}}, {4{tx_cmd[2]}}, {4{tx_cmd[3]}}, {4{tx_cmd[4]}}, {4{tx_cmd[5]}}, {4{tx_cmd[6]}}, {5{tx_cmd[7]}}				
				};
				clk_reg <= {{16{4'b0110}} , 1'b0};
		end else
				state <= state + 8'd1;
end
	


										


endmodule