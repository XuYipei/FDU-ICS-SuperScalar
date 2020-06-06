`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 17:29:36
// Design Name: 
// Module Name: DecodeReg
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


module DecodeReg(
        input logic clk, reset, clr, 
        input logic en,
        input logic [31: 0] PCIn,
        input logic [31: 0] instrIn, PCPlus4In,
        input logic BranchIn,
        output logic [31: 0] PCOut, 
        output logic [31: 0] instrOut,PCPlus4Out,
        output logic BranchOut,
        input logic Ihit, Dhit
    );
    always_ff @(posedge clk, posedge reset)
        if (reset)
            begin
                PCOut <= 32'b0;
                instrOut <= 32'b0;
                PCPlus4Out <= 32'b0;
                BranchOut <= 1'b0;
            end
        else 
            if (en & Dhit) 
                begin
                    if (clr)
                        begin
                            PCOut <= 32'b0;
                            instrOut <= 32'b0;
                            PCPlus4Out <= 32'b0;
                            BranchOut <= 1'b0;                    
                        end
                    else
                        begin
                            PCOut <= PCIn;
                            instrOut <= instrIn; 
                            PCPlus4Out <= PCPlus4In;
                            BranchOut <= BranchIn;
                        end
                end
endmodule

