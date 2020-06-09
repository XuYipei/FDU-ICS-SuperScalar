`timescale 1ns / 1ps

module Execute(
        input logic JumpLinkEInA, RegWriteEInA, MemtoRegEInA, MemWriteEInA,
        input logic [2:0] ALUControlEInA,
        input logic ALUSrcEInA, RegDstEInA, BitShiftEInA,
        input logic [31:0] rd1EA, rd2EA,
        input logic [4:0] rsEA, rtEA, rdEA, 
        input logic [31:0] ImmEA, BitNumEA, PCPlus4EA, ALUOutMA, ResultWA,
        output logic [4:0] WriteRegEA,
        output logic [31:0] WriteDataEA, ALUOutEA,
        output logic RegWriteEOutA, MemWriteEOutA, MemtoRegEOutA,
        
        input logic JumpLinkEInB, RegWriteEInB, MemtoRegEInB, MemWriteEInB,
        input logic [2:0] ALUControlEInB,
        input logic ALUSrcEInB, RegDstEInB, BitShiftEInB,
        input logic [31:0] rd1EB, rd2EB,
        input logic [4:0] rsEB, rtEB, rdEB, 
        input logic [31:0] ImmEB, BitNumEB, PCPlus4EB, ALUOutMB, ResultWB,
        output logic [4:0] WriteRegEB,
        output logic [31:0] WriteDataEB, ALUOutEB,
        output logic RegWriteEOutB, MemWriteEOutB, MemtoRegEOutB
    );
    
    SignalExecute ExecuteA(JumpLinkEInA, RegWriteEInA, MemtoRegEInA, MemWriteEInA,
                           ALUControlEInA,
                           ALUSrcEInA, RegDstEInA, BitShiftEInA,
                           rd1EA, rd2EA,
                           rsEA, rtEA, rdEA,
                           ImmEA, BitNumEA, PCPlus4EA, ALUOutMA, ResultWA,
                           WriteRegEA,
                           WriteDataEA, ALUOutEA,
                           RegWriteEOutA, MemWriteEOutA, MemtoRegEOutA);
    
    logic [31: 0] rd1EB_, rd2EB_;                      
    assign rd1EB_ = (rsEB == WriteRegEA && RegWriteEInA) ? (ALUOutMA) : (rd1EB);
    assign rd2EB_ = (rtEB == WriteRegEA && RegWriteEInA) ? (ALUOutMA) : (rd1EB);                      
                                
    SignalExecute ExecuteB(JumpLinkEInB, RegWriteEInB, MemtoRegEInB, MemWriteEInB,
                           ALUControlEInB,
                           ALUSrcEInB, RegDstEInB, BitShiftEInB,
                           rd1EB_, rd2EB_,
                           rsEB, rtEB, rdEB,
                           ImmEB, BitNumEB, PCPlus4EB, ALUOutMB, ResultWB,
                           WriteRegEB,
                           WriteDataEB, ALUOutEB,
                           RegWriteEOutB, MemWriteEOutB, MemtoRegEOutB);
                                                                                     
endmodule
