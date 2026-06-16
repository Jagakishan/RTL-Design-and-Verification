`timescale 1ns / 1ps

class generator;
    
    transaction trans;
    
    mailbox #(transaction) mbx1;
    mailbox #(transaction) exp_mbx;
    
    event one_cycle_done;
    
    function new(mailbox #(transaction) mbx1, mailbox #(transaction) exp_mbx, event one_cycle_done);
        this.mbx1=mbx1;
        this.exp_mbx=exp_mbx;
        this.one_cycle_done=one_cycle_done;
        trans=new();
    endfunction
    
    int i=0;
    
    task main();
        trans.idle_test.constraint_mode(0);
        trans.force_slave_zero.constraint_mode(0); //Disabling constraints
        
        for(int i=0;i<256;i++)begin
            assert(trans.randomize()) else
                $display("RANDOMIZATION FAILED AT ITERATION %d", i);
                
            mbx1.put(trans.copy);
            exp_mbx.put(trans.copy);
            
            @(one_cycle_done);
        end
    endtask

endclass