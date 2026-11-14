
class monitor;
    virtual asyn_fifo vif;
    mailbox mon2scr;

  function new(virtual asyn_fifo vif,mailbox mon2scr);
        this.vif = vif;
        this.mon2scr = mon2scr;
    endfunction

    // WRITE MONITOR
    task write_monitor();
        transaction tr;
        forever begin
            @(posedge vif.wr_clk);
            if (vif.wr_en && !vif.full) begin
                tr = new();
                tr.wr_en   = 1;
                tr.rd_en   = 0;
                tr.wr_data = vif.wr_data;
                tr.full    = vif.full;
                mon2scr.put(tr);
                $display("[MONITOR] WRITE DATA = %02h",
                         tr.wr_data);
            end
        end
    endtask


    // READ MONITOR
    task read_monitor();
        transaction tr;
      forever begin
            @(posedge vif.rd_clk);
            if (vif.rd_en && !vif.empty) begin
                tr = new();
                tr.wr_en = 0;
                tr.rd_en = 1;
                tr.empty = vif.empty;
                #1;
                tr.rd_data = vif.rd_data;
                mon2scr.put(tr);
                $display("[MONITOR] READ DATA = %02h",
                         tr.rd_data);
            end
        end
    endtask
    task run();
        fork
            write_monitor();
            read_monitor();
        join
    endtask
endclass
