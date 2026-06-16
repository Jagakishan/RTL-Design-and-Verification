`timescale 1ns / 1ps


interface spi_if;

    bit clk, rst, csin;
    bit [7:0] master_data, slave_data;
    bit [7:0] master_data_register, slave_data_register;
    bit valid;

endinterface
