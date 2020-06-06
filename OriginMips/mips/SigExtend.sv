`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 12:04:59
// Design Name: 
// Module Name: SigExtend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module SigExtend #(parameter WIDTH=32)
    (
        input logic [WIDTH-1:0] a,
        input logic zero,
        output logic [31:0] y
    );
    assign y = (zero == 1'b0) ? ({{(32 - WIDTH){a[WIDTH - 1]}}, a}) : ({{(32 - WIDTH){1'b0}}, a});
endmodule
