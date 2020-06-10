`timescale 1ns / 1ps

module Latch #(
        parameter WIDTH = 32
    )(
        input logic clk, reset,
        input logic Stall, Fulsh,
        input logic [WIDTH - 1: 0] a,
        output logic [WIDTH - 1: 0] b  
    );
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset | Fulsh)
                b <= {WIDTH{1'b0}};
            else
                if (!Stall)
                    b <= a;
        end
endmodule
