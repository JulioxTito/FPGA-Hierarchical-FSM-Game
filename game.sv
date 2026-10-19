module game (
  input  logic clk, n, s, e, w, reset,
  output logic s6, win, s5, d, s4, s3, sw, s2, s1, s0, v
);
  logic sw_sig, v_sig;

  room  u_room (.clk(clk), .n(n), .s(s), .e(e), .w(w), .v(v_sig), .reset(reset),
                .s6(s6), .s5(s5), .s4(s4), .s3(s3), .sw(sw_sig),
                .s2(s2), .s1(s1), .s0(s0), .d(d), .win(win));

  sword u_sword(.clk(clk), .reset(reset), .sw(sw_sig), .v(v_sig));

  assign sw = sw_sig;
  assign v  = v_sig;
endmodule
