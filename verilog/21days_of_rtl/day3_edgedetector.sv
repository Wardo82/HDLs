 // An edge detector

module day3 (
  input     wire    clk,
  input     wire    reset,

  input     wire    a_i,

  output    wire    rising_edge_o,
  output    wire    falling_edge_o
);

  logic signalPrev;

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      signalPrev <= 0;
    end else begin
      signalPrev <= a_i;
    end
  end
  assign rising_edge_o  = (a_i && !signalPrev);  
  assign falling_edge_o  = (!a_i && signalPrev);
  
endmodule
