`timescale 1ns / 1ps
/*
    
*/
module Selector(
        input logic clk, reset,
        input logic Stall, Flush,
        input logic SuperScalar,
        output logic [31: 0] PCA,
        output logic [31: 0] PCB,
        output logic [31: 0] InstrA,
        output logic [31: 0] InstrB,
        //Tp CPU
        input logic [31: 0] PCBranch,
        input logic Branch,
        // To CPU
        input logic TLBExpection,
        output logic [31: 0] Addr,
        input logic [63: 0] Instr
        //To Cache
    );
    
    logic [31: 0] NextAddr;
    logic [31: 0] InstrAReg, InstrBReg;
    
    logic [1: 0] STATE;
    always @(*)
        begin
            case (STATE)
                2'b00 : 
                    begin
                        NextAddr <= Addr + 8;
                    end
                //Init
                2'b01 : 
                    begin
                        if (SuperScalar)
                            begin
                                NextAddr <= (TLBExpection) ? (Addr) : (Addr + 4);
                            end
                        else
                            begin
                                NextAddr <= (TLBExpection) ? (Addr + 4) : (Addr + 8);
                                PCA <= (TLBExpection) ? (Addr) : (Addr - 4);    
                            end
                        PCA <= (TLBExpection) ? (Addr) : (Addr - 4);
                        PCB <= (TLBExpection) ? (Addr + 4) : (Addr);                             
                        InstrA <= (SuperScalar) ? (Instr[31: 0]) : (InstrBReg);
                        InstrB <= (SuperScalar) ? (Instr[63: 32]) : (Instr[31: 0]);
                    end
                //Match
                2'b10 : 
                    begin
                        if (SuperScalar)
                            begin
                                NextAddr <= (TLBExpection) ? (Addr) : (Addr + 4);
                            end
                        else
                            begin
                                NextAddr <= (TLBExpection) ? (Addr + 4) : (Addr + 8);    
                            end
                        PCA <= (TLBExpection) ? (Addr) : (Addr - 4);
                        PCB <= (TLBExpection) ? (Addr + 4) : (Addr);
                        InstrA <= (SuperScalar) ? (Instr[31: 0]) : (InstrBReg);
                        InstrB <= (SuperScalar) ? (Instr[63: 32]) : (Instr[31: 0]);
                    end
                //Ahead      
            endcase
        end
    
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset | Flush)
                begin
                    Addr <= 32'b0;
                    STATE <= 2'b01;
                end
            else
                if (!Stall)
                    begin
                        Addr <= (Branch) ? (PCBranch) : (NextAddr);
                        if (Branch) STATE <= 2'b00;
                        else
                            if (STATE == 2'b01)
                                STATE <= (SuperScalar) ? (2'b01) : (2'b10); 
                            else 
                                STATE <= (SuperScalar) ? (2'b01) : (2'b10);
                    end
        end 
endmodule