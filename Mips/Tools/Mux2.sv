`timescale 1ns / 1ps
/*
    
*/
module Mux2(
        input logic [32: 0] A, B,
        input logic Sig,
        output logic [31: 0] C
    );
    
    assign C = (Sig) ? (B) : (A);
    
endmodule