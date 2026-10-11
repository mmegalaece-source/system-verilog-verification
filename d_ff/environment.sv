class environment;
  agent agt;
  scoreboard scb;
  mailbox mon2scr;
  virtual dff vif;
  
  function new(virtual dff vif);
    this.vif = vif;
    mon2scr = new();
    agt = new(vif, mon2scr);
    scb = new(mon2scr);
  endfunction
  task run();
    fork
      agt.run();
      scb.run();
    join
  endtask
endclass
