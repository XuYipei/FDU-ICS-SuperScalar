`timescale 1ns / 1ps

module MainDec(
        input logic [5:0] op,
        output logic memtoreg,memwrite,
        output logic branchneq,branchbeq,alusrc,
        output logic regdst,regwrite,
        output logic jump,jumplink,
        output logic [2:0] aluop
    );
    logic[11:0] controls;
    assign {regwrite, regdst, alusrc,
            branchbeq, branchneq,
            memwrite, memtoreg,
            jump, jumplink,
            aluop} = controls;
    always @(*)
        case (op)
            6'b000000 : controls <= 12'b1_100_000_00_000;//Rtype,sra,sll,srl,nop,jr
            6'b001000 : controls <= 12'b1_010_000_00_001;//addi 
            6'b001100 : controls <= 12'b1_010_000_00_011;//andi
            6'b001101 : controls <= 12'b1_010_000_00_100;//ori
            6'b001010 : controls <= 12'b1_010_000_00_101;//slti
            6'b100011 : controls <= 12'b1_010_001_00_001;//lw 
            6'b101011 : controls <= 12'b0_010_010_00_001;//sw 
            6'b000100 : controls <= 12'b0_001_000_00_010;//beq
            6'b000101 : controls <= 12'b0_000_100_00_010;//bne
            6'b000010 : controls <= 12'b0_010_000_10_001;//j
            6'b000011 : controls <= 12'b1_010_000_11_001;//jal
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
