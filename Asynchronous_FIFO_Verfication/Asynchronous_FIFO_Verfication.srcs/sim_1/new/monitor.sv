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
    
//    int mon_count;
    
    task main();
        forever begin
            @(signals_applied);
            #1; //Just to make sure the dut has stored the recent data in the variables
            trans=new();

            trans.full=intface.full;    
            trans.wr_data=intface.wr_data;

            trans.empty=intface.empty;
            trans.rd_data=intface.rd_data; 

            mbx2.put(trans);
        end
    endtask    
    
endclass
