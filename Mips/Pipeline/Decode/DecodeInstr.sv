`timescale 1ns / 1ps
module DecodeInstr(
        input logic [5:0] op, func,
        output logic MemtoReg, MemWrite,
        output logic BitShift, Alusrc,
        output logic RegDst, RegWrite,
        output logic Jump, JumpReg, JumpLink,
        output logic [2:0] Alucontrol,
        output logic Branchbeq, Branchneq
    );
    logic [2:0] Aluop;
    logic Jp;
    MainDec md(op, MemtoReg, MemWrite, Branchneq, Branchbeq,
               Alusrc, RegDst, RegWrite, Jp, JumpLink, Aluop);
    AluDec ad(func, Aluop,
              Alucontrol, BitShift, JumpReg);
    assign Jump = Jp | JumpReg;
endmodule