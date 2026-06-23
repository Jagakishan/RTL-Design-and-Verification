`timescale 1ns / 1ps


class scoreboard;
    
    transaction trans, control_trans, trans_hpnd;
    
    mailbox #(transaction) mbx2, mbx3, mbx4;
    
    bit [`DEPTH:0] q[$];
    
    event all_cycles_done;
    
    bit [7:0] expected;
    
    function new(input mailbox #(transaction) mbx2, input event all_cycles_done, input mailbox #(transaction) mbx3, input mailbox #(transaction) mbx4);
        this.mbx2=mbx2;
        this.all_cycles_done=all_cycles_done;
        this.mbx3=mbx3;
        this.mbx4=mbx4;
    endfunction
    
    int total_reads=0;
    int failed_reads=0;
    int total_writes=0;
    int total_simultaneous=0;
    int numOverflow=0, numUnderflow=0;
    int total_count=0;
    
    task main();
        forever begin
            mbx3.get(control_trans);
            mbx4.get(trans_hpnd);
            mbx2.get(trans);
            
            total_count++;
            
            if(trans_hpnd.wr_hpnd) begin // control_trans.wr_en && (q.size()!=`DEPTH)
                q.push_back(trans.wr_data);
                total_writes++;
            end
            
            if(trans_hpnd.rd_hpnd) begin // control_trans.rd_en && (q.size()!=0)
                total_reads++;
                    
                expected = q.pop_front();
                
                if(expected == trans.rd_data) $display("PASS, EXPECTED = %h, RECEIVED = %h", expected, trans.rd_data);
                else begin
                    $display("FAIL. EXPECTED = %h, RECEIVED = %h", expected, trans.rd_data);
                    failed_reads++;
                end
            end
            
            if((q.size()==0) && control_trans.rd_en) begin
                numUnderflow++;
            end
            
            if((q.size()==`DEPTH) && control_trans.wr_en) begin
                numOverflow++;
            end
            
            if(control_trans.rd_en && control_trans.wr_en) begin
                total_simultaneous++;
            end
            
            assert((q.size()==0)==trans.empty) else $error("EMPTY FLAG ERROR");
            assert((q.size()==`DEPTH)==trans.full) else $error("FULL FLAG ERROR");
            
            if(total_count == 1000) begin
                $display("");
                $display("SCOREBOARD RESULT & COVERAGE");
                $display("TOTAL ITERATIONS: %0d", total_count);
                $display("TOTAL WRITES: %0d", total_writes);
                $display("TOTAL READS: %0d", total_reads);
                $display("SIMULTANEOUS READ AND WRITE: %0d", total_simultaneous);
                $display("OVERFLOW CASES: %0d", numOverflow);
                $display("UNDERFLOW CASES: %0d", numUnderflow);
                $display("SUCCESS:FAILURE :: %0d:%0d", total_reads - failed_reads, failed_reads);
                         
                ->all_cycles_done;
            end
        end
    endtask
    
    
endclass