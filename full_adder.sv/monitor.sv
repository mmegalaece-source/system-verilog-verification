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
      @(negedge vif.clk);
    #1;
    tr=new();
    tr.a=vif.a;
     tr.b=vif.b;
     tr.c=vif.c;
     tr.sum=vif.sum;
     tr.carry=vif.carry;
    mon2scr.put(tr);
       $display("[MON] a=%0b b=%0b c=%0b sum=%0b carry=%0b",tr.a,tr.b,tr.c,tr.sum,tr.carry);
    end
  endtask
endclass
    
