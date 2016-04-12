

set_time_format -unit ns -decimal_places 3


#create_clock -name {ref_clk} -period 40.000 -waveform { 0.000 5.000 } [get_ports {ref_clk}]

derive_pll_clocks -create_base_clocks

set SYS_CLK {pll_inst|altpll_component|auto_generated|pll1|clk[0]}

create_generated_clock -name dac_clk -divide_by 10 -phase 180 -source [get_pins $SYS_CLK] [get_registers dac_clk*]

create_generated_clock -name dac_clk_ext -divide_by 10 -phase 180 -source [get_pins $SYS_CLK]


#Info (332110): create_generated_clock -source {pll_inst|altpll_component|auto_generated|pll1|inclk[0]} -multiply_by 4 -duty_cycle 50.00 -name {pll_inst|altpll_component|auto_generated|pll1|clk[0]} {pll_inst|altpll_component|auto_generated|pll1|clk[0]}


#create_clock -period 100.0 -name dac_clk_ext

derive_clock_uncertainty

#set_clock_groups -asynchronous \
#                 -group [get_clocks ref_clk] \
#				  -group [get_clocks {*pll_inst*clk[0]}]
                                
#set_clock_groups -asynchronous \
#                 -group [get_clocks ref_clk] \
#				  -group [get_clocks dac_clk_ext]
										  
                                          
set_multicycle_path -from [get_clocks $SYS_CLK] -to dac_clk -start -setup 5
set_multicycle_path -from [get_clocks $SYS_CLK] -to dac_clk -start -hold  4


                                          