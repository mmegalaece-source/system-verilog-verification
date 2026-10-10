class generator;
  transaction tr;
  mailbox gen2drv;
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  task run();
    repeat(8)begin
      #1;
    tr=new();
      tr.randomize();
      gen2drv.put(tr);
      $display("a=%0b,b=%0b,c=%0b",tr.a,tr.b,tr.c);
    end
  endtask
endclass
    
