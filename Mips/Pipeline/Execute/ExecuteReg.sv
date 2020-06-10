`timescale 1ns / 1ps

module ExecuteReg(
        input logic clk, reset, Stall, Flush,
        input logic JumpLinkDA, RegWriteDA, MemtoRegDA, MemWriteDA,
        input logic [2: 0] ALUControlDA,
        input logic ALUSrcDA, RegDstDA, BitShiftDA,
        input logic [4: 0] rd1DA, rd2DA,
        input logic [31: 0] rsDA, rtDA, rdDA,
        input logic [31: 0] ImmDA, BitNumDA, PCPlus4DOutA,
        output logic JumpLinkEInA, RegWriteEInA, MemtoRegEInA, MemWriteEInA,
        output logic [2: 0] ALUControlEInA,
        output logic ALUSrcEInA, RegDstEInA, BitShiftEInA,
        output logic [4: 0] rd1EA, rd2EA,
        output logic [31: 0] rsEA, rtEA, rdEA, 
        output logic [31: 0] ImmEA, BitNumEA, PCPlus4EInA,
        input logic JumpLinkDB, RegWriteDB, MemtoRegDB, MemWriteDB,
        input logic [2: 0] ALUControlDB,
        input logic ALUSrcDB, RegDstDB, BitShiftDB,
        input logic [4: 0] rd1DB, rd2DB,
        input logic [31: 0] rsDB, rtDB, rdDB,
        input logic [31: 0] ImmDB, BitNumDB, PCPlus4DOutB,
        output logic JumpLinkEInB, RegWriteEInB, MemtoRegEInB, MemWriteEInB,
        output logic [2: 0] ALUControlEInB,
        output logic ALUSrcEInB, RegDstEInB, BitShiftEInB,
        output logic [4: 0] rd1EB, rd2EB,
        output logic [31: 0] rsEB, rtEB, rdEB, 
        output logic [31: 0] ImmEB, BitNumEB, PCPlus4EInB
    );
    Latch #(1) JumpLinkA (clk, reset, Stall, Flush, JumpLinkDA, JumpLinkEInA);
    Latch #(1) RegWriteA (clk, reset, Stall, Flush, RegWriteDA, RegWriteEInA);
    Latch #(1) MemtoRegA (clk, reset, Stall, Flush, MemtoRegDA, MemtoRegEInA);
    Latch #(1) MemWriteA (clk, reset, Stall, Flush, MemWriteDA, MemWriteEInA);
    Latch #(3) ALUControlA (clk, reset, Stall, Flush, ALUControlDA, ALUControlEInA);
    Latch #(1) ALUSrcA (clk, reset, Stall, Flush, ALUSrcDA, ALUSrcEInA);
    Latch #(1) RegDstA (clk, reset, Stall, Flush, RegDstDA, RegDstEInA);
    Latch #(1) BitShiftA (clk, reset, Stall, Flush, BitShiftDA, BitShiftEInA);
    Latch #(5) rd1A (clk, reset, Stall, Flush, rd1DA, rd1EA);
    Latch #(5) rd2A (clk, reset, Stall, Flush, rd2DA, rd2EA);
    Latch #(32) rsA (clk, reset, Stall, Flush, rsDA, rsEA);
    Latch #(32) rtA (clk, reset, Stall, Flush, rtDA, rtEA); 
    Latch #(32) rdA (clk, reset, Stall, Flush, rdDA, rdEA); 
    Latch #(32) ImmA (clk, reset, Stall, Flush, ImmDA, ImmEA); 
    Latch #(32) BitNumA (clk, reset, Stall, Flush, BitNumDA, BitNumEA); 
    Latch #(32) PCPlut4A (clk, reset, Stall, Flush, PCPlus4DOutA, PCPlus4EInA); 
    
    Latch #(1) JumpLinkB (clk, reset, Stall, Flush, JumpLinkDB, JumpLinkEInB);
    Latch #(1) RegWriteB (clk, reset, Stall, Flush, RegWriteDB, RegWriteEInB);
    Latch #(1) MemtoRegB (clk, reset, Stall, Flush, MemtoRegDB, MemtoRegEInB);
    Latch #(1) MemWriteB (clk, reset, Stall, Flush, MemWriteDB, MemWriteEInB);
    Latch #(3) ALUControlB (clk, reset, Stall, Flush, ALUControlDB, ALUControlEInB);
    Latch #(1) ALUSrcB (clk, reset, Stall, Flush, ALUSrcDB, ALUSrcEInB);
    Latch #(1) RegDstB (clk, reset, Stall, Flush, RegDstDB, RegDstEInB);
    Latch #(1) BitShiftB (clk, reset, Stall, Flush, BitShiftDB, BitShiftEInB);
    Latch #(5) rd1B (clk, reset, Stall, Flush, rd1DB, rd1EB);
    Latch #(5) rd2B (clk, reset, Stall, Flush, rd2DB, rd2EB);
    Latch #(32) rsB (clk, reset, Stall, Flush, rsDB, rsEB);
    Latch #(32) rtB (clk, reset, Stall, Flush, rtDB, rtEB); 
    Latch #(32) rdB (clk, reset, Stall, Flush, rdDB, rdEB); 
    Latch #(32) ImmB (clk, reset, Stall, Flush, ImmDB, ImmEB); 
    Latch #(32) BitNumB (clk, reset, Stall, Flush, BitNumDB, BitNumEB); 
    Latch #(32) PCPlut4B (clk, reset, Stall, Flush, PCPlus4DOutB, PCPlus4EInB);
endmodule
