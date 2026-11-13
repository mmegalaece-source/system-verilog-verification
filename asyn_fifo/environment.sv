class environment;
    virtual asyn_fifo vif;
    mailbox gen2drv;
    mailbox gen2scr;
    mailbox mon2scr;
    generator gen;
    driver drv;
    monitor mon;
    scoreboard sb;
    function new(virtual asyn_fifo vif);
        this.vif = vif;
        gen2drv = new();
        gen2scr = new();
        mon2scr = new();
      gen = new(gen2drv, gen2scr);
      drv = new(vif, gen2drv);
      mon = new(vif, mon2scr);
      sb = new(gen2scr, mon2scr);
    endfunction
    task run();
        fork
            gen.run();
            drv.run();
            mon.run();
            sb.run();
        join_none
        wait(sb.done == 1);
        $display("[ENVIRONMENT] TEST COMPLETED");
    endtask
endclass
