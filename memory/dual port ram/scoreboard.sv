class scoreboard #(parameter width=8, parameter depth=8);
  transaction #(8,8) trans;
  mailbox mon2scb;
  // Reference memory
  logic [width-1:0] refmem [depth-1:0];
  // Expected output
  logic [width-1:0] expected_A, expected_B;
  // Constructor
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
    expected_A = '0;
    expected_B = '0;
    for(int i=0; i<depth; i++) begin
      refmem[i] = '0;
    end
  endfunction
 
  task run();
    repeat (10) begin
      mon2scb.get(trans);
      if(trans.rst) begin
        for(int i=0; i<depth; i++) begin
          refmem[i] = '0;
        end
        expected_A = '0;
        expected_B = '0;
      end
      else begin
        // Port A read operation
        if(!trans.we_a) begin
          expected_A = refmem[trans.addrA];
        end

        // Port B read operation
        if(!trans.we_b) begin
          expected_B = refmem[trans.addrB];
        end

        // Both ports write
        if(trans.we_a && trans.we_b) begin

          // Check address collision
          if(trans.addrA != trans.addrB) begin
            refmem[trans.addrA] = trans.data_inA;
            refmem[trans.addrB] = trans.data_inB;
          end
          else begin
            $display("[INFO] Write collision at address %0d",trans.addrA);
          end
        end
        // Only Port A writes
        else if(trans.we_a) begin
          refmem[trans.addrA] = trans.data_inA;
        end
        // Only Port B writes
        else if(trans.we_b) begin
          refmem[trans.addrB] = trans.data_inB;
        end
      end
      // Port A comparison
      if(expected_A === trans.data_outA) begin
        $display("[PASS] Port A Expected=%h Actual=%h",
                 expected_A, trans.data_outA);
      end
      else begin
        $display("[FAIL] Port A Expected=%h Actual=%h",
                 expected_A, trans.data_outA);
      end
      // Port B comparison
      if(expected_B === trans.data_outB) begin
        $display("[PASS] Port B Expected=%h Actual=%h",
                 expected_B, trans.data_outB);
      end
      else begin
        $display("[FAIL] Port B Expected=%h Actual=%h",
                 expected_B, trans.data_outB);
      end
    end
  endtask
endclass
