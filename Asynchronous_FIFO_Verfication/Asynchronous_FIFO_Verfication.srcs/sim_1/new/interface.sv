`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 32
`define ADDR_WIDTH $clog2(`DEPTH)

interface fifo_if;
    
    bit wr_clk, rd_clk;
    bit wr_en, rd_en;
    bit wr_rstn, rd_rstn;
    bit [`DATA_WIDTH-1:0] wr_data;
    bit full, empty;
    bit [`DATA_WIDTH-1:0] rd_data;

endinterface
