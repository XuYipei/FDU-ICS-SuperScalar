`timescale 1ns / 1ps

module SignalDecode(
        input logic clk,
        input logic [31:0] Instr, PCPlus4DIn,
        output logic BranchD, JumpD, JumpRegD, JumpLinkD,
        output logic RegWriteD, MemtoRegD, MemWriteD,
        output logic [2:0] ALUControlD,
        output logic ALUSrcD, RegDstD, BitShiftD,
        output logic [31:0] rd1, rd2,
        output logic [4:0] rsD, rtD, rdD,
        output logic [31:0] ImmD, BitNumD, PCPlus4DOut,
        output logic [31:0] PCBranchD, PCJumpD, PCRegD,
        //To Decode
        input logic [31: 0] rd1_, rd2_
        //
    );

    logic Brancheq, Branchneq;
    DecodeInstr DecodeInstr(Instr[31: 26], Instr[5: 0],
                            MemtoRegD, MemWriteD,
                            BitShiftD, ALUSrcD,
                            RegDstD, RegWriteD, 
                            JumpD, JumpRegD, JumpLinkD,
                            ALUControlD,
                            Brancheq, Branchneq);
    
    logic [31:0] rd1, rd2;
    assign rsD = Instr[25: 21];
    assign rtD = Instr[20: 16];
    assign rdD = Instr[15: 11];
    
//    RegFile regf(~clk, we3, 
//                 wa3, wd3,
//                 instrD[25:21], instrD[20:16], rd1_, rd2_);
//    Mux2 #(32) Muxrd1(rd1_, ALUOutM, ForwardAD ,rd1);
//    Mux2 #(32) Muxrd2(rd2_, ALUOutM, ForwardBD ,rd2);              
    
    logic zero;
    assign zero = {ALUControlD == 3'b000} | {ALUControlD == 3'b001};
    SigExtend #(5) SigBit(Instr[10:6], 1'b0, BitNumD);
    SigExtend #(16) SigImm(Instr[15:0], zero, ImmD);
    
    logic [31:0] ImmSl, PCBranchD_;
    Sl2 BranchSl(ImmD ,ImmSl);
    Adder BranchAdd(PCPlus4DIn, ImmSl, PCBranchD_); 
    assign PCRegD = rd1;
    
    logic eql;
    Equal #(32) Equalrd(rd1, rd2, eql);
    assign BranchD = (eql & Brancheq) | ((~eql) & Branchneq);
    assign PCBranchD = (BranchD) ? (PCBranchD_) : (PCPlus4DIn);
    assign PCPlus4DOut = PCPlus4DIn;
endmodule

