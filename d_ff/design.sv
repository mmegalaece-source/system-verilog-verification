module d_ff(
  input d,
  input clk,
  input rst,
  output reg q);
  always @(posedge clk) begin
    if (rst)
      q <= 0;
    else
      q <= d;
  end
endmodule
