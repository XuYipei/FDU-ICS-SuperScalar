`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/27 11:08:59
// Design Name: 
// Module Name: Memory
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


module Memory(
        input logic RegWriteMIn, MemtoRegMIn, MemWriteMIn,
        input logic [31:0] ALUOutMIn, WriteDataMIn, ReadData,
        input logic [4:0] WriteRegMIn,
        output logic [31:0] ALUOutMOut, 
        output logic [4:0] WriteRegMOut,
        output logic [31:0] DataAddr, WriteData, ReadDataMOut, 
        output logic MemWriteMOut, MemtoRegMOut, RegWriteMOut        
    );
    assign ALUOutMOut = ALUOutMIn;
    assign WriteRegMOut = WriteRegMIn;
    assign DataAddr = ALUOutMIn;
    assign WriteData = WriteDataMIn;
    assign ReadDataMOut = ReadData;
    assign MemWriteMOut = MemWriteMIn;
    assign MemtoRegMOut = MemtoRegMIn;
    assign RegWriteMOut = RegWriteMIn;
endmodule
