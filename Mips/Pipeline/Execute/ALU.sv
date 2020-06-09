`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/26 11:56:12
// Design Name: 
// Module Name: ALU
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

module ALU(
        input logic [31:0] a,b,
        input logic [2:0] alucont,
        output logic [31:0] result
    );
    logic signed [31: 0] a_, b_;
    assign a_ = a;
    assign b_ = b;
    always @(*)
        case (alucont)
            3'b000: result<=a_ & b_;
            3'b001: result<=a_ | b_;
            3'b010: result<=a_ + b_;
            3'b011: result<=a_ - b_;
            3'b100: result<=(b_ << a_);
            3'b101: result<=(b_ >> a_);
            3'b110: result<=(b_ >>> a_);
            3'b111: result<=(a_ < b_)?(1):(0);
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
