## Clock (100 MHz)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.0 [get_ports clk]

## Reset Button (BTN0)
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Service Done Button (BTN1)
set_property PACKAGE_PIN T18 [get_ports service_done]
set_property IOSTANDARD LVCMOS33 [get_ports service_done]

## Switches
set_property PACKAGE_PIN V17 [get_ports vlsi_req]
set_property IOSTANDARD LVCMOS33 [get_ports vlsi_req]

set_property PACKAGE_PIN V16 [get_ports embedded_req]
set_property IOSTANDARD LVCMOS33 [get_ports embedded_req]

set_property PACKAGE_PIN W16 [get_ports comm_req]
set_property IOSTANDARD LVCMOS33 [get_ports comm_req]

set_property PACKAGE_PIN W17 [get_ports power_req]
set_property IOSTANDARD LVCMOS33 [get_ports power_req]

## LEDs
set_property PACKAGE_PIN W18 [get_ports vlsi_led]
set_property IOSTANDARD LVCMOS33 [get_ports vlsi_led]

set_property PACKAGE_PIN U15 [get_ports embedded_led]
set_property IOSTANDARD LVCMOS33 [get_ports embedded_led]

set_property PACKAGE_PIN U14 [get_ports comm_led]
set_property IOSTANDARD LVCMOS33 [get_ports comm_led]

set_property PACKAGE_PIN V14 [get_ports power_led]
set_property IOSTANDARD LVCMOS33 [get_ports power_led]

## Busy LED (LED15)
set_property PACKAGE_PIN L1 [get_ports system_busy]
set_property IOSTANDARD LVCMOS33 [get_ports system_busy]
