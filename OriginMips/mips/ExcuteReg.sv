`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 17:47:38
// Design Name: 
// Module Name: ExcuteReg
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


module ExcuteReg(
        input logic clk, reset, clr,
        input logic JumpLinkEIn, RegWriteEIn, MemtoRegEIn, MemWriteEIn,
        input logic [2:0] ALUControlEIn,
        input logic ALUSrcEIn, RegDstEIn, BitShiftEIn,
        input logic [31:0] rd1In, rd2In,
        input logic [4:0] rsEIn, rtEIn, rdEIn,
        input logic [31:0] ImmEIn, BitNumIn, PCPlus4EIn,
        output logic JumpLinkEOut, RegWriteEOut, MemtoRegEOut, MemWriteEOut,
        output logic [2:0] ALUControlEOut,
        output logic ALUSrcEOut, RegDstEOut, BitShiftEOut,
        output logic [31:0] rd1Out, rd2Out,
        output logic [4:0] rsEOut, rtEOut, rdEOut,
        output logic [31:0] ImmEOut, BitNumOut, PCPlus4EOut,
        input logic Ihit, Dhit
    );
    logic en;
    assign en = Dhit;
    D #(1) JumpLink(clk, en, reset, clr, JumpLinkEIn, JumpLinkEOut);
    D #(1) RegWrite(clk, en, reset, clr, RegWriteEIn, RegWriteEOut);
    D #(1) MemtoReg(clk, en, reset, clr, MemtoRegEIn, MemtoRegEOut);
    D #(1) MemWrite(clk, en, reset, clr, MemWriteEIn, MemWriteEOut);
    D #(3) ALUControl(clk, en, reset, clr, ALUControlEIn, ALUControlEOut);
    D #(1) ALUSrc(clk, en, reset, clr, ALUSrcEIn, ALUSrcEOut);
    D #(1) RegDst(clk, en, reset, clr, RegDstEIn, RegDstEOut);
    D #(1) BitShift(clk, en, reset, clr, BitShiftEIn, BitShiftEOut);
    D #(32) rd1(clk, en, reset, clr, rd1In, rd1Out);
    D #(32) rd2(clk, en, reset, clr, rd2In, rd2Out);
    D #(5) rsE(clk, en, reset, clr, rsEIn, rsEOut);
    D #(5) rdE(clk, en, reset, clr, rdEIn, rdEOut);
    D #(5) rtE(clk, en, reset, clr, rtEIn, rtEOut);
    D #(32) Imm(clk, en, reset, clr, ImmEIn, ImmEOut);
    D #(32) BitNum(clk, en, reset, clr, BitNumIn, BitNumOut);
    D #(32) PCPlus4(clk, en, reset, clr, PCPlus4EIn, PCPlus4EOut);
endmodule
