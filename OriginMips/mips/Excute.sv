`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/27 00:06:36
// Design Name: 
// Module Name: Excute
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


module Excute(
        input logic JumpLinkEIn, RegWriteEIn, MemtoRegEIn, MemWriteEIn,
        input logic [2:0] ALUControlEIn,
        input logic ALUSrcEIn, RegDstEIn, BitShiftEIn,
        input logic [31:0] rd1E, rd2E,
        input logic [4:0] rsE, rtE, rdE, 
        input logic [31:0] ImmE, BitNumE, PCPlus4E, ALUOutM, ResultW,
        input logic [1:0] ForwardAE, ForwardBE,
        output logic [4:0] WriteRegE,
        output logic [31:0] WriteDataE, ALUOutE,
        output logic RegWriteEOut, MemWriteEOut, MemtoRegEOut 
    );
    assign RegWriteEOut = RegWriteEIn;
    assign MemWriteEOut = MemWriteEIn;
    assign MemtoRegEOut = MemtoRegEIn;
    
    logic [31:0] SrcAE_, SrcBE_, SrcAE, SrcBE;
    TripleMux #(5) WtRegMux(rtE, rdE, 5'b11111, 
                            {JumpLinkEIn, RegDstEIn}, WriteRegE);
    TripleMux #(32) SrcA_Mux(rd1E, ALUOutM, ResultW, 
                            ForwardAE, SrcAE_);
    TripleMux #(32) SrcB_Mux(rd2E, ALUOutM, ResultW, 
                            ForwardBE, SrcBE_);
    TripleMux #(32) SrcAMux(SrcAE_, BitNumE, PCPlus4E,
                            {JumpLinkEIn, BitShiftEIn}, SrcAE);
    TripleMux #(32) SrcBMux(SrcBE_, ImmE, 32'b0,
                            {JumpLinkEIn, ALUSrcEIn}, SrcBE);
    
    assign WriteDataE = SrcBE_;
    Alu ALU(SrcAE, SrcBE, ALUControlEIn, ALUOutE);                                                         
endmodule
