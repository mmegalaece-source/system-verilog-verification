module fifo_memory #(
    parameter data_width = 8,
    parameter addr_width = 3
)(
    input wr_clk,
    input rd_clk,
    input wr_en,
    input rd_en,
    input [addr_width-1:0] wr_addr,
    input [addr_width-1:0] rd_addr,
    input [data_width-1:0] wr_data,
    output reg [data_width-1:0] rd_data
);

    reg [data_width-1:0] memory [0:(1<<addr_width)-1];

    // Write operation
    always @(posedge wr_clk) begin
        if (wr_en) begin
            memory[wr_addr] <= wr_data;
            $display("[DUT WRITE] ADDR=%0d DATA=%02h",wr_addr, wr_data);
        end
    end

    // Read operation
    always @(posedge rd_clk) begin
        if (rd_en) begin
            rd_data <= memory[rd_addr];
          $display("[DUT READ] ADDR=%0d DATA=%02h",rd_addr, memory[rd_addr]);
        end
    end
endmodule
