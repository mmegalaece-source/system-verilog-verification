class driver;
  transaction tr;
  virtual counter_inf vif;
  mailbox gen2drv;

  function new(mailbox gen2drv, virtual counter_inf vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction

  task run();
    repeat(10) begin
      gen2drv.get(tr);
      @(negedge vif.clk);
      vif.rst = tr.rst;
      $display("[DRV] rst=%0b", vif.rst);
    end
  endtask
endclass
