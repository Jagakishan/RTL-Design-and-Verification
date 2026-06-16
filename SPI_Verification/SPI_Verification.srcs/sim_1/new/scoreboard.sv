`timescale 1ns / 1ps


class scoreboard;

    transaction act, exp;

    mailbox #(transaction) act_mbx;
    mailbox #(transaction) exp_mbx;
    
    event all_cycles_done;
    
    int unsigned pass_count=0;
    int unsigned total_count=0;
    
    function new(input mailbox #(transaction) act_mbx, input mailbox #(transaction) exp_mbx, input event all_cycles_done);
        this.act_mbx=act_mbx;
        this.exp_mbx=exp_mbx;
        this.all_cycles_done=all_cycles_done;
    endfunction 
    
    task main();
        forever begin
            exp_mbx.get(exp);
            act_mbx.get(act);
            
            total_count++;
            
            if((exp.master_data==act.slave_data_register) && (exp.slave_data==act.master_data_register))begin
                pass_count++;
            end
            
            if(total_count==256) begin
                $display("Total: %0d\tMatch: %0d\tFail: %0d", total_count, pass_count, total_count-pass_count);
                ->all_cycles_done;
            end
        end
    endtask
endclass
