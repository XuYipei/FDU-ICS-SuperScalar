`timescale 1ns / 1ps
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
module D #(parameter WIDTH = 32) (
        input logic clk,
        input logic en,
        input logic reset,
        input logic clr, 
        input logic [WIDTH-1:0] d,
        output logic [WIDTH-1:0] q
    );
    always_ff @(posedge clk, posedge reset)
        if (clr | reset) q <= 0;
        else if (en) q <= d;
endmodule
