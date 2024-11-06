// Binary to gray code

module day9 #(
  parameter VEC_W = 4
)(
  input     wire[VEC_W-1:0] bin_i,
  output    wire[VEC_W-1:0] gray_o

);

  logic[VEC_W-1:0] gray;
  assign gray_o = gray;

  always_comb begin
    // Initialize one-hot output to 0
    gray[VEC_W-1] = bin_i[VEC_W-1];
    
    for (int i=VEC_W-2; i >= 0; i--) begin
      gray[i] = bin_i[i] ^ bin_i[i+1];
    end
  end
endmodule
