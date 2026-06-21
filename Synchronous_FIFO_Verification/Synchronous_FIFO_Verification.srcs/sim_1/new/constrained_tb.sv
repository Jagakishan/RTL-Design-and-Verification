`timescale 1ns / 1ps

`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"


module constrained_tb;

    mailbox #(transaction) mbx1, mbx2, mbx3;
    
    fifo_if intface();
    
    event one_cycle_done;
    event all_cycles_done;
    event signals_applied;
    
    generator gen;
    monitor mon;
    driver drv;
    scoreboard sco;

    fifo dut(.clk(intface.clk), .rst(intface.rst), .wr(intface.wr), .rd(intface.rd), .write_data(intface.write_data), 
                .read_data(intface.read_data), .full(intface.full), .empty(intface.empty), .underflow(intface.underflow), .overflow(intface.overflow));
                
    always #10 intface.clk=~intface.clk;
    
    initial begin
        mbx1=new();
        mbx2=new();
        mbx3=new();
        
        gen=new(mbx1, one_cycle_done, mbx3);
        drv=new(mbx1, intface, one_cycle_done, signals_applied);
        mon=new(mbx2, intface, signals_applied);
        sco=new(mbx2, all_cycles_done, mbx3);
        
        fork
            gen.main();
            drv.main();
            mon.main();
            sco.main();
        join
    end
    
    initial begin
        intface.clk=0;
        intface.rst=1; //Power on reset kinda thing
        #100;
        intface.rst=0;
    end
    
    initial begin
        wait(all_cycles_done.triggered);
        $finish;
    end
    
endmodule
