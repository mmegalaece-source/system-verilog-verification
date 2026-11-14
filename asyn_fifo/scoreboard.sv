class scoreboard;
    mailbox gen2scr;
    mailbox mon2scr;
    bit [7:0] expected_data;
    bit [7:0] actual_data;
    bit [7:0] expected_q[$];
    int pass_count = 0;
    int fail_count = 0;
    int write_count = 0;
    int read_count = 0;
    bit done = 0;

    function new(mailbox gen2scr, mailbox mon2scr);
        this.gen2scr = gen2scr;
        this.mon2scr = mon2scr;
    endfunction

    task run();
        transaction tr;
        repeat (20) begin
            mon2scr.get(tr);
            // WRITE CHECKING
            if (tr.wr_en == 1'b1 && tr.full == 1'b0) begin
                expected_q.push_back(tr.wr_data);
                write_count++;
                pass_count++;
                $display("[SCOREBOARD] WRITE DATA = %02h",
                         tr.wr_data);
            end

            // FULL CHECKING
            if (tr.full == 1'b1) begin
                if (expected_q.size() == 8) begin
                    $display("[SCOREBOARD] FULL CHECK PASS");
                    pass_count++;
                end
                else begin
                    $display("[SCOREBOARD] FULL CHECK FAIL");
                    fail_count++;
                end
            end

            // READ CHECKING
            if (tr.rd_en == 1'b1 && tr.empty == 1'b0) begin
                if (expected_q.size() > 0) begin
                    expected_data = expected_q.pop_front();
                    actual_data = tr.rd_data;
                    read_count++;
                    if (actual_data === expected_data) begin
                      $display("[SCOREBOARD] READ PASS expected=%02h actual=%02h",expected_data, actual_data);
                      pass_count++;
                    end
                    else begin
                        $display("[SCOREBOARD] READ FAIL expected=%02h actual=%02h",expected_data, actual_data);
                        fail_count++;
                    end
                end
                else begin
                    $display("[SCOREBOARD] ERROR: UNEXPECTED READ");
                    fail_count++;
                end
            end

            // EMPTY CHECKING
            if (tr.empty == 1'b1) begin
                if (expected_q.size() == 0) begin
                    $display("[SCOREBOARD] EMPTY CHECK PASS");
                    pass_count++;
                end
                else begin
                    $display("[SCOREBOARD] EMPTY CHECK FAIL");
                    fail_count++;
                end
            end
        end

        // FINAL REPORT
        $display("--------------------------------");
        $display("FIFO VERIFICATION");
        $display("TOTAL WRITES = %0d", write_count);
        $display("TOTAL READS = %0d", read_count);
        $display("PASS COUNT = %0d", pass_count);
        $display("FAIL COUNT = %0d", fail_count);

        if (fail_count == 0)
            $display("FIFO VERIFICATION PASSED");
        else
            $display("FIFO VERIFICATION FAILED");
        done = 1;
    endtask
endclass
