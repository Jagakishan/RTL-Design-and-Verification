`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 32
`define ADDR_WIDTH $clog2(`DEPTH)
                                    
class transaction;
    
    rand bit wr_en, rd_en;
    bit wr_rstn, rd_rstn;
    rand bit [`DATA_WIDTH-1:0] wr_data;
    bit full, empty;
    bit [`DATA_WIDTH-1:0] rd_data;
    
    bit inject_wr_rstn, inject_rd_rstn;

    bit wr_hpnd, rd_hpnd;
    
    function transaction copy();
        copy=new();
        
        copy.wr_en=this.wr_en;
        copy.rd_en=this.rd_en;
        copy.wr_rstn=this.wr_rstn;
        copy.rd_rstn=this.rd_rstn;
        copy.wr_data=this.wr_data;
        copy.rd_data=this.rd_data;
        copy.full=this.full;
        copy.empty=this.empty;
        copy.inject_wr_rstn=this.inject_wr_rstn;
        copy.inject_rd_rstn=this.inject_rd_rstn;
    endfunction
    
//    constraint c_rstn{
//        inject_wr_rstn dist {1:=90, 0:=10};
//        inject_rd_rstn dist {1:=90, 0:=10};
//    }
    

endclass
