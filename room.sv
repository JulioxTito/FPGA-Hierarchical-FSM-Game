module room (
  input  logic clk, n, s, e, w, v, reset,
  output logic s6, s5, s4, s3, sw, s2, s1, s0, d, win
);
  logic [6:0] state, next_state;

  logic n_only, s_only, e_only, w_only, se_only, sw_only, ne_only, nw_only ;
  always_comb begin
    n_only  =  n & ~s & ~e & ~w;
    s_only  = ~n &  s & ~e & ~w;
    e_only  = ~n & ~s &  e & ~w;
    w_only  = ~n & ~s & ~e &  w;
    se_only = ~n &  s &  e & ~w;
	  sw_only = ~n &  s & ~e & w;
	  ne_only = n &  ~s & e & ~w;
	  nw_only = n &  ~s & ~e & w;
  end

  always_comb begin
    next_state = state;
    if (reset)                              next_state = 7'b0000001;           // S0
	 /*
    else if (state[0] && w_only)            next_state = 7'b0000010;           // S0->S1
    else if (state[1] && s_only)            next_state = 7'b0000100;           // S1->S2
    else if (state[1] && w_only)            next_state = 7'b0000001;           // S1->S0
    else if (state[2] && n_only)            next_state = 7'b0000010;           // S2->S1
    else if (state[2] && w_only)            next_state = 7'b0001000;           // S2->S3
    else if (state[2] && se_only)           next_state = 7'b0010000;           // S2->S4  (Lab-4 rule)
    else if (state[3] && e_only)            next_state = 7'b0000100;           // S3->S2
    else if (state[4] &&  v)                next_state = 7'b1000000;           // S4->S6
    else if (state[4] && !v)                next_state = 7'b0100000;           // S4->S5
    else if (state[6])                      next_state = 7'b1000000;           // stay S6
    else if (state[5])                      next_state = 7'b0100000;           // stay S5
	 */
	 
	 else if (state[0] && w_only)            next_state = 7'b0000010;           // S0->S1
	 else if (state[1] && sw_only)            next_state = 7'b0000100;           // S1->S2
	 else if (state[1] && e_only)            next_state = 7'b0000001;           // S1->S0
	 
	 else if (state[2] && se_only)            next_state = 7'b0001000;           // S2->S3
	 else if (state[2] && ne_only)            next_state = 7'b0000010;           // S2->S1
	 else if (state[2] && w_only)           next_state = 7'b0010000;           // S2->S4
	 
	 else if (state[3] && nw_only)            next_state = 7'b0000100;           // S3->S2
	 
	 else if (state[4] &&  v)                next_state = 7'b1000000;           // S4->S6
    else if (state[4] && !v)                next_state = 7'b0100000;           // S4->S5
    else if (state[6])                      next_state = 7'b1000000;           // stay S6
    else if (state[5])                      next_state = 7'b0100000;           // stay S5
	 
	 
	 
	 
	 
	 
  end

  genvar i;
  generate
    for (i=0; i<7; i=i+1) begin : state_ff
      d_ff ff_i(.clk(clk), .d(next_state[i]), .q(state[i]));
    end
  endgenerate

  assign {s6,s5,s4,s3,s2,s1,s0} = state;
  assign sw  = state[3];
  assign win = state[6];
  assign d   = state[5];
endmodule
