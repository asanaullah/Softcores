# R
set_property LOC G6 [get_ports led_r[0]]
set_property LOC G3 [get_ports led_r[1]]
set_property LOC J3 [get_ports led_r[2]]
set_property LOC K1 [get_ports led_r[3]]
# G
set_property LOC F6 [get_ports led_g[0]]
set_property LOC J4 [get_ports led_g[1]]
set_property LOC J2 [get_ports led_g[2]]
set_property LOC H6 [get_ports led_g[3]]
# B
set_property LOC E1 [get_ports led_b[0]]
set_property LOC G4 [get_ports led_b[1]]
set_property LOC H4 [get_ports led_b[2]]
set_property LOC K2 [get_ports led_b[3]]

# second row
 set_property LOC H5 [get_ports led[0]]
 set_property LOC J5 [get_ports led[1]]
 set_property LOC T9 [get_ports led[2]]
 set_property LOC T10 [get_ports led[3]]

set_property IOSTANDARD LVCMOS33 [get_ports led_r[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led_r[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led_r[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led_r[3]]

set_property IOSTANDARD LVCMOS33 [get_ports led_g[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led_g[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led_g[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led_g[3]]

set_property IOSTANDARD LVCMOS33 [get_ports led_b[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led_b[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led_b[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led_b[3]]

set_property IOSTANDARD LVCMOS33 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[3]]

set_property LOC A8 [get_ports sw[0]]
set_property LOC C11 [get_ports sw[1]]
set_property LOC C10 [get_ports sw[2]]
set_property LOC A10 [get_ports sw[3]]

set_property IOSTANDARD LVCMOS33 [get_ports sw[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[1]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[2]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[3]]

set_property LOC E3 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports clk_i]


##USB-UART Interface

set_property LOC D10 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]

set_property LOC A9 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]



##I2C Interface

set_property LOC M18 [get_ports i2c_sda]
set_property IOSTANDARD LVCMOS33 [get_ports i2c_sda]

set_property LOC L18   [get_ports i2c_scl]
set_property IOSTANDARD LVCMOS33 [get_ports i2c_scl]

set_property LOC A14  [get_ports i2c_sda_pup]
set_property IOSTANDARD LVCMOS33 [get_ports i2c_sda_pup]

set_property LOC A13  [get_ports i2c_scl_pup]
set_property IOSTANDARD LVCMOS33 [get_ports i2c_scl_pup]



