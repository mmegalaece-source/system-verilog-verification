class scoreboard;
    mailbox gen2scr;
    mailbox mon2scr;
    bit [7:0] expected_data;
    bit [7:0] actual_data;
    bit [7:0] expected_q[$];
    int pass_count = 0;
    int fail_count = 0;
    bit done = 0;
    function new(
      mailbox  gen2scr,
      mailbox mon2scr
    );
        this.gen2scr = gen2scr;
        this.mon2scr = mon2scr;
    endfunction
    task run();
        // Collect expected write data
        repeat (8) begin
            gen2scr.get(expected_data);
            expected_q.push_back(expected_data);
        end
        // Compare read data
        repeat (8) begin
            mon2scr.get(actual_data);
            expected_data = expected_q.pop_front();
            if (actual_data === expected_data) begin
                pass_count++;
                $display("[SCOREBOARD] PASS expected=%02h actual=%02h",
                         expected_data, actual_data);
            end
            else begin
                fail_count++;
                $display("[SCOREBOARD] FAIL expected=%02h actual=%02h",expected_data, actual_data);
            end
        end
        $display("VERIFICATION COMPLETED");
        done = 1;
    endtask
endclass
