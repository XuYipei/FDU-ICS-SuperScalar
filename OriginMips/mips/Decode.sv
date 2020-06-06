`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 20:20:11
// Design Name: 
// Module Name: Decode
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


module Decode(
        input logic clk, we3,
        input logic [31:0] instrD, PCPlus4DIn,
        input logic [4:0] wa3, 
        input logic [31:0] wd3, 
        input logic [31:0] ALUOutM,
        input logic ForwardAD, ForwardBD,
        input logic BranchDIn,
        output logic BranchD, IsBranchD, JumpReg,
        output logic JumpLinkD, RegWriteD, MemtoRegD, MemWriteD,
        output logic [2:0] ALUControlD,
        output logic ALUSrcD, RegDstD, BitShiftD,
        output logic UseRd1,UseRd2,
        output logic [31:0] rd1, rd2,
        output logic [4:0] rsD, rtD, rdD,
        output logic [31:0] ImmD, BitNumD, PCPlus4DOut,
        output logic [31:0] PCBranchD, PCRegD, PCBranchRealD,
        output logic MistakeD
    );

    logic Brancheq, Branchneq, Jump;
    Controller Control(instrD[31:26], instrD[5:0],
                       MemtoRegD, MemWriteD,
                       BitShiftD, ALUSrcD,
                       RegDstD, RegWriteD, 
                       Jump, JumpReg, JumpLinkD,
                       ALUControlD,
                       Brancheq, Branchneq,
                       UseRd1, UseRd2);
    
    logic [31:0] rd1_, rd2_;
    assign rsD = instrD[25:21];
    assign rtD = instrD[20:16];
    assign rdD = instrD[15:11];
    RegFile regf(~clk, we3, 
                 wa3, wd3,
                 instrD[25:21], instrD[20:16], rd1_, rd2_);
    DoubleMux #(32) Muxrd1(rd1_, ALUOutM, ForwardAD ,rd1);
    DoubleMux #(32) Muxrd2(rd2_, ALUOutM, ForwardBD ,rd2);              
    
    logic zero;
    assign zero = {ALUControlD == 3'b000} | {ALUControlD == 3'b001};
    SigExtend #(5) SigBit(instrD[10:6], 1'b0, BitNumD);
    SigExtend #(16) SigImm(instrD[15:0], zero, ImmD);
    
    logic [31:0] ImmSl, PCBranchD_;
    Sl2 BranchSl(ImmD ,ImmSl);
    Adder BranchAdd(PCPlus4DIn, ImmSl, PCBranchD_); 
    assign PCRegD = rd1;
    
    logic eql;
    Equal #(32) Equalrd(rd1, rd2, eql);
    assign IsBranchD = Brancheq | Branchneq;
    assign BranchD = (eql & Brancheq) | ((~eql) & Branchneq);
    assign PCBranchD = PCBranchD_;
    assign PCPlus4DOut = PCPlus4DIn;
    assign PCBranchRealD = (BranchD) ? (PCBranchD) : (PCPlus4DIn);
    assign MistakeD = (BranchD ^ BranchDIn) & IsBranchD;
endmodule
