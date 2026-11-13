`timescale 1ns/1ps

`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module testbench;
    asyn_fifo vif();
    environment env;
    async_fifo #(
        .data_width(8),
        .addr_width(3)
    ) dut (
        .wr_clk(vif.wr_clk),
        .rd_clk(vif.rd_clk),
        .rst_n(vif.rst_n),
        .wr_en(vif.wr_en),
        .rd_en(vif.rd_en),
        .wr_data(vif.wr_data),
        .rd_data(vif.rd_data),
        .full(vif.full),
        .empty(vif.empty)
    );
    initial begin
        vif.wr_clk = 0;
        forever #5 vif.wr_clk = ~vif.wr_clk;
    end
    initial begin
        vif.rd_clk = 0;
        forever #7 vif.rd_clk = ~vif.rd_clk;
    end
    initial begin
        vif.rst_n = 0;
        vif.wr_en = 0;
        vif.rd_en = 0;
        vif.wr_data = 0;
        repeat (3) @(negedge vif.wr_clk);
        vif.rst_n = 1;
        $display("--------------------------------");
        $display("RESET RELEASED");
        $display("FULL = %b EMPTY = %b",
                 vif.full, vif.empty);
        $display("--------------------------------");
        env = new(vif);
        env.run();
        #20;
        $finish;
    end
    initial begin
        $dumpfile("async_fifo.vcd");
        $dumpvars(0, testbench);
    end
    initial begin
        #5000;
        $fatal(1, "ERROR: Simulation timeout");
    end
endmodule
