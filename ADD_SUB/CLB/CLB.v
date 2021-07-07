//carry_lookahead adder
//block CLB_2bit
module clb_2(cout, pout, gout, c, p, g);

input [1:0] p, g;
input c;

output [1:0] cout;
output pout, gout;

assign cout[0] = c;
assign cout[1] = g[0]|(p[0]&c);

assign gout = g[1]|(p[1]&g[0]);
assign pout = p[1]&p[0];

endmodule
//block CLB_3bit
module clb_3(cout, pout, gout, c, p, g);

input [2:0] p, g;
input c;

output [2:0] cout;
output pout, gout;

assign cout[0] = c;
assign cout[1] = g[0]|(p[0]&c);
assign cout[2] = g[1]|(p[1]&g[0])|(p[1]&p[0]&c);

assign gout = g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0]);
assign pout = p[2]&p[1]&p[0];

endmodule
//block CLB_4bit
module clb_4(cout, pout, gout, c, p, g);

input [3:0] p, g;
input c;

output [3:0] cout;
output pout, gout;

assign cout[0] = c;
assign cout[1] = g[0]|(p[0]&c);
assign cout[2] = g[1]|(p[1]&g[0])|(p[1]&p[0]&c);
assign cout[3] = g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&c);

assign gout = g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0]);
assign pout = p[3]&p[2]&p[1]&p[0];

endmodule


