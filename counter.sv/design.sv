// Code your design here
module counter (
    input logic clk,
    input logic rst,
  output logic [3:0] count);
 always @(posedge clk) begin
        if (rst)
            count <= 4'd0;
        else
            count <= count + 1'b1;
    end
endmodule
