`include "bpb.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/23 10:52:47
// Design Name: 
// Module Name: Unit
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


module Unit #(
        parameter ENTRIES = `BPB_E,
        parameter TAG_WIDTH = `BPB_T
    )(
        input logic clk, reset, stall, flush, mod,
        input logic wen,
        output logic [TAG_WIDTH - 1: 0] prd_tag,
        output logic prd_taken,
        input logic [TAG_WIDTH - 1: 0] real_tag,
        input logic real_taken,
        input logic mistake
    );
    logic [1: 0] STATUS;
    logic [TAG_WIDTH - 1: 0] tag;
    
    assign prd_taken = STATUS[1];
    assign prd_tag = tag;
    
    always_ff @(posedge clk, posedge reset)
        if (reset)
            begin
                STATUS <= 2'b00;
                tag <= 10'b00;
            end
        else
            if (wen & !stall)
                begin
                    if (tag != real_tag)
                        begin
                            STATUS = 2'b00;
                            tag = real_tag;
                        end
                    if (mod)
                        begin
                            case (STATUS)
                                2'b00: STATUS = (real_taken) ? (2'b01) : (2'b00);
                                2'b01: STATUS = (real_taken) ? (2'b11) : (2'b00);
                                2'b10: STATUS = (real_taken) ? (2'b11) : (2'b00);
                                2'b11: STATUS = (real_taken) ? (2'b11) : (2'b10);                        
                            endcase
                        end
                    else
                        begin
                            case (STATUS)
                                2'b00: STATUS = (mistake) ? (2'b01) : (2'b00);
                                2'b01: STATUS = (mistake) ? (2'b11) : (2'b00);
                                2'b10: STATUS = (mistake) ? (2'b00) : (2'b11);
                                2'b11: STATUS = (mistake) ? (2'b10) : (2'b11);                        
                            endcase
                        end
                end
endmodule
