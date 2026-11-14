class generator;
  transaction trans;
  mailbox gen2drv;
  
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  
  task run();
    for(int i=0; i<10;i++)begin
      trans=new();
      if(!trans.randomize())
        $display("Randomization failed");
      else begin
        if(i==0)
          trans.rst=1;
        else
          trans.rst=0;
        $display("Randomization success");
         $display("[GEN] rst=%b, we_a=%b, we_b=%b, addrA=%b, addrB=%b, data_inA=%b, data_inB=%b",
          trans.rst, trans.we_a, trans.we_b,
          trans.addrA, trans.addrB,
          trans.data_inA, trans.data_inB);
        gen2drv.put(trans);
      end
    end
  endtask
endclass
