`timescale 1ns / 1ps


module master(input bit clk, rst, csin, input bit [7:0] master_data, output bit sclk, cs, output bit mosi, input bit miso, output bit [7:0] master_data_register);

    //Define states
    parameter idle_state=2'b00;
    parameter transfer_state=2'b01;
    parameter done_state=2'b10;
    
    bit [1:0] current_state=idle_state;
    bit [2:0] tx_index=3'b110; //7 bits as 1st bit is preloaded
    bit [2:0] rx_index=3'b111; //8 bits
    bit [7:0] temp;
    bit [3:0] counter=0;
    
    always @(posedge clk) begin
            
            if(rst) begin
                current_state<=idle_state;
                cs<=1;
                mosi<=0;
                tx_index=3'b110;
                rx_index=3'b111;
                sclk<=0;
                counter<=0;
            end
            else begin
                
                case(current_state)
                    idle_state:
                    begin
                        if(csin==0) begin
                            cs<=0;
                            sclk<=0;
                            tx_index<=3'b110;
                            rx_index<=3'b111;
                            counter<=1;
                            
                            //Preload master_data for receiver's first rising edge
                            mosi<=master_data[7];
                                                        
                            current_state<=transfer_state;
                        end
                        else begin
                            cs<=1;
                            current_state<=idle_state;
                        end
                    end
                      
                    transfer_state:
                    begin
                        if(tx_index==6 && counter==7) mosi<=master_data[7]; //Preload a little late to get the first bit right
                        
                        if(counter==9) counter<=0;
                        else counter<=counter+1;
                        
                        if(counter==0) begin
                        
                            if(sclk==0) begin  //Rising edge 
                                if(rx_index>0) begin
                                    temp[rx_index]<=miso;
                                    rx_index<=rx_index-1;
                                end
                                else begin
                                    temp[0]<=miso;
                                    master_data_register<={temp[7:1], miso};
                                    current_state<=done_state;
                                end
                            end
                            else begin  //Falling edge 
                                if(tx_index>0) begin
                                    mosi<=master_data[tx_index];
                                    tx_index<=tx_index-1;
                                end
                                else begin
                                    mosi<=master_data[0];
                                end
                            end

                            sclk<=~sclk;  
                        end
                        
                    end
                    
                    done_state:
                    begin
                        mosi<=0;
                        cs<=1;
                        current_state<=idle_state;
                    end     
                    
                    default: 
                        current_state<=idle_state;
                        
                endcase
            end
    end
    

          
endmodule
