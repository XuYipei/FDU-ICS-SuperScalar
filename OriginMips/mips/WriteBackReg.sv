`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 18:12:38
// Design Name: 
// Module Name: WriteBackReg
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


module WriteBackReg(
        input logic clk, reset,
        input logic RegWriteWIn, MemtoRegWIn,
        input logic [31:0] ReadDataWIn, ALUOutWIn, 
        input logic [4:0] WriteRegWIn,
        output logic RegWriteWOut, MemtoRegWOut,
        output logic [31:0] ReadDataWOut, ALUOutWOut,
        output logic [4:0] WriteRegWOut,
        input logic Ihit, Dhit
    );
    always_ff @(posedge clk, posedge reset)
        if (reset)
            begin
                RegWriteWOut <= 0;
                MemtoRegWOut <= 0;    
                ReadDataWOut <= 32'b0;
                ALUOutWOut <= 32'b0;
                WriteRegWOut <= 5'b0;
            end
        else
            if (Dhit)
                begin
                    RegWriteWOut <= RegWriteWIn;
                    MemtoRegWOut <= MemtoRegWIn;    
                    ReadDataWOut <= ReadDataWIn;
                    ALUOutWOut <= ALUOutWIn;
                    WriteRegWOut <= WriteRegWIn;                 
                end
endmodule
