`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/27 11:27:31
// Design Name: 
// Module Name: WriteBack
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


module WriteBack(
        input logic RegWriteWIn, MemtoRegWIn,
        input logic [31:0] ReadDataWIn, ALUOutWIn,
        input logic [4:0] WriteRegWIn,
        output logic [4:0] WriteRegWOut,
        output logic [31:0] ResultWOut,
        output logic RegWriteWOut
    );
    assign WriteRegWOut = WriteRegWIn;
    assign RegWriteWOut = RegWriteWIn;
    DoubleMux #(32) ResultWMux (ALUOutWIn, ReadDataWIn, 
                                MemtoRegWIn, ResultWOut);
endmodule
