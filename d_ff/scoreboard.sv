class scoreboard;
  logic exp_q;
  transaction tr;
  mailbox mon2scr;

  function new(mailbox mon2scr);
    this.mon2scr = mon2scr;
    exp_q = 0;
  endfunction

  task run();
    repeat (10) begin
      mon2scr.get(tr);

      if (tr.rst)
        exp_q = 0;
      else
        exp_q = tr.d;

      if (tr.q === exp_q) begin
        $display("PASS: rst=%0b d=%0b q=%0b",tr.rst, tr.d, tr.q);
      end
      else begin
        $display("FAIL: rst=%0b d=%0b q=%0b",tr.rst, tr.d, tr.q);
        $display("EXPECTED: q=%0b", exp_q);
      end
    end
  endtask
endclass
