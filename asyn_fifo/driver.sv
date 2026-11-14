class driver;
    virtual asyn_fifo vif;
    mailbox gen2drv;

    function new(virtual asyn_fifo vif, mailbox gen2drv);
        this.vif = vif;
        this.gen2drv = gen2drv;
    endfunction

    task run();
        transaction tr;
        int write_count = 0;
        int read_count  = 0;
        repeat(16) begin
            gen2drv.get(tr);
          
          //write operation
            if (tr.wr_en) begin
                @(negedge vif.wr_clk);
                if (vif.full === 1'b1) begin
                    $display("[ERROR] FIFO FULL before completing 8 writes");
                    vif.wr_en = 0;
                end
                else begin
                    vif.wr_en   = 1;
                    vif.wr_data = tr.wr_data;
                    @(posedge vif.wr_clk);
                    write_count++;
                    $display("[WRITE] DATA=%02h COUNT=%0d",
                             tr.wr_data, write_count);
                    @(negedge vif.wr_clk);
                    vif.wr_en   = 0;
                    vif.wr_data = 0;
                    // CHECK FULL AFTER 8 WRITES
                    if (write_count == 8) begin
                        // Wait for pointer
                        repeat(3) @(posedge vif.wr_clk);
                        #1;
                        if (vif.full === 1'b1)
                $display("[PASS] FIFO FULL CHECK: FULL=1");
                        else 
                          $display("[FAIL] FIFO FULL CHECK: FULL=%b",vif.full);
                    end  
                end
            end

          
          
            // ------------ READ OPERATION ------------
            else if (tr.rd_en) begin
                @(negedge vif.rd_clk);
                if (vif.empty === 1'b1) begin
                    $display("[ERROR] FIFO EMPTY before completing 8 reads");
                    vif.rd_en = 0;
                end
                else begin
                    vif.rd_en = 1;
                    @(posedge vif.rd_clk);
                    read_count++;
                    $display("[READ] COUNT=%0d", read_count);

                    @(negedge vif.rd_clk);
                    vif.rd_en = 0;

                    // CHECK EMPTY AFTER 8 READS
                    if (read_count == 8) begin
                   // Wait for pointer/status updates
                        repeat(3) @(posedge vif.rd_clk);
                        #1;

                        if (vif.empty === 1'b1)
                            $display("[PASS] FIFO EMPTY CHECK: EMPTY=1");
                        else
                            $display("[FAIL] FIFO EMPTY CHECK: EMPTY=%b",
                                     vif.empty);

                    end
                end
            end
        end
    endtask
endclass
