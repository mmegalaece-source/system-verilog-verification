`include "interface.sv"
`include "transaction"
`include "generator"
`include "driver"
`include "monitor"
`include "agent"
`include "scoreboard"
`include "environment"

module tb;
  environment env;
  counter_inf vif();

  counter d1(
    .clk(vif.clk),
    .rst(vif.rst),
    .count(vif.count)
  );

  initial vif.clk = 0;
  always #5 vif.clk = ~vif.clk;

  initial begin
    env = new(vif);
    env.run();
    $display("All transactions completed");
    $finish;
  end
endmodule
