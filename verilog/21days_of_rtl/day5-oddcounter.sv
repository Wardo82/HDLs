// Odd counter

module day5 (
  input     wire        clk,
  input     wire        reset,

  output    logic[7:0]  cnt_o
);

  reg[7:0] current_count = 8'h1;
  assign cnt_o = current_count;
  
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
    	current_count <= 8'h1;
    end else begin
	    current_count <= current_count + 2;  
    end
  end
  
endmodule
