`timescale 1ns / 1ps

module WriteBackReg(
        input logic clk, reset, Stall, Flush,
        input logic RegWriteMOutA, MemtoRegMOutA,
        input logic [31: 0] ReadDataMOutA, ALUOutMOutA,
        input logic [4: 0] WriteRegMOutA,
        output logic RegWriteWInA, MemtoRegWInA,
        output logic [31: 0] ReadDataWInA, ALUOutWInA,
        output logic [4: 0] WriteRegWInA,
        input logic RegWriteMOutB, MemtoRegMOutB,
        input logic [31: 0] ReadDataMOutB, ALUOutMOutB,
        input logic [4: 0] WriteRegMOutB,
        output logic RegWriteWInB, MemtoRegWInB,
        output logic [31: 0] ReadDataWInB, ALUOutWInB,
        output logic [4: 0] WriteRegWInB
    );
    Latch #(1) RegWriteA (clk, reset, Stall, Flush, RegWriteMOutA, RegWriteWInA);
    Latch #(1) MemtoRegA (clk, reset, Stall, Flush, MemtoRegMOutA, MemtoRegWInA);
    Latch #(32) ReadDataA (clk, reset, Stall, Flush, ReadDataMOutA, ReadDataWInA);
    Latch #(32) ALUOutA (clk, reset, Stall, Flush, ALUOutMOutA, ALUOutWInA);
    Latch #(5) WriteRegA (clk, reset, Stall, Flush, WriteRegMOutA, WriteRegWInA);
    
    Latch #(1) RegWriteB (clk, reset, Stall, Flush, RegWriteMOutB, RegWriteWInB);
    Latch #(1) MemtoRegB (clk, reset, Stall, Flush, MemtoRegMOutB, MemtoRegWInB);
    Latch #(32) ReadDataB (clk, reset, Stall, Flush, ReadDataMOutB, ReadDataWInB);
    Latch #(32) ALUOutB (clk, reset, Stall, Flush, ALUOutMOutB, ALUOutWInB);
    Latch #(5) WriteRegB (clk, reset, Stall, Flush, WriteRegMOutB, WriteRegWInB);
endmodule
