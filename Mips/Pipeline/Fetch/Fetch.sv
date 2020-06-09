`timescale 1ns / 1ps
/*
    PCDecode:   PC from Decode like Jump Branch or PCPlus8 
*/

module Fetch(
        input logic clk, reset,
        input logic Stall, Flush,
        input logic SuperScalar,
        input logic Branch,
        input logic [31: 0] PCBranch,
        // To CPU
        output logic [31: 0] PCPlus4FOutA,
        output logic [31: 0] InstrA,
        output logic [31: 0] PCPlus4FOutB,
        output logic [31: 0] InstrB,
        //To CPU
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
                            end
                        PCPlus4FOutA <= (TLBExpection) ? (Addr + 3'b100) : (Addr);
                        PCPlus4FOutB <= (TLBExpection) ? (Addr + 4'b1000) : (Addr + 3'b100);                             
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
                        PCPlus4FOutA <= (TLBExpection) ? (Addr + 3'b100) : (Addr);
                        PCPlus4FOutB <= (TLBExpection) ? (Addr + 4'b1000) : (Addr + 3'b100);
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
                                begin
                                    if (SuperScalar)
                                        STATE <= (TLBExpection) ? (2'b01) : (2'b10);
                                    else
                                        STATE <= (TLBExpection) ? (2'b01) : (2'b10); 
                                end 
                            else 
                                STATE <= (SuperScalar) ? (2'b01) : (2'b10);
                    end
        end 
endmodule