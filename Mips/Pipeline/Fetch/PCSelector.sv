`timescale 1ns / 1ps
/*
    
*/
module AddrSelector(
        input logic clk, reset,
        input logic Stall, Flush,
        input logic [32: 0] PCDecode,
        input logic [32: 0] PCPlus4,
        input logic Selector,
        output logic [31: 0] PC
    );
    
    logic [31: 0] PC_;
    Mux2 #(32) Mux20(PCDecode, PCPlus4, Selector, PC_);
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset | Flush)
                    PC <= 32'b0;
            else
                if (!Stall)
                    PC <= PC_;
        end 
    
endmodule