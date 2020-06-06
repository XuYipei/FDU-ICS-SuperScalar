`include "bpb.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/23 10:22:40
// Design Name: 
// Module Name: Predictor
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


module Predictor #(
        parameter ENTRIES = `BPB_E,
        parameter TAG_WIDTH = `BPB_T
    )(
        input logic clk, reset, stall, flush,
        input logic [TAG_WIDTH - 1: 0] PCF,
        input logic [TAG_WIDTH - 1: 0] PCD,
        input logic MistakeD,
        input logic isBranchF,
        input logic isBranchD,
        input logic real_taken,
        input logic [31: 0] real_addr,
        output logic prd,
        output logic [31:0] prd_addr
    );
    
    logic hit;
    logic [2: 0] idxF, idxD;
    assign idxF = PCF[2: 0];
    assign idxD = PCD[2: 0];
    
    logic [ENTRIES - 1: 0] wen_arr;
    logic [ENTRIES - 1: 0] prd_arr;
    logic [31: 0] prd_addr_arr [ENTRIES - 1: 0];
    logic [TAG_WIDTH - 1: 0] tag_arr [ENTRIES - 1: 0];
    
    logic LocalBranchPrd, GlobalBranchPrd;
    logic [31: 0] LocalPCBranchPrd, GlobalPCBranchPrd;
    LocalPredictor LocalPredictor(clk, reset, stall, flush,
                                  PCF, PCD,
                                  MistakeD, 
                                  isBranchF, isBranchD, 
                                  real_taken, real_addr,
                                  LocalBranchPrd, LocalPCBranchPrd);
    GlobalPredictor GlobalPredictor(clk, reset, stall, flush,
                                  PCF, PCD,
                                  MistakeD, 
                                  isBranchF, isBranchD, 
                                  real_taken, real_addr,
                                  GlobalBranchPrd, GlobalPCBranchPrd);
    
    logic chs;
    logic [ENTRIES - 1: 0] chs_arr;
    Unit Unit [ENTRIES - 1: 0](.clk(clk), .reset(reset), .stall(stall), .flush(flush), .mod(1'b0),
                               .wen(wen_arr),
                               .prd_tag(tag_arr),
                               .prd_taken(chs_arr), 
                               .real_tag(PCD),
                               .real_taken(real_taken),
                               .mistake(MistakeD));
    
    assign chs = chs_arr[idxF];
    assign prd = (chs) ? (GlobalBranchPrd) : (LocalBranchPrd);
    assign prd_addr = (chs) ? (GlobalPCBranchPrd) : (LocalPCBranchPrd);
//    assign prd = LocalBranchPrd;                                   
//    assign prd_addr = LocalPCBranchPrd;
//    assign prd = GlobalBranchPrd;
//    assign prd_addr = GlobalPCBranchPrd;
    
    integer i;
    always @(*)
        begin
            for (i = 0; i < ENTRIES; i = i + 1) 
                wen_arr[i] <= ((i == idxD) & isBranchD);
        end
                                              
endmodule
