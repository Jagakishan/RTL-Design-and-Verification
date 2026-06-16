`timescale 1ns / 1ps


class transaction;

    bit rst;
    bit csin;
    rand bit [7:0] master_data, slave_data;
    bit [7:0] master_data_register, slave_data_register;
    bit valid;
    
    rand bit inject_rst;
    
    function transaction copy();
        copy=new();
        
        copy.rst=this.rst;
        copy.csin=this.csin;
        copy.master_data=this.master_data;
        copy.slave_data=this.slave_data;
        copy.master_data_register=this.master_data_register;
        copy.slave_data_register=this.slave_data_register;
        copy.valid=this.valid;
        copy.inject_rst=this.inject_rst;
    endfunction
    
    constraint c_rst {
        inject_rst dist {0 := 90, 1 := 10};
    } 

    constraint idle_test{
        master_data dist {8'h00:/50, [8'h01:8'hff]:/50};
    }
    
    constraint force_slave_zero{
        (master_data==8'h00) -> (slave_data==8'h00);
    }

endclass
