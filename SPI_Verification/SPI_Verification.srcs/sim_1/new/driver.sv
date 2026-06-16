`timescale 1ns / 1ps


class driver;
    
    transaction trans;
    
    mailbox #(transaction) mbx1;
    
    virtual spi_if intface;
    
    event one_cycle_done;
    
    function new(mailbox #(transaction) mbx1, virtual spi_if intface, event one_cycle_done);
        this.mbx1=mbx1;
        this.intface=intface;
        this.one_cycle_done=one_cycle_done;
    endfunction
    
    task main;
        forever begin
            mbx1.get(trans);
            
            if(trans.inject_rst) begin
                intface.rst=1;
                @(posedge intface.clk);
                intface.rst=0;
            end
            
            @(posedge intface.clk);
            intface.master_data<=trans.master_data;
            intface.slave_data<=trans.slave_data;
            
            wait(intface.valid);
            #100;
            
            ->one_cycle_done;
        
        end
    endtask

endclass
