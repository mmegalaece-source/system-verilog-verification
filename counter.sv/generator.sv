class generator;
  transaction tr;
  mailbox gen2drv;
  
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  
  task run();
    repeat(5)begin 
      tr=new();
      tr.randomize();
      gen2drv.put(tr);
      $display("[GEN] rst=%0b ",tr.rst);
    end
  endtask
endclass
