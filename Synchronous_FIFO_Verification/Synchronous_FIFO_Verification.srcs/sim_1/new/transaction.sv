`timescale 1ns / 1ps

`define DATA_WIDTH 8
`define DEPTH 32 //Make sure the DEPTH is a power of 2


class transaction;
    bit rst;
    rand bit wr, rd;
    rand bit [`DATA_WIDTH-1:0] write_data;
    bit [`DATA_WIDTH-1:0] read_data;
    bit full, empty, underflow, overflow;
    
    rand bit inject_rst;
    
    function transaction copy();
        copy=new();
        
        copy.rst=this.rst;
        copy.wr=this.wr;
        copy.rd=this.rd;
        copy.write_data=this.write_data;
        copy.read_data=this.read_data;
        copy.full=this.full;
        copy.empty=this.empty;
        copy.underflow=this.underflow;
        copy.overflow=this.overflow;
        copy.inject_rst=this.inject_rst;
    endfunction
    
    constraint c_rst{
        inject_rst dist {0 := 90, 1 := 10};
    } 
    
    constraint c1{
        wr || rd;
    }
    
endclass
