`timescale 1ns / 1ps

module SuperScalar(
        input logic [4: 0] rsA,
        input logic [4: 0] rtA,
        input logic [4: 0] WriteRegA,
        input logic RegWriteA,
        input logic LwA, SwA, 
        //A
        input logic [4: 0] rsB,
        input logic [4: 0] rtB,
        input logic [4: 0] WriteRegB,
        input logic RegWriteB,
        input logic LwB, SwB,
        //B
        output logic SuperScalar 
    );
    
    logic Memory;
    assign Memory = (LwA | SwA) & (LwB | SwB);
    
    logic RaW;
    assign RaW = (RegWriteA == rsB || RegWriteA == rtB) & (LwA);
    
    assign SuperScalar = RaW | Memory;
endmodule
