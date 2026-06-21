`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 32 //Make sure the DEPTH is a power of 2

interface fifo_if;
    
    bit clk, rst, wr, rd;
    bit [`DATA_WIDTH-1:0] write_data, read_data;
    bit full, empty, underflow, overflow;
    
endinterface
