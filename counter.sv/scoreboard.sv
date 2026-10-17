class scoreboard;
  bit[3:0]exp_count;
  transaction tr;
  mailbox mon2scr;
  
  function new(mailbox mon2scr);
    this.mon2scr=mon2scr;
  endfunction
  
  task run();
    repeat(5)begin
      mon2scr.get(tr);
      if(tr.rst)
        exp_count=0;
      else
        exp_count=exp_count+1'b1;
      
      $display("count = %0d",exp_count);
      if(exp_count == tr.count)
        
        $display("Verification is passed");
      else
        $display("Verification is failed");
      
      end
  endtask
endclass
  
