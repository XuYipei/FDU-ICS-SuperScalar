`include "cache.vh"
/**
 * en         : en in cache module
 * cw_en      : cache writing enable signal, from w_en in cache module
 * hit, dirty : from set module
 *
 * w_en       : writing enable signal to cache line
 * mw_en      : writing enable signal to memory , controls whether to write to memory
 * set_valid  : control signal for cache line
 * set_dirty  : control signal for cache line
 * offset_sel : control signal for cache line and this may be used in other places
 */
module cache_controller #(
            parameter OFFSET_WIDTH = `CACHE_B, 
            parameter INIT = 2'b00, READMEM = 2'b01, WRITEMEM = 2'b10
        )(
        input logic clk, reset, en,
        input logic cw_en, hit, dirty, // mready,
        output logic w_en, set_valid, set_dirty, mw_en,
        input logic [OFFSET_WIDTH - 3:0] block_offset,
        output logic [OFFSET_WIDTH - 3:0] offset,
        output logic strategy_en,
        output logic offset_sel
    );
    logic [2: 0] state, count;
    logic [5: 0] result;
    assign {w_en, set_valid, set_dirty, mw_en, strategy_en, offset_sel} = result;
    always @(*)
        begin
            if (reset) result <= 6'b100000;
            else 
                if (!en) result <= 6'b000000;
                else 
                    case (state)
                        INIT:
                            begin
                                if (hit)
                                    result <= {cw_en, 1'b1, dirty | cw_en, 1'b0, 1'b1, 1'b0};
                                else                                    
                                    if (dirty)
                                        result <= {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0};
                                    else
                                        result <= {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
                                offset <= (hit) ? block_offset : {count[1], count[0]};
                            end
                        READMEM:
                            begin
                                offset <= {count[1], count[0]};
                                result <= (count != 3'b011) ? {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1}
                                                            : {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1};
                            end
                        WRITEMEM:
                            begin
                                offset <= {count[1], count[0]};
                                result <= (count != 3'b100) ? {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0}
                                                            : {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0};
                            end
                    endcase
        end
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset) 
                begin
                    state <= INIT;
                    count <= 3'b000;
                    offset <= 2'b00;
                end 
            else
                if (en)
                begin
                    case (state)
                        INIT: 
                            if (hit) state <= INIT;
                            else 
                                begin
                                    if (dirty) state <= WRITEMEM;
                                    else state <= READMEM;
                                    count <= 3'b001;
                                end
                        READMEM:
                            begin
                                count = count + 3'b001;
                                if (count == 3'b100)
                                    begin
                                        state <= INIT;
                                        count <= 3'b000;
                                    end
                            end
                        WRITEMEM:
                            begin
                                count = count + 3'b001;
                                if (count == 3'b101) 
                                    begin
                                        state <= READMEM;
                                        count <= 3'b000;
                                    end
                            end                                
                    endcase
                end
        end
endmodule
