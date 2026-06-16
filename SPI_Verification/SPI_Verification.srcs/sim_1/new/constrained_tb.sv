`timescale 1ns / 1ps

`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"


module constrained_tb;

    spi_if intface();
    
    mailbox #(transaction) mbx1;
    mailbox #(transaction) act_mbx;
    mailbox #(transaction) exp_mbx;
    
    event one_cycle_done;
    event all_cycles_done;
    
    generator gen;
    driver drv;
    monitor mon;
    scoreboard sco;

    top dut(.clk(intface.clk), .rst(intface.rst), .csin(intface.csin), .master_data(intface.master_data), .slave_data(intface.slave_data), 
                    .master_data_register(intface.master_data_register), .slave_data_register(intface.slave_data_register), .valid(intface.valid));
                    
    always #10 intface.clk=~intface.clk;
    
    initial begin
        intface.clk=0;
        intface.rst=1; //Power on reset 
        intface.csin=0;
        #100;
        intface.rst=0;
    end

    initial begin
        mbx1=new();
        act_mbx=new();
        exp_mbx=new();
        
        gen=new(mbx1, exp_mbx, one_cycle_done);
        drv=new(mbx1, intface, one_cycle_done);
        mon=new(act_mbx, intface);
        sco=new(act_mbx, exp_mbx, all_cycles_done);
        
        #100;
        
        fork
            gen.main();
            drv.main();
            mon.main();
            sco.main();
        join
    
    end
    
    initial begin
        wait(all_cycles_done.triggered);
        $finish;
    end

endmodule
