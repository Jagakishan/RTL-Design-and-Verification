`timescale 1ns / 1ps


module directed_tb;

    bit clk=0;
    bit rst=0;
    bit csin=1;
    bit [7:0] master_data=8'd0;
    bit [7:0] slave_data=8'd0;
    bit [7:0] master_data_register=8'd0;
    bit [7:0] slave_data_register=8'd0;
    bit valid=0;

    top dut(.clk(clk), .rst(rst), .csin(csin), .master_data(master_data), .slave_data(slave_data), 
                    .master_data_register(master_data_register), .slave_data_register(slave_data_register), .valid(valid));
                    
    always #10 clk=~clk;
                    
    initial begin 
        
        rst=1;
        csin=1;
        #100;
        rst=0;
        csin=0;
        
        master_data = 8'hE1; slave_data = 8'h27; wait(valid); #100;
        master_data = 8'h1A; slave_data = 8'h35; wait(valid); #100;
        master_data = 8'h2D; slave_data = 8'h1F; wait(valid); #100;
        master_data = 8'hAA; slave_data = 8'h09; wait(valid); #100;
        master_data = 8'h42; slave_data = 8'hEE; wait(valid); #100;
        master_data = 8'hD7; slave_data = 8'h58; wait(valid); #100;
        master_data = 8'h04; slave_data = 8'hB3; wait(valid); #100;
        master_data = 8'h9C; slave_data = 8'h61; wait(valid); #100;
        master_data = 8'h73; slave_data = 8'hC8; wait(valid); #100;
        master_data = 8'hF0; slave_data = 8'h14; wait(valid); #100;
        
        $finish;
    
    
    end
    
endmodule
