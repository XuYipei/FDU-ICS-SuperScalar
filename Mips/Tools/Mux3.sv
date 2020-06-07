`timescale 1ns / 1ps
/*
    
*/
module Mux3 #(
        parameter WIDTH = 32
    )(
        input logic [WIDTH - 1: 0] A, B, C,
        input logic [1: 0] Sig,
        output logic [WIDTH - 1: 0] D
    );
    
    logic [WIDTH - 1: 0] D_;
    Mux2 #(WIDTH) Mux20(A, B, Sig[0], D_);
    Mux2 #(WIDTH) Mux21(D_, C, Sig[1], D);                                              
                                           
endmodule