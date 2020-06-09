`timescale 1ns / 1ps

module SignalExecute(
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
    Mux3 #(5) RegWriteMux(rtE, rdE, 5'b11111, 
                          {JumpLinkEIn, RegDstEIn}, WriteRegE);
//    TripleMux #(32) SrcA_Mux(rd1E, ALUOutM, ResultW, 
//                            ForwardAE, SrcAE_);
//    TripleMux #(32) SrcB_Mux(rd2E, ALUOutM, ResultW, 
//                            ForwardBE, SrcBE_);
    Mux3 #(32) SrcAMux(rd1E, BitNumE, PCPlus4E,
                       {JumpLinkEIn, BitShiftEIn}, SrcAE);
    Mux3 #(32) SrcBMux(rd2E, ImmE, 32'b0,
                       {JumpLinkEIn, ALUSrcEIn}, SrcBE);
    assign WriteDataE = rd2E;
    Alu ALU(SrcAE, SrcBE, ALUControlEIn, ALUOutE);                                                         
endmodule
