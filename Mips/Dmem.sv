`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 15:40:24
// Design Name: 
// Module Name: Dmem
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


module Dmem(
        input logic clk,we,
        input logic [31:0] a,wd,
        output logic [31:0] rd
    );
    logic debug;
    logic [31:0] RAM[127:0];
    assign rd=RAM[a[31:2]];
    always_ff @(posedge clk)
        if (we)
            begin
                RAM[a[31:2]]<=wd;
                debug <= (a[31: 2] == 5'b10100);
            end
endmodule
