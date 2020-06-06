`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/05 00:31:34
// Design Name: 
// Module Name: FetchDec
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


module FetchPrd(
        input logic [31:0] instrFIn,
        input logic [31:0] PCPlus4F,
        output logic Jump, IsBranchF,
        output logic [31:0] PCJump,
        output logic [31:0] instrFOut
    );
    logic J, Jal;
    assign PCJump = {PCPlus4F[31:28], instrFIn[25:0], 2'b00};
    Equal #(6) IsJump(instrFIn[31:26], 6'b000011, J);
    Equal #(6) IsJumpandLink(instrFIn[31:26], 6'b000010, Jal);
    assign Jump = J | Jal;    
    logic Brancheq, Branchneq;
    Equal #(6) IsBrancheq(instrFIn[31:26], 6'b000100, Brancheq);
    Equal #(6) IsBranchneq(instrFIn[31:26], 6'b000101, Branchneq);
    assign IsBranchF = Branchneq | Brancheq;
endmodule

