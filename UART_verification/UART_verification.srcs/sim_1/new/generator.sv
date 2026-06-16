`timescale 1ns / 1ns
//`include "transaction.sv"

class generator;

    transaction trans;
    mailbox #(transaction) mbx;
    mailbox #(transaction) exp_mbx;
    
    event one_cycle_done;
    
    int i=0;
    
    function new( mailbox #(transaction) mbx, mailbox #(transaction) exp_mbx, event one_cycle_done);
        this.mbx=mbx;
        this.exp_mbx=exp_mbx;
        this.one_cycle_done=one_cycle_done;
        trans=new();
    endfunction
    
    task main();
        
        for(i=0;i<256;i++) begin
            assert(trans.randomize()) else
                $display("RANDOMIZATION FAILED AT ITERATION: %0d", i);
                
            mbx.put(trans.copy());
            exp_mbx.put(trans.copy());

            @(one_cycle_done);  
       
//            $display("GENERATOR HAS SENT DATA");
//            trans.display();
            

        end
        
    
    endtask

endclass
