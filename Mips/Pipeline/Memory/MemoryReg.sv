`timescale 1ns / 1ps

module MemoryReg(
        input logic clk, reset, Stall, Flush,
        input logic RegWriteEOutA, MemtoRegEOutA, MemWriteEOutA,
        input logic [31: 0] ALUOutEA, WriteDataEA,
        input logic [4: 0] WriteRegEOutA,
        output logic RegWriteMInA, MemtoRegMInA, MemWriteMInA,
        output logic [31:0] ALUOutMInA, WriteDataMInA,
        output logic [4:0] WriteRegMInA,
        
        input logic RegWriteEOutB, MemtoRegEOutB, MemWriteEOutB,
        input logic [31: 0] ALUOutEB, WriteDataEB,
        input logic [4: 0] WriteRegEOutB,
        output logic RegWriteMInB, MemtoRegMInB, MemWriteMInB,
        output logic [31:0] ALUOutMInB, WriteDataMInB,
        output logic [4:0] WriteRegMInB
    );
    Latch #(1) RegWriteA (clk, reset, Stall, Flush, RegWriteEOutA, RegWriteMInA);
    Latch #(1) MemtoRegA (clk, reset, Stall, Flush, MemtoRegEOutA, MemtoRegMInA);
    Latch #(1) MemWriteA (clk, reset, Stall, Flush, MemWriteEOutA, MemWriteMInA);
    Latch #(32) ALUOutA (clk, reset, Stall, Flush, ALUOutEA, ALUOutMInA);
    Latch #(32) WriteDataA (clk, reset, Stall, Flush, WriteDataEA, WriteDataMInA);
    Latch #(5) WriteRegA (clk, reset, Stall, Flush, WriteRegEOutA, WriteRegMInA);
    
    Latch #(1) RegWriteB (clk, reset, Stall, Flush, RegWriteEOutB, RegWriteMInB);
    Latch #(1) MemtoRegB (clk, reset, Stall, Flush, MemtoRegEOutB, MemtoRegMInB);
    Latch #(1) MemWriteB (clk, reset, Stall, Flush, MemWriteEOutB, MemWriteMInB);
    Latch #(32) ALUOutB (clk, reset, Stall, Flush, ALUOutEB, ALUOutMInB);
    Latch #(32) WriteDataB (clk, reset, Stall, Flush, WriteDataEB, WriteDataMInB);
    Latch #(5) WriteRegB (clk, reset, Stall, Flush, WriteRegEOutB, WriteRegMInB);
endmodule
