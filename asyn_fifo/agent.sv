class agent;
    virtual asyn_fifo vif;
    mailbox gen2drv;
    mailbox #(bit [7:0]) read_mbx;
    driver drv;
    monitor mon;
    function new(virtual asyn_fifo vif);
        this.vif = vif;
        gen2drv = new();
        read_mbx = new();
      drv = new(vif, gen2drv);
        mon = new(vif, read_mbx);
    endfunction
    task run();
        fork
            drv.run();
            mon.run();
        join_none
    endtask
endclass
