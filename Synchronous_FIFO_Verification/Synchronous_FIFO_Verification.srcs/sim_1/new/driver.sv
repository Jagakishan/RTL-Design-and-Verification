`timescale 1ns / 1ps


class driver;
    
    transaction trans;
    
    mailbox #(transaction) mbx1;

    virtual fifo_if intface;
    
    event one_cycle_done;
    event signals_applied;
    
    function new(input mailbox #(transaction) mbx1, input virtual fifo_if intface, input event one_cycle_done, input event signals_applied);
        this.mbx1=mbx1;
        this.intface=intface;
        this.one_cycle_done=one_cycle_done;
        this.signals_applied=signals_applied;
    endfunction
    
    task main();
        forever begin
            mbx1.get(trans);
            
            if(trans.inject_rst) begin
                intface.rst<=1;
                @(posedge intface.clk);
                intface.rst<=0;
            end
            
            @(posedge intface.clk);
            intface.rd<=trans.rd;
            intface.wr<=trans.wr;
            intface.write_data<=trans.write_data;
            
            ->signals_applied;
            
            @(posedge intface.clk);
            intface.rd<=0;
            intface.wr<=0;
            
            repeat(3) @(posedge intface.clk); //Wait some clock cycles before sending new data 
            ->one_cycle_done;
        end
    endtask
    
endclass
