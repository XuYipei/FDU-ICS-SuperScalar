`timescale 1ns / 1ps

module DataPath(
        input logic clk, reset,
        //All
        output logic [31: 0] IAddr, 
        input logic [31: 0] IReadData,
        input logic ITLBExpection,
        //ICache
        output logic DWen, Den, 
        output logic [31: 0] DAddr, DWriteData,
        input logic [31: 0] DReadData
        //DCache
    );
    
    logic [31: 0] PCF;
    
    Fetch Fetch(clk, reset, StallF, FlushF,
                SuperScalarD, BranchD, 
                PCBranchD, 
                PCPlus4FOutA, InstrA,
                PCPlus4FoutB, InstrB,
                ITLBExpection,
                IAddr, IReadData);
    
    DecodeReg DecodeReg();
    Decode Decode(clk, 
                  RegWriteWOutA,
 WriteRegWOutA, ResultWOutA, 
                  RegWriteWOutB, WriteRegWOutB, ResultWOutB,
                  InstrA, PCPlus4DInA,
                  BranchDA, JumpDA, JumpRegDA, JumpLinkDA,
                  RegWriteDA, MemtoRegDA, MemWriteDA,
                  ALUControlDA,
                  ALUSrcDA, RegDstDA, BitShiftDA,
                  rd1A, rd2A,
                  rsDA, rtDA, rdDA,
                  ImmDA, BitNumDA, PCPlus4DOutA,
                  PCBranchDA, PCJumpDA, PCRegDA,
                  InstrB, PCPlus4DInB,
                  BranchDB, JumpDB, JumpRegDB, JumpLinkDB,
                  RegWriteDB, MemtoRegDB, MemWriteDB,
                  ALUControlDB,
                  ALUSrcDB, RegDstDB, BitShiftDB,
                  rd1B, rd2B,
                  rsDB, rtDB, rdDB,
                  ImmDB, BitNumDB, PCPlus4DOutB,
                  PCBranchDB, PCJumpDB, PCRegDB,
                  SuperScalarD);
                                        
    ExecuteReg ExecuteReg();
    Execute Execute(JumpLinkEInA, RegWriteEInA, MemtoRegEInA, MemWriteEInA,
                    ALUControlEInA,
                    ALUSrcEInA, RegDstEInA, BitShiftEInA,
                    rd1EA, rd2EA,
                    rsEA, rtEA, rdEA, 
                    ImmEA, BitNumEA, PCPlus4EA, ALUOutMA, ResultWA,
                    WriteRegEA,
                    WriteDataEA, ALUOutEA,
                    RegWriteEOutA, MemWriteEOutA, MemtoRegEOutA,
                    JumpLinkEInB, RegWriteEInB, MemtoRegEInB, MemWriteEInB,
                    ALUControlEInB,
                    ALUSrcEInB, RegDstEInB, BitShiftEInB,
                    rd1EB, rd2EB,
                    rsEB, rtEB, rdEB, 
                    ImmEB, BitNumEB, PCPlus4EB, ALUOutMB, ResultWB,
                    WriteRegEB,
                    WriteDataEB, ALUOutEB,
                    RegWriteEOutB, MemWriteEOutB, MemtoRegEOutB); 
    
    MemoryReg MemoryReg();
    Memory Memory(RegWriteMInA, MemtoRegMInA, MemWriteMInA,
                  ALUOutMInA, WriteDataMInA,
                  WriteRegMInA,
                  ALUOutMOutA, 
                  WriteRegMOutA,
                  DataAddrA, WriteDataA, ReadDataMOutA, 
                  MemWriteMOutA, MemtoRegMOutA, RegWriteMOutA,
                  RegWriteMInB, MemtoRegMInB, MemWriteMInB,
                  ALUOutMInB, WriteDataMInB,
                  WriteRegMInB,
                  ALUOutMOutB, 
                  WriteRegMOutB,
                  DataAddrB, WriteDataB, ReadDataMOutB, 
                  MemWriteMOutB, MemtoRegMOutB, RegWriteMOutB,
                  Wen, Ren,
                  DAddr, DWriteData,
                  DReadData);
    
    WriteBackReg WriteBackReg();
    WriteBack WriteBack(RegWriteWInA, MemtoRegWInA,
                        ReadDataWInA, ALUOutWInA,
                        WriteRegWInA,
                        WriteRegWOutA,
                        ResultWOutA,
                        RegWriteWOutA,
                        RegWriteWInB, MemtoRegWInB,
                        ReadDataWInB, ALUOutWInB,
                        WriteRegWInB,
                        WriteRegWOutB,
                        ResultWOutB,
                        RegWriteWOutB);                                              
endmodule
