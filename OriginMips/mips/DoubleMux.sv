`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/24 21:18:32
// Design Name: 
// Module Name: DoubleMux
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


module DoubleMux #(parameter WIDTH=8)
    (
        input logic [WIDTH-1:0] d0,d1,
        input logic s,
        output logic [WIDTH-1:0] y
    );
    assign y=(s)?(d1):(d0);
endmodule
