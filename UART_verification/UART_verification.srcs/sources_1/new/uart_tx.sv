`timescale 1ns / 1ns

module uart_tx(input bit clk, rst, tx_enable, wr, input bit [7:0] data_in, output bit tx_data, busy);
    parameter idle_state=2'b00;
    parameter start_state=2'b01;
    parameter transmit_state=2'b10;
    parameter stop_state=2'b11;
    
    bit [1:0] cur_state=idle_state;
    bit [3:0] index=4'b0000;
    bit [7:0] temp_data;
    
    bit temp_tx_enable=tx_enable;
    
    always @(posedge clk) begin
        if(rst) begin
            cur_state <= idle_state;
            tx_data   <= 1'b1;
            index     <= 0;
            temp_data <= 0;
            temp_tx_enable<=1;
        end
        
        else begin
        
        case(cur_state)
            idle_state:
                begin
                    tx_data   <= 1'b1;
                    if(temp_tx_enable) begin
                        cur_state<=start_state;
                        index<=4'b0000;
                        temp_data<=data_in;
                        end
                     else cur_state<=idle_state;
                end
                
            start_state:
                begin
                    if(wr) begin
                        tx_data<=1'b0; //Start bit
                        cur_state<=transmit_state;
                    end
                    else cur_state<=start_state;
                end
                
            transmit_state:
                begin
                    if(wr) begin
                    tx_data<=temp_data[index];
                        if(index==4'd7) begin
                            cur_state<=stop_state;
                            index<=4'b0000;
                        end
                        else begin
                            index <= index + 1;
                        end
                    end
                end
                
            stop_state:
                begin
                    if(wr) begin
                        cur_state <= idle_state;
                        tx_data   <= 1'b1;
                        index     <= 0;
                        temp_data <= 0;
                        temp_tx_enable<=1;
                    end
                    else cur_state<=stop_state;
                end
            
            default:
                begin
                    cur_state<=idle_state;
                    tx_data<=1'b1;
                end

        endcase
        end
    end
    
    assign busy = (cur_state != idle_state);
    
endmodule