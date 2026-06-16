`timescale 1ns/1ns

module uart_top(input bit clk, rst, tx_enable, rx_enable, output bit valid, input [7:0] input_data, output [7:0] output_data );

    bit wr, rd;
    bit tx_data, busy;
    
    br_gen bg(.clk(clk), .rst(rst), .wr(wr), .rd(rd));
    
    uart_tx tx(.clk(clk), .rst(rst), .tx_enable(tx_enable), .wr(wr), .data_in(input_data), .tx_data(tx_data), .busy(busy));
    
    uart_rx rx(.clk(clk), .rst(rst), .rd(rd), .rx_enable(rx_enable), .rcvd_data(tx_data), .data_out(output_data), .valid(valid));

endmodule
