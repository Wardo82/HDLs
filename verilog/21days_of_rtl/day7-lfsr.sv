// LFSR
module day7 (
  input     wire      clk,
  input     wire      reset,

  output    wire[3:0] lfsr_o
);

  // Write your logic here...
  reg[3:0] shift_register = 4'h0;
  assign lfsr_o = shift_register;

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
    	shift_register <= 4'h0;
    end else begin
        shift_register <= {shift_register[2:0], (shift_register[3] ^ shift_register[1])};
    end
  end
endmodule
