`timescale 1ns / 1ps

module Memory(
        input logic RegWriteMInA, MemtoRegMInA, MemWriteMInA,
        input logic [31:0] ALUOutMInA, WriteDataMInA,
        input logic [4:0] WriteRegMInA,
        output logic [31:0] ALUOutMOutA, 
        output logic [4:0] WriteRegMOutA,
        output logic [31:0] DataAddrA, WriteDataA, ReadDataMOutA, 
        output logic MemWriteMOutA, MemtoRegMOutA, RegWriteMOutA,
        //InstrA
        input logic RegWriteMInB, MemtoRegMInB, MemWriteMInB,
        input logic [31:0] ALUOutMInB, WriteDataMInB,
        input logic [4:0] WriteRegMInB,
        output logic [31:0] ALUOutMOutB, 
        output logic [4:0] WriteRegMOutB,
        output logic [31:0] DataAddrB, WriteDataB, ReadDataMOutB, 
        output logic MemWriteMOutB, MemtoRegMOutB, RegWriteMOutB,
        //InstrB
        output logic Wen, Ren,
        output logic [31: 0] Addr, WriteData,
        input logic [31: 0] ReadData
        //cache        
    );
    assign ALUOutMOutA = ALUOutMInA;
    assign WriteRegMOutA = WriteRegMInA;
    assign DataAddrA = ALUOutMInA;
    assign WriteDataA = WriteDataMInA;
    assign MemWriteMOutA = MemWriteMInA;
    assign MemtoRegMOutA = MemtoRegMInA;
    assign RegWriteMOutA = RegWriteMInA;
    
    assign ALUOutMOutB = ALUOutMInB;
    assign WriteRegMOutB = WriteRegMInB;
    assign DataAddrB = ALUOutMInB;
    assign WriteDataB = WriteDataMInB;
    assign MemWriteMOutB = MemWriteMInB;
    assign MemtoRegMOutB = MemtoRegMInB;
    assign RegWriteMOutB = RegWriteMInB;
    
    logic MemA, MemB;
    assign MemA = MemWriteMInA | MemtoRegMInA;
    assign MemB = MemWriteMInB | MemtoRegMInB;
    assign Wen = (MemWriteMInB | MemWriteMInA);
    assign Ren = (MemtoRegMInB | MemtoRegMInA);
    assign Addr = (MemA) ? (ALUOutMInA) : (ALUOutMInB);
    assign WriteData = (MemA) ? (WriteDataA) : (WriteDataB);
    
    assign ReadDataMOutA = ReadData;
    assign ReadDataMOutB = ReadData;
endmodule
