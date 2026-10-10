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
      #2;
      gen2drv.get(tr);
      vif.a=tr.a;
      vif.b=tr.b;
      vif.c=tr.c;
      
    end
  endtask
endclass
      
