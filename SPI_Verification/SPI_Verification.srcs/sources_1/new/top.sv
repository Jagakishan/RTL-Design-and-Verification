`timescale 1ns / 1ps

module top(input bit clk, rst, csin, input bit [7:0] master_data, slave_data, output bit [7:0] master_data_register, slave_data_register, output bit valid);
    
    bit sclk, cs;
    bit mosi, miso;
    
    master m_dut(.clk(clk), .rst(rst), .csin(csin), .master_data(master_data), 
            .sclk(sclk), .cs(cs), .mosi(mosi), .miso(miso), .master_data_register(master_data_register));
            
    slave s_dut(.sclk(sclk), .cs(cs), .slave_data(slave_data), .mosi(mosi), .miso(miso), 
                    .slave_data_register(slave_data_register), .valid(valid));


endmodule
