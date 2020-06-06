`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 11:46:38
// Design Name: 
// Module Name: TripleMux
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


module TripleMux #(parameter WIDTH=8)
    (
        input logic [WIDTH-1:0] d0,d1,d2,
        input logic [1:0]s,
        output logic [WIDTH-1:0] y
    );
    always @(*)
        case (s)
            2'b00: y<=d0;
            2'b01: y<=d1;
            default: y<=d2;
        endcase
endmodule
