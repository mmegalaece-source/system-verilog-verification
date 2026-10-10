class driver ;
  virtual fa vif;
  transaction tr;
  mailbox gen2drv;
  function new(mailbox gen2drv,virtual fa vif);
    this.vif=vif;
    this.gen2drv=gen2drv;
  endfunction
  
  task run();     
    repeat(8)begin
      gen2drv.get(tr);
      @(negedge vif.clk);
      vif.a=tr.a;
      vif.b=tr.b;
      vif.c=tr.c;
      $display("[DRV] a=%0b b=%0b c=%0b",vif.a, vif.b, vif.c);
      
    end
  endtask
endclass
      
