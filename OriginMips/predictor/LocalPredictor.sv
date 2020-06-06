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


module LocalPredictor #(
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
    Unit Unit [ENTRIES - 1: 0](.clk(clk), .reset(reset), .stall(stall), .flush(flush), .mod(1'b1),
                               .wen(wen_arr),
                               .prd_tag(tag_arr),
                               .prd_taken(prd_arr), 
                               .real_tag(PCD),
                               .real_taken(real_taken),
                               .mistake(MistakeD));
    
    assign hit = (tag_arr[idxF] == PCF);
    assign prd = (hit) ? (prd_arr[idxF]) : (0);
    assign prd_addr = (hit & prd) ? (prd_addr_arr[idxF]) : (32'b0);                               
    
    integer i;
    always @(*)
        begin
            for (i = 0; i < ENTRIES; i = i + 1) 
                wen_arr[i] <= ((i == idxD) & isBranchD);
        end      
    
    integer j;
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset)
                begin
                    for (j = 0; j < ENTRIES; j = j + 1) 
                        prd_addr_arr[j] <= 32'b0;
                end
            else
                if (isBranchD & (~stall))
                    begin
                        prd_addr_arr[idxD] <= real_addr;
                    end
        end                                          
endmodule
