`include "cache.vh"
/**
 * ctls       : control signals from cache_controller
 * addr       : cache read/write address from processor
 * write_data : cache write data from processor
 * mread_data : data read from memory
 * 
 * hit        : whether cache set hits
 * dirty      : from the cache line selected by addr (cache line's tag is equal to addr's tag)
 */
module set #(parameter 
        SET_WIDTH = `CACHE_S,
        TAG_WIDTH = `CACHE_T,
        OFFSET_WIDTH = `CACHE_B,
		LINES = `CACHE_E
    )(
        input logic clk, reset, en,
        input logic w_en, set_valid, set_dirty,
        input logic [OFFSET_WIDTH - 3: 0] offset,
        input logic strategy_en,
        input logic offset_sel,
	    input logic [31:0] addr, write_data, mread_data,
	    output logic hit, dirty,
	    output logic [31:0] read_data,
	    output logic [TAG_WIDTH - 1: 0] tag
    );

    
    logic [TAG_WIDTH - 1: 0] addr_tag;
    assign addr_tag = addr[31: OFFSET_WIDTH + SET_WIDTH];
    
    logic [31: 0] line_read_data [LINES - 1: 0];
    logic [LINES - 1: 0] line_valid;
    logic [LINES - 1: 0] line_dirty;
    logic [LINES - 1: 0] line_wen;
    logic [TAG_WIDTH - 1: 0] line_tag [LINES - 1: 0];
    logic [31: 0] line_data [LINES - 1: 0];
    logic [31: 0] write_data_line;
    
    assign write_data_line = (!offset_sel) ? (write_data) : (mread_data);
    
    line line[LINES - 1: 0] (.clk(clk), .reset(reset),
                             .offset(offset), 
                             .w_en(line_wen), .set_valid(set_valid), .set_dirty(set_dirty),
                             .set_tag(addr_tag), .write_data(write_data_line),
                             .valid(line_valid), .dirty(line_dirty), 
                             .tag(line_tag), .read_data(line_data));
    
    LRU SetController(.clk(clk), .reset(reset), .en(strategy_en & en),
                      .addr_tag(addr_tag),
                      .line_tag(line_tag), 
                      .line_valid(line_valid), .line_dirty(line_dirty),
                      .line_data(line_data),
                      .wen(w_en & en),
                      .hit(hit), .dirty(dirty),
                      .line_wen(line_wen),
                      .read_data(read_data),
                      .replace_tag(tag));
                              
endmodule
