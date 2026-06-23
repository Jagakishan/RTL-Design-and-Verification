`timescale 1ns / 1ps

class generator;
    
    transaction trans;
    
    mailbox #(transaction) mbx1, mbx3;
    
    event one_cycle_done;
    
    function new(input mailbox #(transaction) mbx1, input event one_cycle_done, input mailbox #(transaction) mbx3);
        this.mbx1=mbx1;
        this.one_cycle_done=one_cycle_done;
        this.mbx3=mbx3;
        trans=new();       
    endfunction;
    
    int i=0;
    
    task main();
        for(i=0;i<1000;i++) begin
            assert(trans.randomize())else 
                $display("RANDOMIZATION FAILED AT ITERATION %0d", i);
                
            mbx1.put(trans.copy);
            mbx3.put(trans.copy);
            
            @(one_cycle_done);
            
        end       
    endtask

endclass
