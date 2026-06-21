`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 32 //Make sure the DEPTH is a power of 2

module fifo(input bit clk, rst, input bit wr, rd, input bit [`DATA_WIDTH-1:0] write_data, 
                            output bit [`DATA_WIDTH-1:0] read_data, output bit full, empty, output bit underflow, overflow);
    
    bit [`DATA_WIDTH-1:0] buffer[`DEPTH-1:0];
    bit [$clog2(`DEPTH):0] wr_pointer, rd_pointer; //Extra MSB to check full condition
    
    assign full = (wr_pointer[$clog2(`DEPTH)-1:0] == rd_pointer[$clog2(`DEPTH)-1:0]) && (wr_pointer[$clog2(`DEPTH)] != rd_pointer[$clog2(`DEPTH)]);
    
    assign empty = (wr_pointer == rd_pointer);
    
    always @(posedge clk) begin
        
        if(rst) begin
            wr_pointer<=0;
            rd_pointer<=0;
            read_data<=0;
            overflow<=0;
            underflow<=0;
        end
        else begin
            overflow<=0;
            underflow<=0;
            
            if(full && wr && rd) begin
                buffer[wr_pointer[$clog2(`DEPTH)-1:0]]<=write_data;
                read_data<=buffer[rd_pointer[$clog2(`DEPTH)-1:0]];
                wr_pointer<=wr_pointer+1;
                rd_pointer<=rd_pointer + 1;
            end
            else begin
                if(wr) begin
                    if(!full) begin
                        buffer[wr_pointer[$clog2(`DEPTH)-1:0]]<=write_data;
                        wr_pointer<=wr_pointer+1;
                    end
                    else overflow<=1;
                end
                if(rd) begin
                    if(!empty) begin
                        read_data<=buffer[rd_pointer[$clog2(`DEPTH)-1:0]];
                        rd_pointer<=rd_pointer + 1;
                    end
                    else underflow<=1;
                end
            end
        end
    end

endmodule
