// Counter with a load
module day10 (
  input     wire          clk,
  input     wire          reset,
  input     wire          load_i,
  input     wire[3:0]     load_val_i,

  output    wire[3:0]     count_o
);

  // Write your logic here...
  reg[3:0] counter = 4'h0;
  assign count_o = counter;

  always_ff @(posedge clk, posedge reset, posedge load_i) begin
    if (reset) begin
    	counter <= 4'h0;
    end
    else if(load_i) begin
    	counter <= load_val_i;
    end
    else begin
        counter <= counter + 1;
    end
  end
endmodule
