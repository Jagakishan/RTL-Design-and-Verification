`timescale 1ns / 1ns


interface uart_if;
    
    bit clk, rst;
    bit tx_enable, rx_enable;
    bit [7:0] input_data;
    bit [7:0] output_data;
    bit valid;
    
endinterface
