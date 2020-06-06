`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 15:41:06
// Design Name: 
// Module Name: Imem
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


module Imem(
        input logic [5:0] a,
        output logic [31:0] rd
    );
    logic [31:0] RAM[63:0];
    initial 
        begin
            $readmemh("memfile.dat",RAM);
        end
        assign rd=RAM[a];
endmodule
