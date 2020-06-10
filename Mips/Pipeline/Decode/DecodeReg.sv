`timescale 1ns / 1ps

module DecodeReg(
        input logic clk, reset,
        input logic Stall, Flush,
        input logic [31: 0] PCPlus4DInA, InstrDInA,
        output logic [31: 0] PCPlus4DOutA, InstrDOutA,
        input logic [31: 0] PCPlus4DInB, InstrDInB,
        output logic [31: 0] PCPlus4DOutB, InstrDOutB
    );
    Latch #(32) PCPlus4DA (clk, reset, Stall, Flush, PCPlus4DInA, PCPlus4DOutA);
    Latch #(32) PCPlus4DB (clk, reset, Stall, Flush, PCPlus4DInB, PCPlus4DOutB);
    Latch #(32) InstrDA (clk, reset, Stall, Flush, InstrDInA, InstrDOutA);
    Latch #(32) InstrDB (clk, reset, Stall, Flush, InstrDInB, InstrDOutB);
endmodule