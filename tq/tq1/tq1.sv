//-----------------------------------------------------------------------------
//
//
//
//
module tq1
(
     input            ref_clk,
	 //input      [7:0] din,
     
	output bit       dac_clk,
	output bit [7:0] dout
);

//-----------------------------------------------------------------------------

localparam DAC_CLK_FACTOR = 10;

bit [$clog2(DAC_CLK_FACTOR)-1:0] cnt;

bit clk;

//-----------------------------------------------------------------------------
//
//   DAC clock counter
//
always_ff @(posedge clk) begin
    
	 if(cnt < DAC_CLK_FACTOR) begin
	     cnt <= cnt + 1;
	 end
     else begin
        cnt <= 0;
     end 
end

//-----------------------------------------------------------------------------
//
//   DAC clock generator
//
always_ff @(posedge clk) begin

    //dac_clk <= ~dac_clk;
    case(cnt)
    DAC_CLK_FACTOR/2 - 1: begin dac_clk <= 1; end 
    DAC_CLK_FACTOR - 1:   begin dac_clk <= 0; end 
    endcase
end
 
//-----------------------------------------------------------------------------
//
//   DAC data source
//
always_ff @(posedge clk) begin

    if(cnt == DAC_CLK_FACTOR/2-1) begin
        dout <= dout + 1;
    end

end


//-----------------------------------------------------------------------------
//
//   PLL clock
//
pll pll_inst
(
    .inclk0 ( ref_clk ),
	 .c0     ( clk     )
);




endmodule
//-----------------------------------------------------------------------------

