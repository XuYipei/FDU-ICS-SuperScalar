`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/27 16:45:41
// Design Name: 
// Module Name: ControllerUnit
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


module ControllerUnit(
        input logic reset,
        input logic Branch, JumpReg,
        input logic UseRd1, UseRd2,
        input logic [4:0] rsD, rtD,
        input logic [4:0] rsE, rtE,
        input logic [4:0] WriteRegE,
        input logic MemtoRegE, RegWriteE,
        input logic [4:0] WriteRegM,
        input logic MemtoRegM, RegWriteM,
        input logic [4:0] WriteRegW,
        input logic RegWriteW,
        output logic StallF, StallD,
        output logic ForwardAD, ForwardBD,
        output logic FlushE,
        output logic [1:0] ForwardAE, ForwardBE, 
        input logic Ihit, Dhit     
    );
    logic LwStall, BranchStall, JumpRegStall;
    assign ForwardAD = (UseRd1) & (rsD != 4'b0000) & (rsD == WriteRegM) & (RegWriteM);
    assign ForwardBD = (UseRd2) & (rtD != 4'b0000) & (rtD == WriteRegM) & (RegWriteM);
    always @(*)
        begin
            if ((rsE != 4'b0000) & (rsE == WriteRegM) & (RegWriteM)) 
                ForwardAE <= 2'b01;
            else 
                if ((rsE != 4'b0000) & (rsE == WriteRegW) & (RegWriteW))
                    ForwardAE <= 2'b10;
                else 
                    ForwardAE <= 2'b00;
            
            if ((rtE != 4'b0000) & (rtE == WriteRegM) & (RegWriteM)) 
                ForwardBE <= 2'b01;
            else 
                if ((rtE != 4'b0000) & (rtE == WriteRegW) & (RegWriteW))
                    ForwardBE <= 2'b10;
                else 
                    ForwardBE <= 2'b00;                    
        end
    
    assign LwStall = ((rsD == rtE) | (rtD == rtE)) && MemtoRegE;
    assign BranchStall = ((Branch) && (RegWriteE) && ((WriteRegE == rsD) || (WriteRegE == rtD))) ||
                         ((Branch) && (MemtoRegM) && ((WriteRegM == rsD) || (WriteRegM == rtD)));  
    assign JumpRegStall = ((JumpReg) && (RegWriteE) && ((WriteRegE == rsD) || (WriteRegE == rtD))) || 
                          ((JumpReg) && (RegWriteM) && ((WriteRegM == rsD) || (WriteRegM == rtD)));
    
    assign StallF = LwStall | BranchStall | JumpRegStall;
    assign StallD = LwStall | BranchStall | JumpRegStall;
    assign FlushE = LwStall | BranchStall | JumpRegStall;                                                             
endmodule
