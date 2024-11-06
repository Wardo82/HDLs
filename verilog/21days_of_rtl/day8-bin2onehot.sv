// Binary to one-hot

module day8#(
  parameter BIN_W       = 4,
  parameter ONE_HOT_W   = 16
)(
  input   wire[BIN_W-1:0]     bin_i,
  output  wire[ONE_HOT_W-1:0] one_hot_o
);
  logic[ONE_HOT_W-1:0] one_hot;
  assign one_hot_o = one_hot;

  always_comb begin
    // Initialize one-hot output to 0
    one_hot = 0;
    
    // Set the bit at the position specified by the binary input
    one_hot[bin_i] = 1;
  end
  
endmodule
