`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 8
`define ADDR_WIDTH $clog2(`DEPTH)

module directed_tb;

    bit wr_clk=0, rd_clk=0;
    bit wr_en=0, rd_en=0;
    bit wr_rstn=1, rd_rstn=1;
    bit [`DATA_WIDTH-1:0] wr_data=0;
    bit full, empty;
    bit [`DATA_WIDTH-1:0] rd_data;
    
    fifo dut(.wr_clk(wr_clk), .rd_clk(rd_clk), .wr_en(wr_en), .rd_en(rd_en), .wr_rstn(wr_rstn), .rd_rstn(rd_rstn), .wr_data(wr_data), 
                                    .full(full), .empty(empty), .rd_data(rd_data)); 
                                    
    always #10 wr_clk=~wr_clk; //50MHz
    always #20 rd_clk=~rd_clk; //25MHz
    
    initial begin
        wr_rstn=0;
        rd_rstn=0;
        #200;
        wr_rstn=1;
        rd_rstn=1;
        
        wr_en=1;
        wr_data=8'haa;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'hcc;
        @(posedge wr_clk);    
        wr_en=0;  
        
        wr_en=1;
        wr_data=8'hff;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'hbb;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'h01;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'h03;
        @(posedge wr_clk);    
        wr_en=0;  
        
        wr_en=1;
        wr_data=8'h05;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'h45;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'h79;
        @(posedge wr_clk);    
        wr_en=0; 
        
        rd_en=1;
        @(posedge rd_clk);
        $display("RCVD :%0h", rd_data);
        
        @(posedge rd_clk);
        $display("RCVD :%0h", rd_data);
        
        @(posedge rd_clk);
        $display("RCVD :%0h", rd_data);
        
        @(posedge rd_clk);
        $display("RCVD :%0h", rd_data);
        rd_en=0;
        
        wr_en=1;
        wr_data=8'h32;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'h33;
        @(posedge wr_clk);    
        wr_en=0;  
        
        wr_en=1;
        wr_data=8'h34;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'h35;
        @(posedge wr_clk);    
        wr_en=0; 
        
        wr_en=1;
        wr_data=8'h36;
        @(posedge wr_clk);    
        wr_en=0; 
        
        
        #100;
        
        
        $finish;
    end


endmodule
