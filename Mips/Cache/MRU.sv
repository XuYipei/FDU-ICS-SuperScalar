`include "cache.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/18 17:27:04
// Design Name: 
// Module Name: ReplacementController
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


module MRU #(parameter
        TAG_WIDTH = `CACHE_T,
        OFFSET_WIDTH = `CACHE_B,
		LINES = `CACHE_E
    )(
        input logic clk, reset, en,
        input logic [TAG_WIDTH - 1: 0] addr_tag,
        input logic [TAG_WIDTH - 1: 0] line_tag [LINES - 1: 0],
        input logic [LINES - 1: 0] line_valid, line_dirty,
        input logic [31: 0] line_data [LINES - 1: 0],
        input logic wen,  
        output logic hit, dirty, 
        output logic [LINES - 1: 0] line_wen,
        output logic [31: 0] read_data,
        output logic [TAG_WIDTH - 1: 0] replace_tag 
    );
    logic err;
    logic [2: 0] tmp;
    logic [2: 0] index [LINES - 1: 0];
    integer find = 0, i = 0, top = 0;
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset)
                for (i = 0; i < LINES; i = i + 1) index[i] = i;
            else
                if (en)
                    begin    
                        if (hit) 
                            begin
                                top = 0;
                                for (i = 0; i < LINES; i = i + 1) 
                                    if (!line_valid[index[i]]) top = i;
                                if (line_valid[index[0]])
                                    begin
                                        tmp = index[0];
                                        index[0] = index[top];
                                        index[top] = tmp;                                                                   
                                    end
                                for (i = top; i < LINES; i = i + 1)
                                    if (line_tag[index[i]] == addr_tag)
                                        find = i;
                                tmp = index[top];
                                for (i = top; i + 1 < find; i = i + 1)
                                    index[i] = index[i + 1];
                                index[find] = tmp;
                            end
                        else
                            err = 1;                            
                    end
        end
          
    logic [2:0] hits; 
    assign {hit, dirty} = hits;
    always @(*)
        begin
            if (addr_tag == line_tag[0] && line_valid[0])
                begin
                    hits <= {1'b1, line_dirty[0]};
                    line_wen <= {3'b0, wen};
                    read_data <= line_data[0];
                    replace_tag <= line_tag[0];
                end
            else
                if (addr_tag == line_tag[1] && line_valid[1])
                    begin
                        hits <= {1'b1, line_dirty[1]};
                        line_wen <= {2'b0, wen, 1'b0};
                        read_data <= line_data[1];
                        replace_tag <= line_tag[1];
                    end
                else
                    if (addr_tag == line_tag[2] && line_valid[2])
                        begin
                            hits <= {1'b1, line_dirty[2]};
                            line_wen <= {1'b0, wen, 2'b0};
                            read_data <= line_data[2];
                            replace_tag <= line_tag[2];
                        end
                    else
                        if (addr_tag == line_tag[3] && line_valid[3])
                            begin
                                hits <= {1'b1, line_dirty[3]};
                                line_wen <= {wen, 3'b0};
                                read_data <= line_data[3];
                                replace_tag <= line_tag[3];
                            end
                        else 
                            begin
                                hits <= {1'b0, line_dirty[index[0]]};
                                replace_tag <= line_tag[index[0]];
                                read_data <= line_data[index[0]];
                                line_wen = 4'b0000;
                                line_wen[index[0]] = wen;
                            end
        end
    
endmodule
