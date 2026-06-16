`timescale 1ns / 1ns

module br_gen(input bit clk, rst, output bit wr, output bit rd);
    
    bit [12:0] tx_counter=0;
    bit [8:0] rx_counter=0;
    
    always @(posedge clk) begin
        if(rst) tx_counter<=0;
        else if(tx_counter==434) tx_counter<=0; //Actual counter val=5208 
        else tx_counter<=tx_counter+1;
    end
    
    always @(posedge clk) begin
        if(rst) rx_counter<=0;
        else if(rx_counter==27) rx_counter<=0; //Actual counter val=325
        else rx_counter<=rx_counter+1;
    end
    
    assign wr=(tx_counter==0);
    assign rd=(rx_counter==0);
    
endmodule