`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 17:22:16
// Design Name: 
// Module Name: AluDec
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


module AluDec(
    input logic [5:0] func,
    input logic [2:0] aluop,
    output logic [2:0] alucontrol,
    output logic bitshift,
    output logic jumpreg
    );
    logic [4:0] result;
    assign {alucontrol,bitshift,jumpreg}=result;
    always @(*)
        case (aluop)
            3'b001: result<=5'b010_00;//addi,jal,sw,lw,j
            3'b010: result<=5'b011_00;//beq,neq
            3'b011: result<=5'b000_00;//andi
            3'b100: result<=5'b001_00;//ori
            3'b101: result<=5'b111_00;//slti
            default: 
                case (func)
                    6'b100000: result<=5'b010_00;//add
                    6'b100010: result<=5'b011_00;//sub
                    6'b100100: result<=5'b000_00;//and
                    6'b100101: result<=5'b001_00;//or
                    6'b101010: result<=5'b111_00;//slt
                    6'b001000: result<=5'b010_01;//jr
                    6'b000011: result<=5'b110_10;//sra
                    6'b000000: result<=5'b100_10;//sll
                    6'b000010: result<=5'b101_10;//srl
                    default: result<=5'bxxx_x;
                endcase
        endcase
endmodule
/*
000:&
001:|
010:+
011:-
100:<<
101:>>
110:>>>
111:<
*/