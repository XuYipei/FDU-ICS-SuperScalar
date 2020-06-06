`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 15:43:20
// Design Name: 
// Module Name: RegFile
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


module RegFile(
        input logic clk,
        input logic we3,
        input logic [4:0] wa3,
        input logic [31:0] wd3, 
        input logic [4:0] ra1, ra2,
        output logic [31:0] rd1, rd2
    );  
    logic [31:0] rf[31:0];
    
    always_ff @(posedge clk)
        if (we3) rf[wa3]<=wd3;
    
    assign rd1=(ra1!=0)?(rf[ra1]):(0);
    assign rd2=(ra2!=0)?(rf[ra2]):(0);
endmodule
