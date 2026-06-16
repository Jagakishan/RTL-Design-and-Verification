`timescale 1ns / 1ns

module uart_rx(input bit clk, rd, rst, rx_enable, input bit rcvd_data, output bit [7:0] data_out, output bit valid);
    parameter idle_state=2'b00;
    parameter start_state=2'b01;
    parameter rcv_state=2'b10;
    parameter stop_state=2'b11;
    
    bit [1:0] cur_state=idle_state;
    bit [3:0] index=4'b0000;
    bit [7:0] temp_data;
    bit [3:0] sub_samples=4'b0000;
    bit wait_flag=1'b0;
    
    always @(posedge clk) begin
        if(rst) begin
            valid<=1'b0;
            cur_state<=idle_state;
            temp_data<=8'd0;
            index<=0;
            sub_samples<=4'b0000;
            wait_flag<=0;
        end
        else begin
            case(cur_state)
               
               idle_state:
                   begin
                       if(rx_enable && !rcvd_data) begin
                            valid<=0;
                            cur_state<=start_state;
                            sub_samples<=0;
                            temp_data   <= 0;
                        end
                   end
                   
               start_state:
                    begin
                        if(rd) begin
                            if(sub_samples==8) begin
                                if(!rcvd_data) begin
                                    cur_state<=rcv_state;  
                                    sub_samples<=0;
                                    index<=0;
                                end
                                else begin
                                 cur_state<=idle_state;
                                 sub_samples<=0;
                                end
                            end
                            else sub_samples<=sub_samples+1;
                        end
                    end
                   
               rcv_state:
                begin
                    
                    if(wait_flag==1'b0) begin
                        if(rd) begin
                            if(sub_samples==8)begin
                                sub_samples<=0;
                                wait_flag<=1'b1;
                            end
                            else sub_samples<=sub_samples+1;
                        end
                    end
                    else begin
                        if(rd)begin
                            if(sub_samples==4'b1111) begin
                                sub_samples<=0;
                                if(index==7) cur_state<=stop_state;
                                else index<=index+1;
                            end
                            else if(sub_samples==4'b1000) begin
                                sub_samples<=sub_samples+1;
                                temp_data[index]<=rcvd_data;
                            end
                            else sub_samples<=sub_samples+1;
                        end
                    end
                end
                
                stop_state:
                    begin
                        if(rd) begin                        
                            if(sub_samples==8)begin
                                if(rcvd_data) begin
                                    data_out<=temp_data;
                                    valid<=1'b1;
                                end
                                @(posedge clk);
                                valid<=1'b0;
                                cur_state<=idle_state;
                                temp_data<=8'd0;
                                index<=0;
                                sub_samples<=4'b0000;
                                wait_flag<=0;
                            end
                            else sub_samples<=sub_samples+1;
                        end
                    end
                    
                    
               default: 
                 cur_state<=idle_state;
                 
            endcase
        
        end
    
    end
endmodule