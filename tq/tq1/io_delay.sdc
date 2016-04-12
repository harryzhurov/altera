set_time_format -unit ns -decimal_places 3


#set_output_delay -clock dac_clk_ext -max  2.5 [get_ports {dout*}]   
#set_output_delay -clock dac_clk_ext -min -1.0 [get_ports {dout*}]

set_output_delay -clock [get_clocks {dac_clk}] -max   2.5 [get_ports {dout*}]   
set_output_delay -clock [get_clocks {dac_clk}] -min  -1.0 [get_ports {dout*}]

set_output_delay -clock [get_clocks {dac_clk_ext}] -max   0.0 [get_ports {dac_clk}]   
set_output_delay -clock [get_clocks {dac_clk_ext}] -min   0.0 [get_ports {dac_clk}]
