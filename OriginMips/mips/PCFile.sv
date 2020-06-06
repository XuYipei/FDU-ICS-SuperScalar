`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 17:07:03
// Design Name: 
// Module Name: PCFile
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


module PCFile(
        input logic clk, reset, en,
        input logic [31:0] d,
        output logic [31:0] q,
        input Ihit, Dhit
    );
    always_ff @(posedge clk, posedge reset)
        if (reset) q<=0;
        else
            if (en & Ihit & Dhit) q<=d;
endmodule
