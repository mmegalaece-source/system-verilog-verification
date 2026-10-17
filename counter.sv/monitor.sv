class monitor;
  virtual counter_inf vif;
  transaction tr;
  mailbox mon2scr;

  function new(virtual counter_inf vif, mailbox mon2scr);
    this.vif = vif;
    this.mon2scr = mon2scr;
  endfunction

  task run();
    repeat(5) begin
      @(posedge vif.clk);
      #1;

      tr = new();
      tr.rst = vif.rst;
      tr.count = vif.count;

      mon2scr.put(tr);

      $display("[MON] rst=%0b count=%0d",
               tr.rst, tr.count);
    end
  endtask
endclass
