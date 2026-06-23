`timescale 1ns / 1ps


class driver;
    
    transaction trans, trans_hpnd;
    
    mailbox #(transaction) mbx1, mbx4;

    virtual fifo_if intface;
    
    event one_cycle_done;
    event signals_applied;
    
    function new(input mailbox #(transaction) mbx1, input virtual fifo_if intface, input event one_cycle_done, input event signals_applied, input mailbox #(transaction) mbx4);
        this.mbx1=mbx1;
        this.intface=intface;
        this.one_cycle_done=one_cycle_done;
        this.signals_applied=signals_applied;
        this.mbx4=mbx4;
    endfunction
    
    task write();
        if(trans.inject_wr_rstn) begin
            intface.wr_rstn<=0;
            @(posedge intface.wr_clk);
            intface.wr_rstn<=1;
        end
        else begin
        @(posedge intface.wr_clk);
            intface.wr_en<=trans.wr_en;
            intface.wr_data<=trans.wr_data;
            
            @(posedge intface.wr_clk);
            intface.wr_en<=0;
            
            trans_hpnd.wr_hpnd<=1;
        end
    endtask
    
    task read();
        if(trans.inject_rd_rstn) begin
            intface.rd_rstn<=0;
            @(posedge intface.rd_clk);
            intface.rd_rstn<=1;
        end  
        else begin
            @(posedge intface.rd_clk);
            intface.rd_en<=trans.rd_en;
            
            @(posedge intface.rd_clk);
            intface.rd_en<=0;
            
            trans_hpnd.rd_hpnd<=1;
        end
    endtask
    
//    int drv_count;
    
    task main();
        forever begin
            mbx1.get(trans);
            
            trans_hpnd=new();
            
            fork
            
                if(trans.wr_en && !intface.full) begin 
                    write();
                end
                
                if(trans.rd_en && !intface.empty) begin  
                    read();
                end
                
            join
        
            mbx4.put(trans_hpnd);
            ->signals_applied;
            @(posedge intface.wr_clk);
            ->one_cycle_done;
            
        end
    endtask

endclass
