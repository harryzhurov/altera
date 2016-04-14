

set_time_format -unit ns -decimal_places 3


create_clock -name {ref_clk} -period 40.000 -waveform { 0.000 5.000 } [get_ports {ref_clk}]

derive_pll_clocks 

set SYS_CLK {pll|altpll_component|auto_generated|pll1|clk[0]}
set SCLK    {sclk_inst|ALTDDIO_OUT_component|auto_generated|ddio_outa[0]|muxsel}

create_generated_clock -name ram_clk -source [get_pins $SCLK] [get_ports {sclk}]

derive_clock_uncertainty

#  suppress warning about unconstraned  sclk
set_output_delay -clock [get_clocks ram_clk] -max 0 [get_ports {sclk}]
set_output_delay -clock [get_clocks ram_clk] -min 1 [get_ports {sclk}]

                                          