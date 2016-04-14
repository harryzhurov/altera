
set_time_format -unit ns -decimal_places 3


set ADDR_TSU 1.5
set ADDR_TH  1.0

set DATA_TSU 1.5
set DATA_TH  1.0

set DATA_TCO 8.0

set BOARD_PD 2.6

set_output_delay -clock [get_clocks {ram_clk}] -max   [expr $ADDR_TSU + $BOARD_PD] [get_ports {addr*}]   
set_output_delay -clock [get_clocks {ram_clk}] -min  -[expr $ADDR_TH  + $BOARD_PD] [get_ports {addr*}]

set_output_delay -clock [get_clocks {ram_clk}] -max   [expr $ADDR_TSU + $BOARD_PD] [get_ports {data*}]   
set_output_delay -clock [get_clocks {ram_clk}] -min  -[expr $ADDR_TH  + $BOARD_PD] [get_ports {data*}]

set_input_delay  -clock [get_clocks {ram_clk}] -max   $DATA_TCO [get_ports {data*}]
set_input_delay  -clock [get_clocks {ram_clk}] -min   $DATA_TCO [get_ports {data*}]

set_multicycle_path -from [get_clocks ram_clk] -to [get_registers {*data_in*}] -setup 2

