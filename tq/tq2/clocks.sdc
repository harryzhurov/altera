

set_time_format -unit ns -decimal_places 3


create_clock -name {ref_clk} -period 40.000 -waveform { 0.000 5.000 } [get_ports {ref_clk}]

derive_pll_clocks 

set SYS_CLK {pll|altpll_component|auto_generated|pll1|clk[0]}
#set SCLK    {pll|altpll_component|auto_generated|pll1|clk[1]}
set SCLK    {sclk_inst|ALTDDIO_OUT_component|auto_generated|ddio_outa[0]|muxsel}
#pll|altpll_component|auto_generated|pll1|clk[1]

create_generated_clock -name ram_clk -source [get_pins $SCLK] [get_ports sclk]

#Info (332110): create_generated_clock -source {pll_inst|altpll_component|auto_generated|pll1|inclk[0]} -multiply_by 4 -duty_cycle 50.00 -name {pll_inst|altpll_component|auto_generated|pll1|clk[0]} {pll_inst|altpll_component|auto_generated|pll1|clk[0]}


#create_clock -period 100.0 -name dac_clk_ext

derive_clock_uncertainty

#set_clock_groups -asynchronous \
#                 -group [get_clocks ref_clk] \
#				  -group [get_clocks {*pll_inst*clk[0]}]
                                
#set_clock_groups -asynchronous \
#                 -group [get_clocks ref_clk] \
#				  -group [get_clocks dac_clk_ext]
										  
                                          
#set_multicycle_path -from [get_clocks $SYS_CLK] -to dac_clock -start -setup 5
#set_multicycle_path -from [get_clocks $SYS_CLK] -to dac_clock -start -hold  4


                                          