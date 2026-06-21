`timescale 1ns / 1ps


class monitor;
    
    transaction trans;
    
    mailbox #(transaction) mbx2;

    virtual fifo_if intface;
    
    event signals_applied;
    
    function new(input mailbox #(transaction) mbx2, input virtual fifo_if intface, input event signals_applied);
        this.mbx2=mbx2;
        this.intface=intface;
        this.signals_applied=signals_applied;
    endfunction
    
    task main();
        forever begin
            @(signals_applied);
            
            @(posedge intface.clk);
            
            trans=new();
            trans.rd<=intface.rd;
            trans.wr<=intface.wr;
            trans.write_data<=intface.write_data;
            trans.read_data<=intface.read_data;
            trans.full<=intface.full;
            trans.empty<=intface.empty;
            trans.overflow<=intface.overflow;
            trans.underflow<=intface.underflow;
            
            mbx2.put(trans);
            
        end
    endtask

endclass
