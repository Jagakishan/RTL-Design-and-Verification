`timescale 1ns / 1ps

`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

module constrained_tb;
    
    mailbox #(transaction) mbx1, mbx2, mbx3, mbx4;
    
    fifo_if intface();
    
    event one_cycle_done;
    event all_cycles_done;
    event signals_applied;
    
    generator gen;
    monitor mon;
    driver drv;
    scoreboard sco;
    
     fifo dut(.wr_clk(intface.wr_clk), .rd_clk(intface.rd_clk), .wr_en(intface.wr_en), .rd_en(intface.rd_en), .wr_rstn(intface.wr_rstn), .rd_rstn(intface.rd_rstn), 
                                    .wr_data(intface.wr_data), .full(intface.full), .empty(intface.empty), .rd_data(intface.rd_data)); 
                                    
     always #10 intface.wr_clk=~intface.wr_clk; 
     always #20 intface.rd_clk=~intface.rd_clk; //Works for any clock ratio or difference between the 2 domains
     
     initial begin
        mbx1=new();
        mbx2=new();
        mbx3=new();
        mbx4=new();
        
        gen=new(mbx1, one_cycle_done, mbx3);
        drv=new(mbx1, intface, one_cycle_done, signals_applied, mbx4);
        mon=new(mbx2, intface, signals_applied);
        sco=new(mbx2, all_cycles_done, mbx3, mbx4);
        
        fork
            gen.main();
            drv.main();
            mon.main();
            sco.main();
        join            
     end
     
     initial begin
        //Power on reset
        intface.wr_clk=0;
        intface.rd_clk=0;
        intface.wr_rstn=0;
        intface.rd_rstn=0;
        #100;
        intface.wr_rstn=1;
        intface.rd_rstn=1;
    end
     
     initial begin
        wait(all_cycles_done.triggered);
        $finish;     
     end

endmodule
