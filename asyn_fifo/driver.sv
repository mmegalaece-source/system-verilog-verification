class driver;
    virtual asyn_fifo vif;
    mailbox gen2drv;
    function new(
        virtual asyn_fifo vif,
        mailbox gen2drv
    );
        this.vif = vif;
        this.gen2drv = gen2drv;
    endfunction
    task run();
        transaction tr;
        forever begin
          gen2drv.get(tr);
            // WRITE OPERATION
            if (tr.wr_en) begin
                @(negedge vif.wr_clk);
                while (vif.full !== 1'b0)
                    @(negedge vif.wr_clk);
                vif.wr_en = 1;
                vif.wr_data = tr.wr_data;
                $display("[DRIVER] WRITE time=%0t data=%02h",$time, tr.wr_data);
                @(negedge vif.wr_clk);
                vif.wr_en = 0;
                vif.wr_data = 0;
            end
            // READ OPERATION
            else if (tr.rd_en) begin
                @(negedge vif.rd_clk);
                while (vif.empty !== 1'b0)
                    @(negedge vif.rd_clk);
                vif.rd_en = 1;
                $display("[DRIVER] READ REQUEST time=%0t",$time);
                @(negedge vif.rd_clk);
                vif.rd_en = 0;
            end
        end
    endtask
endclass
