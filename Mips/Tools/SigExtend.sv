`timescale 1ns / 1ps

module SigExtend #(parameter WIDTH=32)
    (
        input logic [WIDTH-1:0] a,
        input logic zero,
        output logic [31:0] y
    );
    assign y = (zero == 1'b0) ? ({{(32 - WIDTH){a[WIDTH - 1]}}, a}) : ({{(32 - WIDTH){1'b0}}, a});
endmodule
