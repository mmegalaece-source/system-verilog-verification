class scoreboard;
  bit exp_sum;
  bit exp_carry;
  transaction tr;
  mailbox mon2scr;
  function new(mailbox mon2scr);
    this.mon2scr = mon2scr;
  endfunction
  task run();
    repeat (8) begin
      mon2scr.get(tr);
      exp_sum = tr.a ^ tr.b ^ tr.c;
      exp_carry = (tr.a & tr.b)|(tr.b & tr.c)|(tr.c & tr.a);
      if ((tr.sum === exp_sum) &&
          (tr.carry === exp_carry)) begin
        $display("PASS: a=%0b b=%0b c=%0b sum=%0b carry=%0b",tr.a, tr.b, tr.c, tr.sum, tr.carry);
      end
      else begin
        $display("FAIL: a=%0b b=%0b c=%0b sum=%0b carry=%0b",tr.a, tr.b, tr.c, tr.sum, tr.carry);
        $display("Expected: sum=%0b carry=%0b",
                 exp_sum, exp_carry);
      end
    end
  endtask
endclass
