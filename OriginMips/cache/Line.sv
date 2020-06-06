`include "cache.vh"
/**
 * w_en: write enable
 */
module line #(
	parameter TAG_WIDTH    = `CACHE_T,
		      OFFSET_WIDTH = `CACHE_B
    )(
        input logic clk, reset,
        input logic [OFFSET_WIDTH - 3:0] offset,
        input logic w_en, set_valid, set_dirty,
        input logic [TAG_WIDTH - 1:0] set_tag,
        input logic [31:0] write_data,
        output logic valid, 
        output logic dirty,
        output logic [TAG_WIDTH - 1:0] tag,
        output logic [31:0] read_data
    );
    
    logic [7: 0] line_block [(1 << OFFSET_WIDTH) - 1 : 0];
    logic [TAG_WIDTH - 1 : 0] line_tag;
    logic [OFFSET_WIDTH - 1 : 0] line_index;
    logic line_valid, line_dirty;
    
    assign line_index = {offset, 2'b00 };     
    assign tag = line_tag;
    assign read_data = {line_block[line_index + 3], line_block[line_index + 2], line_block[line_index + 1], line_block[line_index]};
    assign dirty = line_dirty;
    assign valid = line_valid;
      
    integer i;
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset)
                begin
                    line_tag <= 0;
                    for (i = 0; i < (1 << OFFSET_WIDTH); i = i + 1)
                        line_block[i] <= 8'b0;
                    line_valid <= 0;
                    line_dirty <= 0;
                end
            else
                if (w_en)
                    begin 
                        line_tag <= set_tag;
                        {line_block[line_index + 3], line_block[line_index + 2], line_block[line_index + 1], line_block[line_index]} <= write_data;
                        line_valid <= set_valid;
                        line_dirty <= set_dirty;
                    end             
        end

endmodule
