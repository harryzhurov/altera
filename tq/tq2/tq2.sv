

//------------------------------------------------------------------------------
module tq1
#(
    parameter ADDR_W = 10,
    parameter DATA_W = 8
)
(
    input                   ref_clk,

     
    output bit [ADDR_W-1:0] addr,
    inout      [DATA_W-1:0] data,
    
    output bit              sclk
);

//------------------------------------------------------------------------------

localparam COUNT = 1000;

//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
typedef struct
{
    bit [ADDR_W-1:0] addr_wr;
    bit [ADDR_W-1:0] addr_rd;
    bit [DATA_W-1:0] data_wr;
    bit [DATA_W-1:0] data_rd;
    bit              wren;
}
ram_signals_t;

typedef enum bit [2:0]
{
    IDLE,
    WRITE,
    PAUSE,
    READ
}
fsm_t;
//------------------------------------------------------------------------------
bit [$clog2(COUNT)-1:0] cnt;

bit clk;
bit clk_shift;

bit oe;

bit [DATA_W-1:0] data_in;
bit [DATA_W-1:0] data_out;
bit [ADDR_W-1:0] addr_out;

ram_signals_t ram_signals;
fsm_t         fsm;
//------------------------------------------------------------------------------
assign data     = oe ? data_out : 8'bz;
assign addr_out = fsm == WRITE ? ram_signals.addr_wr : ram_signals.addr_rd;
//assign ram_signals.data_wr = data;

always_ff @(posedge clk) begin

	if(ram_signals.addr_rd > 3) begin
		data_out <= ram_signals.data_rd + ram_signals.addr_rd - data_out;
	end

	data_in             <= data;
	ram_signals.data_wr <= data_in;   
    addr                <= addr_out;
end

always_ff @(posedge clk) begin

    ram_signals.wren    <= 0;
    oe                  <= 0;
    case(fsm)
    //--------------------------------
    IDLE: begin
        fsm                 <= WRITE;
        ram_signals.addr_wr <= 0;
        ram_signals.addr_rd <= 0;
    end
    //--------------------------------
    WRITE: begin
        if(cnt < COUNT) begin
            cnt                 <= cnt + 1;
            ram_signals.addr_rd <= ram_signals.addr_rd + 1;
        end
        else begin
            cnt <= 0;
            fsm <= PAUSE;
        end
    end
    //--------------------------------
    PAUSE: begin
        fsm              <= READ;
        oe               <= 1;
        ram_signals.wren <= 1;
    end
    //--------------------------------
    READ: begin
        if(cnt < COUNT) begin
            cnt                 <= cnt + 1;
            ram_signals.addr_wr <= ram_signals.addr_wr + 1;
            ram_signals.wren    <= 1;
            oe                  <= 1;
        end
        else begin
            cnt <= 0;
            fsm <= IDLE;
        end
    end
    //--------------------------------
    endcase
end

//------------------------------------------------------------------------------
pll_m pll
(
    .inclk0  ( ref_clk   ),
    .c0      ( clk       ),
    .c1      ( clk_shift )
);
//------------------------------------------------------------------------------
ram_m ram 
(
    .clock     ( clk ),
    .data      ( ram_signals.data_wr ),
    .rdaddress ( ram_signals.addr_rd ),
    .wraddress ( ram_signals.addr_wr ),
    .wren      ( ram_signals.wren    ),
    .q         ( ram_signals.data_rd )
);
//------------------------------------------------------------------------------
ddo_m sclk_inst
(
    .aclr     ( 1'b0      ),
    .datain_h ( 1'b1      ),
    .datain_l ( 1'b0      ),
    .outclock ( clk_shift ),
    .dataout  ( sclk      )
);
//------------------------------------------------------------------------------
      

endmodule

//------------------------------------------------------------------------------
