reset_design
read_sdc
update_timing_netlist
qsta_utility::generate_all_summary_tables

report_timing -to_clock { pll|altpll_component|auto_generated|pll1|clk[0] } -setup -npaths 10 -detail path_only -panel_name {sys clk||Setup: pll|altpll_component|auto_generated|pll1|clk[0]}
report_timing -to_clock { pll|altpll_component|auto_generated|pll1|clk[0] } -hold  -npaths 10 -detail path_only -panel_name {sys clk||Hold:  pll|altpll_component|auto_generated|pll1|clk[0]}

report_timing -to_clock { ram_clk } -setup -npaths 10 -detail full_path -panel_name {RAM||Setup: ram_clk}
report_timing -to_clock { ram_clk } -hold -npaths  10 -detail full_path -panel_name {RAM||Hold: ram_clk}

