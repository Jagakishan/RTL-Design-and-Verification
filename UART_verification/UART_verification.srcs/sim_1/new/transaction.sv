`timescale 1ns / 1ns

class transaction;
    
    bit rst;
    bit tx_enable, rx_enable;
    randc bit [7:0] input_data;
    bit [7:0] output_data;
    bit valid;
    
    function transaction copy();
        copy=new();
        
        copy.rst= this.rst;
        copy.tx_enable=this.tx_enable;
        copy.rx_enable=this.rx_enable;
        copy.input_data=this.input_data;
        copy.output_data=this.output_data;
        copy.valid=this.valid;
    endfunction
    
    function void display();
        $display("RANDOMIZED VALUE: input data= %0h", input_data); 
    endfunction
    
    
endclass
