   class monitor;
  virtual dff vif;
  transaction tr;
  mailbox mon2scr;
  
  function new(virtual dff vif,mailbox mon2scr);
    this.vif=vif;
    this.mon2scr=mon2scr;
  endfunction
  
  task run();
    repeat (10) begin
    @(posedge vif.clk);
    #1;
    tr = new();
    tr.d   = vif.d;
    tr.rst = vif.rst;
    tr.q   = vif.q;
    mon2scr.put(tr);
    $display("[MON] d=%0b q=%0b rst=%0b",tr.d,tr.q, tr.rst);
  end
  endtask
endclass
