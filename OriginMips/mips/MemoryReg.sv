`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 18:05:25
// Design Name: 
// Module Name: MemoryReg
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


module MemoryReg(
        input logic clk, reset,
        input logic RegWriteMIn, MemtoRegMIn, MemWriteMIn,
        input logic [31:0] ALUOutMIn, WriteDataMIn,
        input logic [4:0] WriteRegMIn, 
        output logic RegWriteMOut, MemtoRegMOut, MemWriteMOut,
        output logic [31:0] ALUOutMOut, WriteDataMOut,
        output logic [4:0] WriteRegMOut,
        input logic Ihit, Dhit
    );
    always @(posedge clk, posedge reset)
        begin
            if (reset) 
                begin
                    RegWriteMOut <= 0;
                    MemtoRegMOut <= 0;
                    MemWriteMOut <= 0;
                    ALUOutMOut <= 32'b0;
                    WriteDataMOut <= 32'b0;
                    WriteRegMOut <= 5'b0;
                end
            else
                if (Dhit)
                    begin
                        RegWriteMOut <= RegWriteMIn;
                        MemtoRegMOut <= MemtoRegMIn;
                        MemWriteMOut <= MemWriteMIn;
                        ALUOutMOut <= ALUOutMIn;
                        WriteDataMOut <= WriteDataMIn;
                        WriteRegMOut <= WriteRegMIn;
                    end
        end
endmodule
