`timescale 1ns / 1ps

class scoreboard;
    
    int unsigned pass_count=0, fail_count=0;
    int unsigned total_count=0;
    
    mailbox #(transaction) act_mbx;
    mailbox #(transaction) exp_mbx;
    
    transaction exp, act;
    
    event all_done;
    
    function new(mailbox #(transaction) exp_mbx, mailbox #(transaction) act_mbx, event all_done);
        this.exp_mbx=exp_mbx;
        this.act_mbx=act_mbx;
        this.all_done=all_done;
    endfunction
    
    task main();
        forever begin
            exp_mbx.get(exp);
            
            act_mbx.get(act);
            
            total_count++;
            
            if(exp.input_data==act.output_data) begin
                $display("OUTPUT MATCHES INPUT %0h==%0h", exp.input_data, act.output_data);
                pass_count++;
            end else begin
                    $display("TASK FAILED %0h!=%0h", exp.input_data, act.output_data);
                    fail_count++;
            end
            
            if(total_count==256)begin
                $display("=================\n PASS=%0d \n FAIL=%0d \n=================", pass_count, fail_count);
                 ->all_done;
            end
        end
    
    endtask
    

endclass
