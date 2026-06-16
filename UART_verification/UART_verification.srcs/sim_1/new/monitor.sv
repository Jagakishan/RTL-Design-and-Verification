`timescale 1ns / 1ns

class monitor;
    
    virtual uart_if intface;
    
    mailbox #(transaction) act_mbx;
    
    transaction trans;
    
    function new(mailbox #(transaction) act_mbx, virtual uart_if intface);
        this.act_mbx=act_mbx;
        this.intface=intface;
    endfunction
    
    task main();
    @(posedge intface.valid);
        forever begin
            @(posedge intface.valid);
            
            trans=new();
            trans.output_data=intface.output_data;
            act_mbx.put(trans);
        end
    
    endtask

endclass
