`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 8 //Make sure the DEPTH is a power of 2

module directed_tb;

    bit clk=0;
    bit rst=0;
    bit wr=0;
    bit rd=0;
    bit [`DATA_WIDTH-1:0] write_data=0;
    bit [`DATA_WIDTH-1:0] read_data;
    bit full, empty, underflow, overflow;
    
    fifo dut(.clk(clk), .rst(rst), .wr(wr), .rd(rd), .write_data(write_data), 
                .read_data(read_data), .full(full), .empty(empty), .underflow(underflow), .overflow(overflow));
    
    always #10 clk=~clk;
    
    initial begin
        rst=1;
        #100;
        rst=0;
        
        wr=1;
        write_data=8'haa;
        #20;
        write_data=8'hbb;
        #20;
        write_data=8'hcc;
        #20;
        write_data=8'hdd;
        #20;
    
        rd=1;
        @(posedge clk);
        $display("%h", read_data);
        @(posedge clk);
        $display("%h", read_data);
        @(posedge clk);
        $display("%h", read_data);
        @(posedge clk);
        $display("%h", read_data);
        
        $finish;
    end
    
endmodule
