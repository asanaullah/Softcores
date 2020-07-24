module i2c(
	input clk,
	input  [3:0] sw, 
	output [7:0] led,
	
	input sda_in,
	output sda_out,
	output sda_sel,
	output scl,
	
	output reg [7:0] i2c_rx_data,
	output  i2c_busy,
	output reg i2c_ack,
	input [7:0] i2c_addr,
	input [7:0] i2c_cmd,
	input [7:0] i2c_tx_data,
	input i2c_trigger
  );

 

  reg [31:0] div_clk;
  initial div_clk = 32'd0;
  always @(posedge clk) div_clk <= div_clk + 32'd1; 
  
 
  
  reg reset;
  initial reset = 1'b1;
  always @(posedge div_clk[20])  begin
		reset <= 1'b0;
  end
  
  wire [154:0] big_reg_w;
  wire [154:0] big_reg_r;
  reg [154:0] big_reg;
  reg rw;
  reg [7:0] state;
  
 assign led = i2c_rx_data;
assign scl = ~ state[1];
 assign sda_out =  big_reg[8'd154 - state];
 assign sda_sel =  (((state >=  8'd35 ) && (state <= 8'd38) ) || ((state >=  8'd 71) && (state <= 8'd74)) || ((state >=  8'd115 ) && (state <= 8'd150))) ? 1'b1 : 
									(((state >=  8'd107) && (state <= 8'd110) ) ?  ~rw :
									 (((state >=  8'd111) && (state <= 8'd114) ) ?  rw :
									1'b0));
 wire finish =  (state == 8'd114) ?  ~rw :  ((state == 8'd154) ? 1'b1 : 1'b0);
 wire capture_data_input = ((state >=  8'd115 ) && (state <= 8'd145)) ? 1'b1 : 1'b0;
 wire capture_ack = (state >=  8'd35 ) && (state <= 8'd38) ? 1'b1: 1'b0;
  assign i2c_busy = (state == 8'd0) ?  1'b0 : 1'b1;
  
  always @(posedge scl) begin
	if (capture_data_input)
			i2c_rx_data <= {i2c_rx_data[6:0], sda_in};
	if (capture_ack)
			i2c_ack <= sda_in;
   end
   
  
  always @(posedge  div_clk[16] ) begin   //8
		if (reset || finish) begin
				state <= 0;
				big_reg <= {155{1'b1}};
				rw <= 0;
		end else if (state == 0) begin
				state <= {7'd0,i2c_trigger};
				rw <= i2c_addr[0];
				big_reg <= (i2c_addr[0]) ? big_reg_r: big_reg_w;
		end else
				state <= state + 8'd1;
end
	

  assign big_reg_r = {1'b1, 2'd0, {4{i2c_addr[7]}},  {4{i2c_addr[6]}}, {4{i2c_addr[5]}}, {4{i2c_addr[4]}}, {4{i2c_addr[3]}}, {4{i2c_addr[2]}}, {4{i2c_addr[1]}}, 4'd0,  
										4'b1111,  
										{4{i2c_cmd[7]}},  {4{i2c_cmd[6]}}, {4{i2c_cmd[5]}}, {4{i2c_cmd[4]}}, {4{i2c_cmd[3]}}, {4{i2c_cmd[2]}}, {4{i2c_cmd[1]}}, {4{i2c_cmd[0]}}, 
										4'b1111,
										2'b11, 2'b00,
										{4{i2c_addr[7]}},  {4{i2c_addr[6]}}, {4{i2c_addr[5]}}, {4{i2c_addr[4]}}, {4{i2c_addr[3]}}, {4{i2c_addr[2]}}, {4{i2c_addr[1]}}, {4{i2c_addr[0]}},
										4'b1111,
										32'hFFFF_FFFF,
										4'b1111,
										2'b00,
										2'b11};
										
	  assign big_reg_w = {1'b1, 2'd0, {4{i2c_addr[7]}},  {4{i2c_addr[6]}}, {4{i2c_addr[5]}}, {4{i2c_addr[4]}}, {4{i2c_addr[3]}}, {4{i2c_addr[2]}}, {4{i2c_addr[1]}}, {4{i2c_addr[0]}},  
										4'b1111,  
										{4{i2c_cmd[7]}},  {4{i2c_cmd[6]}}, {4{i2c_cmd[5]}}, {4{i2c_cmd[4]}}, {4{i2c_cmd[3]}}, {4{i2c_cmd[2]}}, {4{i2c_cmd[1]}}, {4{i2c_cmd[0]}}, 
										4'b1111,
										{4{i2c_tx_data[7]}},  {4{i2c_tx_data[6]}}, {4{i2c_tx_data[5]}}, {4{i2c_tx_data[4]}}, {4{i2c_tx_data[3]}}, {4{i2c_tx_data[2]}}, {4{i2c_tx_data[1]}}, {4{i2c_tx_data[0]}},
										4'b1111,
										2'b00,
										42'h3FF_FFFF_FFFF};
										


endmodule



/*
ST	0	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40	41	42	43	44	45	46	47	48	49	50	51	52	53	54	55	56	57	58	59	60	61	62	63	64	65	66	67	68	69	70	71	72	73	74	75	76	77	78	79	80	81	82	83	84	85	86	87	88	89	90	91	92	93	94	95	96	97	98	99	100	101	102	103	104	105	106	107	108	109	110	111	112	113	114	115	116	117	118	119	120	121	122	123	124	125	126	127	128	129	130	131	132	133	134	135	136	137	138	139	140	141	142	143	144	145	146	147	148	149	150	151	152	153	154


scl	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0	0	1	1	0
																																																																																																																																																											
DW	1	0	0	A7	A7	A7	A7	A6	A6	A6	A6	A5	A5	A5	A5	A4	A4	A4	A4	A3	A3	A3	A3	A2	A2	A2	A2	A1	A1	A1	A1	A0	A0	A0	A0 	1	1	1	1	R7	R7	R7	R7	R6	R6	R6	R6	R5	R5	R5	R5	R4	R4	R4	R4	R3	R3	R3	R3	R2	R2	R2	R2	R1	R1	R1	R1	R0	R0	R0	R0	1	1	1	1	D7	D7	D7	D7	D6	D6	D6	D6	D5	D5	D5	D5	D4	D4	D4	D4	D3	D3	D3	D3	D2	D2	D2	D2	D1	D1	D1	D1	D0	D0	D0	D0	1	1	1	1	0	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
																																																																																																																																																											
DR	1	0	0	A7	A7	A7	A7	A6	A6	A6	A6	A5	A5	A5	A5	A4	A4	A4	A4	A3	A3	A3	A3	A2	A2	A2	A2	A1	A1	A1	A1	0	0	0	0	1	1	1	1	R7	R7	R7	R7	R6	R6	R6	R6	R5	R5	R5	R5	R4	R4	R4	R4	R3	R3	R3	R3	R2	R2	R2	R2	R1	R1	R1	R1	R0	R0	R0	R0	1	1	1	1	1	1	0	0	A7	A7	A7	A7	A6	A6	A6	A6	A5	A5	A5	A5	A4	A4	A4	A4	A3	A3	A3	A3	A2	A2	A2	A2	A1	A1	A1	A1	A0	A0	A0	A0 	1	1	1	1	D7	D7	D7	D7	D6	D6	D6	D6	D5	D5	D5	D5	D4	D4	D4	D4	D3	D3	D3	D3	D2	D2	D2	D2	D1	D1	D1	D1	D0	D0	D0	D0	1	1	1	1	0	0	1	1
																																																																																																																																																											
sel	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	~RW	~RW	~RW	~RW	RW	RW	RW	RW	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	0	0	0
																																																																																																																																																											
FW	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	~RW	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1
																																																																																																																																																											
																																																																																																																																																											
CD	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0
																																																																																																																																																											
CA	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0

*/