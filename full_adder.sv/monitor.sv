class monitor;
  virtual fa vif;
  transaction tr;
  mailbox mon2scr;
  function new(virtual fa vif,mailbox mon2scr);
    this.vif=vif;
    this.mon2scr=mon2scr;
  endfunction
  task run();
    repeat(8)begin
    #3;
    tr=new();
    tr.a=vif.a;
     tr.b=vif.b;
     tr.c=vif.c;
     tr.sum=vif.sum;
     tr.carry=vif.carry;
    mon2scr.put(tr);
    end
  endtask
endclass
    
