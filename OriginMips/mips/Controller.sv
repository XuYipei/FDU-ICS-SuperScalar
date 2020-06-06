`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 17:20:38
// Design Name: 
// Module Name: Controller
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


module Controller(
        input logic [5:0] op, func,
        output logic memtoreg, memwrite,
        output logic bitshift, alusrc,
        output logic regdst, regwrite,
        output logic jump, jumpreg, jumplink,
        output logic [2:0] alucontrol,
        output logic branchbeq, branchneq,
        output logic userd1, userd2
    );
    logic [2:0] aluop;
    logic jp;
    MainDec md(op,memtoreg,memwrite,branchneq,branchbeq,
               alusrc,regdst,regwrite,jp,jumplink,userd1,userd2,aluop);
    AluDec ad(func,aluop,
              alucontrol,bitshift,jumpreg);
    assign jump=jp|jumpreg;
endmodule
