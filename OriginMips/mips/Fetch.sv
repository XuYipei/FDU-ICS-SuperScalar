`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/27 11:35:02
// Design Name: 
// Module Name: Fetch
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


module Fetch(
        input logic clk, reset, StallF,
        input logic MistakeD, JumpReg,
        input logic BranchPrd, Jump,
        input logic [31: 0] PCBranchD, PCReg, 
        input logic [31: 0] PCBranchF, PCJump,
        output logic [31: 0] PC,
        output logic [31: 0] PCPlus4FOut,
        input logic Ihit, Dhit 
    );
    logic [31: 0] PCPlus4F;
    logic [31: 0] PCJump_, PCBranchF_, PCJumpReg_, PCBranchD_;
    DoubleMux #(32) PCJumpMux(PCPlus4F, PCJump,
                              Jump, PCJump_);
    DoubleMux #(32) PCBranchFMux(PCJump_, PCBranchF,
                                 BranchPrd, PCBranchF_);
    DoubleMux #(32) PCBranchDMux(PCBranchF_, PCBranchD, 
                                 MistakeD, PCBranchD_);
    DoubleMux #(32) PCJumpRegMux(PCBranchD_, PCReg,
                                 JumpReg, PCJumpReg_);
    
    PCFile PCfile (clk, reset, ~StallF, PCJumpReg_, PC, Ihit, Dhit);
    Adder PCAdd (PC, 32'b0100, PCPlus4F);  
    assign PCPlus4FOut = PCPlus4F;                                     
endmodule
