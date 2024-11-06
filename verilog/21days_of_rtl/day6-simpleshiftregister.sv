// Simple shift register
module day6(
  input     wire        clk,
  input     wire        reset,
  input     wire        x_i,      // Serial input

  output    wire[3:0]   sr_o
);
  reg[3:0] shift_register = 4'h0;
  assign sr_o = shift_register;

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
    	shift_register <= 4'h0;
    end else begin
        shift_register <= {shift_register[2:0], x_i};
    end
  end
endmodule
