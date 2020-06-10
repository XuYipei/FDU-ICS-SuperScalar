`include "cache.vh"

/**
 * NOTE: The sum of TAG_WIDTH, SET_WIDTH and OFFSET_WIDTH should be 32
 *
 * TAG_WIDTH    : (t) tag bits
 * SET_WIDTH    : (s) set index bits, the number of sets is 2**SET_WIDTH
 * OFFSET_WIDTH : (b) block offset bits
 * LINES        : number of lines per set
 *
 * stall        : inorder to synchronize instruction memroy cache and data memroy cache, you may need this so that two caches will write data at most once per instruction respectively.
 *
 * input_ready  : whether input data from processor are ready
 * addr         : cache read/write address from processor
 * write_data   : cache write data from processor
 * w_en         : cache write enable
 * hit          : whether cache hits
 * read_data    : data read from cache
 *
 * maddr        : memory address 
 * mwrite_data  : data written to memory
 * m_wen        : memory write enable
 * mread_data   : data read from memory
 */
module cache #(parameter TAG_WIDTH = `CACHE_T,
        SET_WIDTH = `CACHE_S,
		OFFSET_WIDTH = `CACHE_B,
		LINES = `CACHE_E
   )(
	   input logic clk, reset, stall,
       // interface with CPU
       input logic input_ready,
       input logic [31:0] addr, write_data,
       input logic w_en,
       output logic hit,
       output logic [31:0] read_data,
       // interface with memory
       output logic [31:0] maddr, mwrite_data,
       output logic m_wen,
       input logic [31:0] mread_data
       /* input mready // memory ready ? */
    );
    
    logic set_w_en;
    logic strategy_en;
    logic offset_sel, dirty;
    logic [OFFSET_WIDTH - 3: 0] offset;
    logic [SET_WIDTH - 1: 0] set_index; 
    logic [31: 0] caddr;
    logic [31: 0] read_data_arr [(1 << SET_WIDTH) - 1: 0];
    logic [TAG_WIDTH - 1: 0] tag_arr [(1 << SET_WIDTH) - 1: 0];
    
    logic [(1 << SET_WIDTH) - 1: 0] en_arr;
    logic [(1 << SET_WIDTH) - 1: 0] hit_arr, valid_arr, dirty_arr;
    
    logic set_valid, set_dirty;
    assign set_index = addr[OFFSET_WIDTH + SET_WIDTH - 1: OFFSET_WIDTH];  
    
    assign en_arr[0] = (set_index == 2'b00);
    assign en_arr[1] = (set_index == 2'b01);
    assign en_arr[2] = (set_index == 2'b10);
    assign en_arr[3] = (set_index == 2'b11);
    
    logic debug;
    always_ff @(posedge clk)
        if (w_en && input_ready)
            debug <= (addr == 8'b01010000);
    
    set set [(1 << SET_WIDTH) - 1: 0](.clk(clk), .reset(reset), .en(en_arr),
                                      .w_en(set_w_en),
                                      .set_valid(set_valid), .set_dirty(set_dirty),
                                      .offset(offset),
                                      .strategy_en(strategy_en),
                                      .offset_sel(offset_sel),
                                      .addr(addr), .write_data(write_data), .mread_data(mread_data),
                                      .hit(hit_arr), .dirty(dirty_arr),
                                      .read_data(read_data_arr),
                                      .tag(tag_arr));
                                                                            
    cache_controller cc(.clk(clk), .reset(reset), .en(input_ready),
                        .cw_en(w_en & !stall), .hit(hit), .dirty(dirty), 
                        .w_en(set_w_en), 
                        .set_valid(set_valid), .set_dirty(set_dirty),
                        .mw_en(m_wen), 
                        .block_offset(addr[OFFSET_WIDTH - 1: 2]),
                        .offset(offset),
                        .strategy_en(strategy_en),
                        .offset_sel(offset_sel));                        
    
    always @(*)
        begin
            if (input_ready)
                begin
                    read_data <= read_data_arr[set_index];
                    dirty <= dirty_arr[set_index];
                    hit <= hit_arr[set_index];
                end
            else
                begin
                    hit <= 1'b1;
                end
        end
    always @(*)
        begin
            caddr <= {tag_arr[set_index], set_index, offset, 2'b00};
            mwrite_data <= read_data;
            if (hit)
                maddr <= addr;
            else
                if (dirty)
                    maddr <= {tag_arr[set_index], set_index, offset, 2'b00};
                else
                    maddr <= {addr[31: SET_WIDTH + OFFSET_WIDTH], set_index, offset, 2'b00};
        end                    
endmodule
