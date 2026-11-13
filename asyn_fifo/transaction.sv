class transaction;
    rand bit wr_en;
    rand bit rd_en;
    rand logic [7:0] wr_data;
    bit rst_n;
    logic [7:0] rd_data;
    bit full, empty;
endclass
