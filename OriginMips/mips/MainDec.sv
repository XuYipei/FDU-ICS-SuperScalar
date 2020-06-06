`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 17:21:33
// Design Name: 
// Module Name: MainDec
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


module MainDec(
        input logic [5:0] op,
        output logic memtoreg,memwrite,
        output logic branchneq,branchbeq,alusrc,
        output logic regdst,regwrite,
        output logic jump,jumplink,
        output logic userd1,userd2,
        output logic [2:0] aluop
    );
    logic[13:0] controls;
    assign {regwrite,regdst,alusrc,
            branchbeq,branchneq,
            memwrite,memtoreg,
            jump,jumplink,
            userd1,userd2,
            aluop}=controls;
    always @(*)
        case (op)
            6'b000000:controls<=14'b1_100_000_00_11_000;//Rtype,sra,sll,srl,nop,jr
            6'b001000:controls<=14'b1_010_000_00_10_001;//addi 
            6'b001100:controls<=14'b1_010_000_00_10_011;//andi
            6'b001101:controls<=14'b1_010_000_00_10_100;//ori
            6'b001010:controls<=14'b1_010_000_00_10_101;//slti
            6'b100011:controls<=14'b1_010_001_00_11_001;//lw 
            6'b101011:controls<=14'b0_010_010_00_11_001;//sw 
            6'b000100:controls<=14'b0_001_000_00_11_010;//beq
            6'b000101:controls<=14'b0_000_100_00_11_010;//bne
            6'b000010:controls<=14'b0_010_000_10_00_001;//j
            6'b000011:controls<=14'b1_010_000_11_00_001;//jal
        endcase
endmodule
/*
aluop:
000:Rtype,sll,sra,srl,jr
001:+,addi,jal,j
010:-,beq,bne
011:&,andi
100:|,ori
101:<,slti
*/
