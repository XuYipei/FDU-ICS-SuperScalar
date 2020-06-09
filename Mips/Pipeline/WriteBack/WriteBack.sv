`timescale 1ns / 1ps

module WriteBack(
        input logic RegWriteWInA, MemtoRegWInA,
        input logic [31:0] ReadDataWInA, ALUOutWInA,
        input logic [4:0] WriteRegWInA,
        output logic [4:0] WriteRegWOutA,
        output logic [31:0] ResultWOutA,
        output logic RegWriteWOutA,
        
        input logic RegWriteWInB, MemtoRegWInB,
        input logic [31:0] ReadDataWInB, ALUOutWInB,
        input logic [4:0] WriteRegWInB,
        output logic [4:0] WriteRegWOutB,
        output logic [31:0] ResultWOutB,
        output logic RegWriteWOutB
    );
    assign WriteRegWOutA = WriteRegWInA;
    assign RegWriteWOutA = RegWriteWInA;
    Mux2 #(32) ResultWMuxA (ALUOutWInA, ReadDataWInA, 
                            MemtoRegWInA, ResultWOutA);
    
    assign WriteRegWOutB = WriteRegWInB;
    assign RegWriteWOutB = RegWriteWInB;
    Mux2 #(32) ResultWMuxB (ALUOutWInB, ReadDataWInB, 
                            MemtoRegWInB, ResultWOutB);                       
endmodule
