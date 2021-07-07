`include "CLB.v"
//bo cong 8bit
module adder_8bit(in1, in2, S, Cout);

input [7:0] in1, in2;
output [7:0] S;
output Cout;

wire [1:0] p_level, g_level, c_level;
wire [7:0]  p, g, c;

assign p = in1^in2;
assign g = in1&in2;

//level_1 separate to [7:4] and [3:0]
clb_4 clb1(.p(p[3:0]), .g(g[3:0]), .c(c_level[0]), .pout(p_level[0]), .gout(g_level[0]), .cout(c[3:0]));
clb_4 clb2(.p(p[7:4]), .g(g[7:4]), .c(c_level[1]), .pout(p_level[1]), .gout(g_level[1]), .cout(c[7:4]));
//level_2 => Cout 
clb_2 clb_12(.p(p_level), .g(g_level), .c(1'b0), .pout(), .gout(Cout), .cout(c_level));
//Sum
assign S = p^c;
endmodule

//bo cong 9bit
module adder_9bit(in1, in2, S, Cout);

input [8:0] in1, in2;
output [8:0] S;
output Cout;

wire [2:0] p_level, g_level, c_level;
wire [8:0] p, g, c;

assign p = in1^in2;
assign g = in1&in2;

//level_1 => [3:0], [6:4], [7:8]
clb_4 clb1(.p(p[3:0]), .g(g[3:0]), .c(c_level[0]), .pout(p_level[0]), .gout(g_level[0]), .cout(c[3:0]));
clb_3 clb2(.p(p[6:4]), .g(g[6:4]), .c(c_level[1]), .pout(p_level[1]), .gout(g_level[1]), .cout(c[6:4]));
clb_2 clb3(.p(p[8:7]), .g(g[8:7]), .c(c_level[2]), .pout(p_level[2]), .gout(g_level[2]), .cout(c[8:7]));
//level_2 
clb_3 clb_123(.p(p_level), .g(g_level), .c(1'b0), .pout(), .gout(Cout), .cout(c_level));

assign S = p^c;
endmodule

//bo cong 10bit
module adder_10bit(in1, in2, S, Cout);

input [9:0] in1, in2;
output [9:0] S;
output Cout;

wire [2:0] p_level, g_level, c_level;
wire [9:0]  p, g, c;

assign p = in1^in2;
assign g = in1&in2;

//level_1 separate to [9:8], [7:4], [3:0]
clb_4 clb1(.p(p[3:0]), .g(g[3:0]), .c(c_level[0]), .pout(p_level[0]), .gout(g_level[0]), .cout(c[3:0]));
clb_4 clb2(.p(p[7:4]), .g(g[7:4]), .c(c_level[1]), .pout(p_level[1]), .gout(g_level[1]), .cout(c[7:4]));
clb_2 clb3(.p(p[9:8]), .g(g[9:8]), .c(c_level[2]), .pout(p_level[2]), .gout(g_level[2]), .cout(c[9:8]));
//level_2 => Cout 
clb_3 clb_123(.p(p_level), .g(g_level), .c(1'b0), .pout(), .gout(Cout), .cout(c_level));
//Sum
assign S = p^c;
endmodule

//bo cong 25 bit
module adder_25bit(in1, in2, S, Cout);

input [24:0] in1, in2;
output [24:0] S;
output Cout;

wire [6:0] p_level, g_level, c_level;
wire [1:0] p_level2, g_level2, c_level2;
wire [24:0]  p, g, c;

assign p = in1^in2;
assign g = in1&in2;

//level_1 separate to [24:23],[22:20],[19:16],[15:12],[11:8],[7:4] and [3:0]
clb_4 clb1(.p(p[3:0]), .g(g[3:0]), .c(c_level[0]), .pout(p_level[0]), .gout(g_level[0]), .cout(c[3:0]));
clb_4 clb2(.p(p[7:4]), .g(g[7:4]), .c(c_level[1]), .pout(p_level[1]), .gout(g_level[1]), .cout(c[7:4]));
clb_4 clb3(.p(p[11:8]), .g(g[11:8]), .c(c_level[2]), .pout(p_level[2]), .gout(g_level[2]), .cout(c[11:8]));
clb_4 clb4(.p(p[15:12]), .g(g[15:12]), .c(c_level[3]), .pout(p_level[3]), .gout(g_level[3]), .cout(c[15:12]));
clb_4 clb5(.p(p[19:16]), .g(g[19:16]), .c(c_level[4]), .pout(p_level[4]), .gout(g_level[4]), .cout(c[19:16]));
clb_3 clb6(.p(p[22:20]), .g(g[22:20]), .c(c_level[5]), .pout(p_level[5]), .gout(g_level[5]), .cout(c[22:20]));
clb_2 clb7(.p(p[24:23]), .g(g[24:23]), .c(c_level[6]), .pout(p_level[6]), .gout(g_level[6]), .cout(c[24:23]));
//level_2 
clb_4 clb_1234(.p(p_level[3:0]), .g(g_level[3:0]), .c(c_level2[0]), .pout(p_level2[0]), .gout(g_level2[0]), .cout(c_level[3:0]));
clb_3 clb_567(.p(p_level[6:4]), .g(g_level[6:4]), .c(c_level2[1]), .pout(p_level2[1]), .gout(g_level2[1]), .cout(c_level[6:4]));
//level3 => Cout
clb_2 clb_cout(.p(p_level2), .g(g_level2), .c(1'b0), .pout(), .gout(Cout), .cout(c_level2));
//Sum
assign S = p^c;
endmodule

//bo cong 26 bit
module adder_26bit(in1, in2, S, Cout);

input [25:0] in1, in2;
output [25:0] S;
output Cout;

wire [6:0] p_level, g_level, c_level;
wire [1:0] p_level2, g_level2, c_level2;
wire [25:0]  p, g, c;

assign p = in1^in2;
assign g = in1&in2;

//level_1 separate to [24:23],[22:20],[19:16],[15:12],[11:8],[7:4] and [3:0]
clb_4 clb1(.p(p[3:0]), .g(g[3:0]), .c(c_level[0]), .pout(p_level[0]), .gout(g_level[0]), .cout(c[3:0]));
clb_4 clb2(.p(p[7:4]), .g(g[7:4]), .c(c_level[1]), .pout(p_level[1]), .gout(g_level[1]), .cout(c[7:4]));
clb_4 clb3(.p(p[11:8]), .g(g[11:8]), .c(c_level[2]), .pout(p_level[2]), .gout(g_level[2]), .cout(c[11:8]));
clb_4 clb4(.p(p[15:12]), .g(g[15:12]), .c(c_level[3]), .pout(p_level[3]), .gout(g_level[3]), .cout(c[15:12]));
clb_4 clb5(.p(p[19:16]), .g(g[19:16]), .c(c_level[4]), .pout(p_level[4]), .gout(g_level[4]), .cout(c[19:16]));
clb_4 clb6(.p(p[23:20]), .g(g[23:20]), .c(c_level[5]), .pout(p_level[5]), .gout(g_level[5]), .cout(c[23:20]));
clb_2 clb7(.p(p[25:23]), .g(g[25:23]), .c(c_level[6]), .pout(p_level[6]), .gout(g_level[6]), .cout(c[25:23]));
//level_2 
clb_4 clb_1234(.p(p_level[3:0]), .g(g_level[3:0]), .c(c_level2[0]), .pout(p_level2[0]), .gout(g_level2[0]), .cout(c_level[3:0]));
clb_3 clb_567(.p(p_level[6:4]), .g(g_level[6:4]), .c(c_level2[1]), .pout(p_level2[1]), .gout(g_level2[1]), .cout(c_level[6:4]));
//level3 => Cout
clb_2 clb_cout(.p(p_level2), .g(g_level2), .c(1'b0), .pout(), .gout(Cout), .cout(c_level2));
//Sum
assign S = p^c;
endmodule
