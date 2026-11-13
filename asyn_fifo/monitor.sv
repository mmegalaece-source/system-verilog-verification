class monitor;

    virtual asyn_fifo vif;
    mailbox mon2scr;
    function new(
        virtual asyn_fifo vif,
      mailbox mon2scr
    );
        this.vif = vif;
        this.mon2scr = mon2scr;
    endfunction
    task run();
        forever begin
            @(posedge vif.rd_clk);
            if (vif.rst_n && vif.rd_en && !vif.empty) begin
                #1;
                mon2scr.put(vif.rd_data);
                $display("[MONITOR] READ DATA = %02h",vif.rd_data);
            end
        end
    endtask
endclass
