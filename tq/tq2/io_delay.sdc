set_time_format -unit ns -decimal_places 3


set ADDR_TSU 1.5
set ADDR_TH  1.0

set DATA_TSU 1.5
set DATA_TH  1.0

set DATA_TCO 8.0
set DATA_TOH 2.5

set_output_delay -clock [get_clocks {ram_clk}] -max   $ADDR_TSU [get_ports {addr*}]   
set_output_delay -clock [get_clocks {ram_clk}] -min  -$ADDR_TH  [get_ports {addr*}]

set_output_delay -clock [get_clocks {ram_clk}] -max   $DATA_TSU [get_ports {data*}]   
set_output_delay -clock [get_clocks {ram_clk}] -min  -$DATA_TH  [get_ports {data*}]

set_input_delay  -clock [get_clocks {ram_clk}] -max   $DATA_TCO [get_ports {data*}]
set_input_delay  -clock [get_clocks {ram_clk}] -min   $DATA_TCO [get_ports {data*}]


set_multicycle_path -from [get_clocks ram_clk] -to [get_registers {*data_wr*}] -setup 2

#set_output_delay -clock [get_clocks {dac_clk_ext}] -max   0.0 [get_ports {dac_clk}]   
#set_output_delay -clock [get_clocks {dac_clk_ext}] -min   0.0 [get_ports {dac_clk}]
