`timescale 1ns / 1ns
//`include "transaction.sv"
//`include "interface.sv"

class driver;

    transaction trans;
    mailbox #(transaction) mbx;
    
    virtual uart_if intface;
    
    event one_cycle_done;
    
    function new(mailbox #(transaction) mbx, virtual uart_if intface, event one_cycle_done);
        this.mbx=mbx;
        this.intface=intface;
        this.one_cycle_done=one_cycle_done;
    endfunction
    
    task main();
        forever begin
            mbx.get(trans);
            
            @(posedge intface.clk);
            intface.input_data<=trans.input_data;
            
            wait(intface.valid);
            
            ->one_cycle_done;
            #100; //Give sometime for the event to be captured in order not to avoid immediate inputs

//            $display("DRIVER HAS RECEIVED AND TRIGGERED INTERFACE");
//            trans.display();
        end
    
    endtask
    
    
endclass
