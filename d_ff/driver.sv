class driver;
  virtual dff vif;
  transaction tr;
  mailbox gen2drv;

  function new(mailbox gen2drv, virtual dff vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction

  task run();
    repeat (10) begin
      gen2drv.get(tr);
      @(negedge vif.clk);
      vif.d = tr.d;
      vif.rst=tr.rst;
      $display("[DRV] d=%0b  rst=%0b",vif.d,vif.rst);
               
    end
  endtask
endclass
