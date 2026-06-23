`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 32
`define ADDR_WIDTH $clog2(`DEPTH)

module fifo(input bit wr_clk, rd_clk, wr_en, rd_en, wr_rstn, rd_rstn, input bit [`DATA_WIDTH-1:0] wr_data, 
                                    output bit full, empty, output bit [`DATA_WIDTH-1:0] rd_data); 
    
    //Initialize the MEMORY BUFFER               
    bit [`DATA_WIDTH-1:0] buffer[`DEPTH-1:0];
    
    bit [`ADDR_WIDTH:0] wr_ptr, rd_ptr; //binary pointers
    bit [`ADDR_WIDTH:0] wr_ptr_gray, rd_ptr_gray; //gray pointers
    
    //Write op
    always_ff @(posedge wr_clk or negedge wr_rstn) begin
        if(!wr_rstn) begin
            wr_ptr<=0;
        end
        else begin
            if(wr_en && !full) begin
                buffer[wr_ptr[`ADDR_WIDTH-1:0]]<=wr_data;
                wr_ptr<=wr_ptr+1;
            end
        end
    end
    
    //Read op
    always_ff @(posedge rd_clk or negedge rd_rstn) begin
        if(!rd_rstn) begin
            rd_ptr<=0;
        end
        else begin
            if(rd_en && !empty) begin
                rd_data<=buffer[rd_ptr[`ADDR_WIDTH-1:0]];
                rd_ptr<=rd_ptr+1;
            end
        end
    end
    
    //Generating the gray pointers
    assign wr_ptr_gray = wr_ptr ^ (wr_ptr>>1);
    assign rd_ptr_gray = rd_ptr ^ (rd_ptr>>1);
    
    //Synchronizers
    
    //In write domain
    bit [`ADDR_WIDTH:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;
    
    always_ff @(posedge wr_clk or negedge wr_rstn) begin
        if(!wr_rstn) begin
            rd_ptr_gray_sync1<=0; 
            rd_ptr_gray_sync2<=0;   //Reset the flops in the domain
        end
        else begin
            rd_ptr_gray_sync1<=rd_ptr_gray;
            rd_ptr_gray_sync2<=rd_ptr_gray_sync1;
        end
    end
    
    //Generating the next pointers if write happens
    bit [`ADDR_WIDTH:0] wr_ptr_next, wr_ptr_gray_next;
    
    bit full_next; //Separate full and full_next because next ptr depends on full and full depends on next ptr. To avoid circular dependency, separate variables
    
    assign wr_ptr_next = wr_ptr + (wr_en && !full);
    assign wr_ptr_gray_next = wr_ptr_next ^ (wr_ptr_next >> 1);
    
    assign full_next = ((wr_ptr_gray_next) == {~rd_ptr_gray_sync2[`ADDR_WIDTH:`ADDR_WIDTH-1], rd_ptr_gray_sync2[`ADDR_WIDTH-2:0]});
    
    //Generate full
    always_ff @(posedge wr_clk or negedge wr_rstn) begin
        if(!wr_rstn) full<=0;
        else full<=full_next; 
    end
    
    //In read domain
    bit [`ADDR_WIDTH:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;
    
    always_ff @(posedge rd_clk or negedge rd_rstn) begin
        if(!rd_rstn) begin
            wr_ptr_gray_sync1<=0; 
            wr_ptr_gray_sync2<=0;   //Reset the flops in the domain
        end
        else begin
            wr_ptr_gray_sync1<=wr_ptr_gray;
            wr_ptr_gray_sync2<=wr_ptr_gray_sync1;      
        end 
    end
    
    //Generating the next pointers if read happens
    bit [`ADDR_WIDTH:0] rd_ptr_next, rd_ptr_gray_next;
    
    bit empty_next; //Separate empty and empty_next because next ptr depends on empty and empty depends on next ptr. So, separate variables
    
    assign rd_ptr_next = rd_ptr + (rd_en && !empty);
    assign rd_ptr_gray_next = rd_ptr_next ^ (rd_ptr_next >> 1);   
    
    assign empty_next = (rd_ptr_gray_next == wr_ptr_gray_sync2);
    
    //Generate empty condition
    always_ff @(posedge rd_clk or negedge rd_rstn) begin
         if(!rd_rstn) empty<=1;
         else empty<=empty_next;  
    end
    
endmodule
