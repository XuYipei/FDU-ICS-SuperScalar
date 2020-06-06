`include "bpb.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/27 20:57:46
// Design Name: 
// Module Name: Mips
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


module Mips #(
        parameter ENTRIES = `BPB_E,
        parameter TAG_WIDTH = `BPB_T
    )(
        input logic clk, reset,
        output logic [31:0] PC,
        input logic [31:0] instr,
        output logic MemWrite,
        output logic [31:0] DataAddr, WriteData,
        input logic [31:0] ReadData,
        input logic Ihit, Dhit,
        output logic dcen
    );
    logic [31:0] PCF;
    logic Jump, IsBranchF;
    logic [31:0] PCPlus4FOut, PCJumpF;
    logic [31:0] instrFOut;
    
    logic [31:0] PCD;
    logic [31:0] instrDIn, PCPlus4DIn, ResultW;
    logic BranchD, IsBranchD, JumpReg;
    logic MistakeD, BranchPrdDIn;
    logic JumpLinkD, RegWriteD, MemtoRegD, MemWriteD;
    logic [2:0] ALUControlD;
    logic UseRd1, UseRd2;
    logic ALUSrcD, RegDstD, BitShiftD;
    logic [31:0] rd1D, rd2D;
    logic [4:0] rsD, rtD, rdD;
    logic [31:0] ImmD, BitNumD, PCPlus4DOut;
    logic [31:0] PCBranchD, PCRegD, PCBranchRealD;
    
    logic JumpLinkEIn, RegWriteEIn, MemtoRegEIn, MemWriteEIn;
    logic [2:0] ALUControlEIn;
    logic ALUSrcEIn, RegDstEIn, BitShiftEIn;
    logic [31:0] rd1EIn, rd2EIn;
    logic [4:0] rsEIn, rtEIn, rdEIn;
    logic [31:0] ImmEIn, BitNumIn, PCPlus4EIn;
    logic [4:0] WriteRegEOut;
    logic [31:0] WriteDataE, ALUOutE;
    logic RegWriteEOut, MemWriteEOut, MemtoRegEOut;
    
    logic RegWriteMIn, MemtoRegMIn, MemWriteMIn;
    logic [31:0] ALUOutMIn, WriteDataMIn, ReadDataMIn;
    logic [4:0] WriteRegMIn;
    logic [31:0] ALUOutMOut, DataAddrMOut;
    logic [4:0] WriteRegMOut;
    logic [31:0] ReadDataMOut, WriteDataMOut;
    logic MemWriteMOut, MemtoRegMOut, RegWriteMOut;
    
    logic RegWriteWIn, MemtoRegWIn;
    logic [31:0] ReadDataWIn, ALUOutWIn;
    logic [4:0] WriteRegWIn, WriteRegWOut;
    logic [31:0] ResultWOut;
    logic RegWriteWOut;  
    
    logic StallF, StallD, FlushE, FlushD;
    logic ForwardAD, ForwardBD;
    logic [1:0] ForwardAE, ForwardBE; 
    
    logic BranchPrd;
    logic [31:0] PCBranchPrd;
     
    Fetch Fetch(clk, reset, StallF, 
                MistakeD, JumpReg,
                BranchPrd, Jump, 
                PCBranchRealD, PCRegD,                    
                PCBranchPrd, PCJumpF,
                PC, PCPlus4FOut,
                Ihit, Dhit);      
    FetchPrd FetchPrd(instr, PCPlus4FOut, 
                      Jump, IsBranchF,  
                      PCJumpF, instrFOut);
    assign PCF = PC;                                  
       
    assign FlushD = MistakeD | JumpReg;
    DecodeReg DecodeReg(clk, reset, FlushD, (~StallD), 
                        PCF, instr, PCPlus4FOut, BranchPrd,
                        PCD, instrDIn, PCPlus4DIn, BranchPrdDIn,
                        Ihit, Dhit);
    Decode Decode(clk, RegWriteWOut, 
                  instrDIn, PCPlus4DIn,
                  WriteRegWOut, ResultWOut, ALUOutMOut,
                  ForwardAD, ForwardBD,
                  BranchPrdDIn,
                  BranchD, IsBranchD ,JumpReg,
                  JumpLinkD, RegWriteD, MemtoRegD, MemWriteD,
                  ALUControlD, 
                  ALUSrcD, RegDstD, BitShiftD,
                  UseRd1, UseRd2,
                  rd1D, rd2D, 
                  rsD, rtD, rdD,
                  ImmD, BitNumD, PCPlus4DOut,
                  PCBranchD, PCRegD, PCBranchRealD,
                  MistakeD);
    
    ExcuteReg ExcuteReg(clk, reset, FlushE,
                        JumpLinkD, RegWriteD, MemtoRegD, MemWriteD,
                        ALUControlD,
                        ALUSrcD, RegDstD, BitShiftD,
                        rd1D, rd2D,
                        rsD, rtD, rdD,
                        ImmD, BitNumD, PCPlus4DOut, 
                        JumpLinkEIn, RegWriteEIn, MemtoRegEIn, MemWriteEIn,
                        ALUControlEIn,
                        ALUSrcEIn, RegDstEIn, BitShiftEIn,
                        rd1EIn, rd2EIn,
                        rsEIn, rtEIn, rdEIn,
                        ImmEIn, BitNumIn, PCPlus4EIn,
                        Ihit, Dhit);                        
    Excute Excute(JumpLinkEIn, RegWriteEIn, MemtoRegEIn, MemWriteEIn, 
                  ALUControlEIn,
                  ALUSrcEIn, RegDstEIn, BitShiftEIn,
                  rd1EIn, rd2EIn,
                  rsEIn, rtEIn, rdEIn,
                  ImmEIn, BitNumIn, PCPlus4EIn, ALUOutMOut, ResultWOut,
                  ForwardAE, ForwardBE,
                  WriteRegEOut,
                  WriteDataE, ALUOutE,
                  RegWriteEOut, MemWriteEOut, MemtoRegEOut);   
    
    MemoryReg MemoryReg(clk, reset,
                        RegWriteEOut, MemtoRegEOut, MemWriteEOut,
                        ALUOutE, WriteDataE,
                        WriteRegEOut,
                        RegWriteMIn, MemtoRegMIn, MemWriteMIn,
                        ALUOutMIn, WriteDataMIn,
                        WriteRegMIn,
                        Ihit, Dhit); 
    Memory Memory(RegWriteMIn, MemtoRegMIn, MemWriteMIn,
                  ALUOutMIn, WriteDataMIn, ReadDataMIn,
                  WriteRegMIn,
                  ALUOutMOut,
                  WriteRegMOut,
                  DataAddrMOut, WriteDataMOut, ReadDataMOut,
                  MemWriteMOut, MemtoRegMOut, RegWriteMOut);
    assign DataAddr = DataAddrMOut;
    assign WriteData = WriteDataMOut;
    assign ReadDataMIn = ReadData;
    assign MemWrite = MemWriteMOut;
    assign dcen = MemWrite | MemtoRegMIn;
                      
    WriteBackReg WriteBackReg(clk, reset,
                              RegWriteMIn, MemtoRegMOut,
                              ReadDataMOut, ALUOutMOut,
                              WriteRegMOut,
                              RegWriteWIn, MemtoRegWIn,
                              ReadDataWIn, ALUOutWIn, 
                              WriteRegWIn,
                              Ihit, Dhit);                                  
    WriteBack WriteBack(RegWriteWIn, MemtoRegWIn,
                        ReadDataWIn, ALUOutWIn,
                        WriteRegWIn,
                        WriteRegWOut, ResultWOut, RegWriteWOut);
    
    Predictor Predictor(clk, reset, StallD, FlushD,
                             PCF[1+TAG_WIDTH: 2], PCD[1+TAG_WIDTH: 2], 
                             MistakeD,
                             IsBranchF, IsBranchD, 
                             BranchD, PCBranchD,
                             BranchPrd, PCBranchPrd);
    
    ControllerUnit ControllerUnit(reset,
                                  IsBranchD, JumpReg,
                                  UseRd1, UseRd2,
                                  rsD, rtD, rsEIn, rtEIn,
                                  WriteRegEOut, MemtoRegEOut, RegWriteEOut,
                                  WriteRegMOut, MemtoRegMOut, RegWriteMOut,
                                  WriteRegWOut, RegWriteWOut, 
                                  StallF, StallD,
                                  ForwardAD, ForwardBD,
                                  FlushE,
                                  ForwardAE, ForwardBE,
                                  Ihit, Dhit);                            
endmodule
