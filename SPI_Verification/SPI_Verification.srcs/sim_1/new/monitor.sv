`timescale 1ns / 1ps


class monitor;

    virtual spi_if intface;
    
    mailbox #(transaction) act_mbx;
    
    transaction trans;
    
    function new(mailbox #(transaction) act_mbx, virtual spi_if intface);
        this.act_mbx=act_mbx;
        this.intface=intface;
    endfunction
    
    task main();
        forever begin
            @(posedge intface.valid);
            
            trans=new();
            trans.master_data_register=intface.master_data_register;
            trans.slave_data_register=intface.slave_data_register;
            
            act_mbx.put(trans);
        end
    endtask
    

endclass
