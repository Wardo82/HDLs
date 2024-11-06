// Parallel to serial with valid and empty

module day11 (
  input     wire      clk,
  input     wire      reset,

  output    wire      empty_o,
  input     wire[3:0] parallel_i,
  
  output    wire      serial_o,
  output    wire      valid_o
);

  // Write your logic here...
  reg[3:0] counter = 4'h0;
  reg[3:0] shift_register = 4'h0;
  assign serial_o = shift_register[3];
  reg valid = 0;
  assign valid_o = valid;
	reg empty = 1;
  assign empty_o = empty;
  
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
    	counter <= 4'h0;
      shift_register <= parallel_i;
      valid <= 0;
    end else begin
      	valid <= 1;
      	shift_register <= (shift_register << 1);
        counter <= counter + 1;
      if (counter == 4) begin
          empty <= 1;
        	counter <= 0;
        end
    end
  end
endmodule