class agent;
  generator gen;
  driver drv;
  monitor mon;

  mailbox gen2drv;
  mailbox mon2scr;
  virtual dff vif;

  function new(virtual dff vif, mailbox mon2scr);
    this.vif = vif;
    this.mon2scr = mon2scr;
    gen2drv = new();
    gen = new(gen2drv);
    drv = new(gen2drv, vif);
    mon = new(vif, mon2scr);
  endfunction

  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
    join
  endtask
endclass
