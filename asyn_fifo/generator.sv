class generator;
  mailbox gen2drv;   //Sends transactions to the Driver.
  mailbox gen2scr;   //Sends expected write data to the Scoreboard.
    function new(
        mailbox gen2drv,
        mailbox gen2scr
    );
        this.gen2drv = gen2drv;
        this.gen2scr = gen2scr;
    endfunction
    task run();
        transaction tr;
      //write transaction
        for (int i = 0; i < 8; i++) begin
            tr = new();
            tr.wr_en = 1;
            tr.rd_en = 0;
            tr.wr_data = 8'hA0 + i;
            gen2drv.put(tr);
            gen2scr.put(tr.wr_data);
            $display("[GENERATOR] WRITE DATA = %02h",tr.wr_data);
        end
      //read transaction
        for (int i = 0; i < 8; i++) begin
            tr = new();
            tr.wr_en = 0;
            tr.rd_en = 1;
            tr.wr_data = 0;
            gen2drv.put(tr);
            $display("[GENERATOR] READ REQUEST");
        end
    endtask
endclass
