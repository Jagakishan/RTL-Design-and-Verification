`timescale 1ns / 1ns

`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

module tb();

    uart_if intface();
    
    generator gen;
    driver drv;
    monitor mon;
    scoreboard sco;
    
    mailbox #(transaction) mbx;
    mailbox #(transaction) exp_mbx;
    mailbox #(transaction) act_mbx;
    
    event one_cycle_done;
    event all_done;
    
    uart_top dut(.clk(intface.clk), .rst(intface.rst), .tx_enable(intface.tx_enable), .rx_enable(intface.rx_enable), .valid(intface.valid), .input_data(intface.input_data), .output_data(intface.output_data));
    
    always #10 intface.clk=~intface.clk;
    
    
    initial begin
        intface.clk=0;
        intface.rst=1;
        #100;
        intface.rst=0;
        intface.tx_enable=1;
        intface.rx_enable=1;
    end
    
    initial begin
        mbx=new();
        exp_mbx=new();
        act_mbx=new();
        
        gen=new(mbx, exp_mbx, one_cycle_done);
        drv=new(mbx, intface, one_cycle_done);
        mon=new(act_mbx, intface);
        sco=new(exp_mbx, act_mbx, all_done);
        
        #100; //Give some time for resetting.
         
        fork
            gen.main();
            drv.main();
            mon.main();
            sco.main();
        join
    end
    
    initial begin
        wait(all_done.triggered);
        $finish;
    end

endmodule