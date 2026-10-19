module sword (
  input  logic clk,
  input  logic reset,
  input  logic sw,
  output logic v
);
  logic next_v;
  always_comb begin
    next_v = v;
    if (reset)   next_v = 1'b0;
    else if (sw) next_v = 1'b1;
  end
  d_ff svff(.clk(clk), .d(next_v), .q(v));
endmodule
