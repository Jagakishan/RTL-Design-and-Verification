`timescale 1ns / 1ps


class scoreboard;
    
    transaction trans, control_trans;
    
    mailbox #(transaction) mbx2, mbx3;
    
    bit [7:0] q[$];
    
    event all_cycles_done;
    
    bit [7:0] expected;
    
    int total_reads=0, failed_reads=0;
    int total_writes=0;
    int total_simultaneous=0;
    int numOverflow=0, numUnderflow=0;
    int numReset=0;
    int total_count=0;
    
    function new(input mailbox #(transaction) mbx2, input event all_cycles_done, input mailbox #(transaction) mbx3);
        this.mbx2=mbx2;
        this.all_cycles_done=all_cycles_done;
        this.mbx3=mbx3;
    endfunction
    
    task main();
        forever begin
            mbx3.get(control_trans);
            mbx2.get(trans);
            
            total_count++;
            
            if((q.size()==`DEPTH) && control_trans.wr && control_trans.rd) begin
                total_reads++;
                total_writes++;
                total_simultaneous++;
                
                q.push_back(trans.write_data);
                expected = q.pop_front();
                
                if(expected == trans.read_data); //$display("PASS");
                else begin
                    $display("FAIL. EXPECTED = %h, RECEIVED = %h", expected, trans.read_data);
                    failed_reads++;
                end
            end
            else begin
                if(control_trans.wr && (q.size()!=`DEPTH)) begin
                    q.push_back(trans.write_data);
                    total_writes++;
                end
                if(control_trans.rd && (q.size()!=0)) begin
                    total_reads++;
                    
                    expected = q.pop_front();
                    
                    if(expected == trans.read_data); //$display("PASS");
                    else begin
                        $display("FAIL. EXPECTED = %h, RECEIVED = %h", expected, trans.read_data);
                        failed_reads++;
                    end
                end
            end
            
            if((q.size()==0) && control_trans.rd) begin
                numUnderflow++;
            end
            
            if((q.size()==`DEPTH) && control_trans.wr && !control_trans.rd) begin
                numOverflow++;
            end
            
            if(control_trans.inject_rst) begin
                numReset++;
            end
            
            assert((q.size()==0)==trans.empty) else $error("EMPTY FLAG ERROR");
            
            if(total_count == 1000) begin
                $display("");
                $display("SCOREBOARD RESULT & COVERAGE");
                $display("TOTAL ITERATIONS: %0d", total_count);
                $display("TOTAL WRITES: %0d", total_writes);
                $display("TOTAL READS: %0d", total_reads);
                $display("SIMULTANEOUS READ AND WRITE: %0d", total_simultaneous);
                $display("OVERFLOW CASES: %0d", numOverflow);
                $display("UNDERFLOW CASES: %0d", numUnderflow);
                $display("RESET CASES: %0d", numReset);
                $display("SUCCESS:FAILURE :: %0d:%0d",
                         total_reads - failed_reads,
                         failed_reads);
                         
                         
                ->all_cycles_done;
            end
        end
    endtask


endclass
