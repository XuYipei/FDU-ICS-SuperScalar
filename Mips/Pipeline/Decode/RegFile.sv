`timescale 1ns / 1ps

module RegFile(
        input logic clk,
        input logic weA,
        input logic [4:0] waA,
        input logic [31:0] wdA, 
        input logic [4:0] ra1A, ra2A,
        output logic [31:0] rd1A, rd2A,
        //A
        input logic weB,
        input logic [4:0] waB,
        input logic [31:0] wdB, 
        input logic [4:0] ra1B, ra2B,
        output logic [31:0] rd1B, rd2B
    );  
    logic [31: 0] rf [31: 0];
    
    always_ff @(posedge clk)
        begin
            if (weA) rf[waA] = wdA;
            if (weB) rf[waB] = wdB;
        end
    
    assign rd1A = (ra1A != 4'b0) ? (rf[ra1A]) : (32'b0);
    assign rd2A = (ra2A != 4'b0) ? (rf[ra2A]) : (32'b0);
    //A
    assign rd1B = (ra1B != 4'b0) ? (rf[ra1B]) : (32'b0);
    assign rd2B = (ra2B != 4'b0) ? (rf[ra2B]) : (32'b0);
    //B
endmodule
