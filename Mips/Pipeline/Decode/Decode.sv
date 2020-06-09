`timescale 1ns / 1ps

module Decode(
        input logic clk, 
        input logic we3A,
        input logic [4:0] wa3A, 
        input logic [31:0] wd3A, 
        input logic we3B,
        input logic [4:0] wa3B, 
        input logic [31:0] wd3B, 
        //RegFile
        input logic [31:0] InstrA, PCPlus4DInA,
        output logic BranchDA, JumpDA, JumpRegDA, JumpLinkDA,
        output logic RegWriteDA, MemtoRegDA, MemWriteDA,
        output logic [2: 0] ALUControlDA,
        output logic ALUSrcDA, RegDstDA, BitShiftDA,
        output logic [31: 0] rd1A, rd2A,
        output logic [4: 0] rsDA, rtDA, rdDA,
        output logic [31: 0] ImmDA, BitNumDA, PCPlus4DOutA,
        output logic [31: 0] PCBranchDA, PCJumpDA, PCRegDA,
        //DecodeInstrA
        input logic [31:0] InstrB, PCPlus4DInB,
        output logic BranchDB, JumpDB, JumpRegDB, JumpLinkDB,
        output logic RegWriteDB, MemtoRegDB, MemWriteDB,
        output logic [2: 0] ALUControlDB,
        output logic ALUSrcDB, RegDstDB, BitShiftDB,
        output logic [31: 0] rd1B, rd2B,
        output logic [4: 0] rsDB, rtDB, rdDB,
        output logic [31: 0] ImmDB, BitNumDB, PCPlus4DOutB,
        output logic [31: 0] PCBranchDB, PCJumpDB, PCRegDB,
        //DecodeInstrB
        output logic SuperScalar
        //SuperScalar
    );
    
    RegFile RegFile(clk, 
                    we3A, wa3A, wd3A,
                    rsDA, rtDA, rd1_A, rd2_A,
                    we3B, wa3B, wd3B, 
                    rsDB, rtDB, rd1_B, rd2_B);
    
    SignalDecode DecodeA(clk,
                         InstrA, PCPlus4DInA,
                         BranchDA, JumpDA, JumpRegDA, JumpLinkDA,
                         RegWriteDA, MemtoRegDA, MemWriteDA,
                         ALUControlDA,
                         ALUSrcDA, RegDstDA, BitShiftDA,
                         rd1A, rd2A,
                         rsDA, rtDA, rdDA,
                         ImmDA, BitNumDA, PCPlus4DOutA,
                         PCBranchDA, PCJumpDA, PCRegDA,
                         rd1_A, rd2_A);
                         
    SignalDecode DecodeB(clk,
                         InstrB, PCPlus4DInB,
                         BranchDB, JumpDB, JumpRegDB, JumpLinkDB,
                         RegWriteDB, MemtoRegDB, MemWriteDB,
                         ALUControlDB,
                         ALUSrcDB, RegDstDB, BitShiftDB,
                         rd1B, rd2B,
                         rsDB, rtDB, rdDB,
                         ImmDB, BitNumDB, PCPlus4DOutB,
                         PCBranchDB, PCJumpDB, PCRegDB,
                         rd1_B, rd2_B);          
    
    SuperScalar SuperScalarChecker(rsDA, rtDA, RegWriteDA, MemtoRegDA, MemWriteDA,  
                                   rsDB, rtDB, RegWriteDB, MemtoRegDB, MemWriteDB,
                                   SuperScalar);                                     
    
endmodule
