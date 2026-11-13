interface asyn_fifo;
    logic wr_clk;
    logic rd_clk;
    logic rst_n;
    logic wr_en;
    logic rd_en;
    logic [7:0] wr_data;
    logic [7:0] rd_data;
    logic full;
    logic empty;
endinterface
