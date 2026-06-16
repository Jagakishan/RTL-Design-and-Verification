`timescale 1ns / 1ps


module slave(input bit sclk, cs, input bit [7:0] slave_data, input bit mosi, output bit miso, output bit [7:0] slave_data_register, output bit valid);
    
    bit [2:0] tx_index=3'b110;
    bit [2:0] rx_index=3'b111;
    bit [7:0] temp;
    
    always @(negedge cs or slave_data) begin
        tx_index<=3'b110;
        rx_index<=3'b111;
        valid<=1'b0;
        
        //Preload first bit
        miso<=slave_data[7];
        
    end
    
    always @(posedge sclk) begin
        
        if(cs==0) begin 
                if(rx_index!=0) begin
                    temp[rx_index]<=mosi;
                    rx_index<=rx_index-1;
                end
                else begin
                    temp[0]<=mosi;
                    slave_data_register<={temp[7:1], mosi};
                    valid<=1'b1;
                end 
         end
    end
    
    always @(negedge sclk) begin
        if(cs==0) begin
            if(tx_index!=0) begin
                miso<=slave_data[tx_index];
                tx_index<=tx_index-1;
            end
            else begin
                miso<=slave_data[0];
            end
        end
    end
    
endmodule
