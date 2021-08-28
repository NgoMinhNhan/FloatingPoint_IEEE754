module taylor_sin(in, out);

input [31:0] in;
output [31:0] out;

//x^1,2,3,...
wire [31:0] x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13;

nhan A2 (.A(in), .B(in),  .Out(x2));
nhan A3 (.A(in), .B(x2),  .Out(x3));
nhan A4 (.A(in), .B(x3),  .Out(x4));
nhan A5 (.A(in), .B(x4),  .Out(x5));
nhan A6 (.A(in), .B(x5),  .Out(x6));
nhan A7 (.A(in), .B(x6),  .Out(x7));
nhan A8 (.A(in), .B(x7),  .Out(x8));
nhan A9 (.A(in), .B(x8),  .Out(x9));
nhan A10(.A(in), .B(x9),  .Out(x10));
nhan A11(.A(in), .B(x10), .Out(x11));
nhan A12(.A(in), .B(x11), .Out(x12));
nhan A13(.A(in), .B(x12), .Out(x13));

//x^i/i!
wire [31:0] x3_3, x5_5, x7_7, x9_9, x11_11, x13_13;

chia A3_3		(.A(x3), 		.B(32'hc0c00000),	.Out(x3_3));//3!=6
chia A5_5		(.A(x5),		.B(32'h42f00000), 	.Out(x5_5));//5!=120
chia A7_7		(.A(x7), 		.B(32'hc59d8000), 	.Out(x7_7));//7!=5040
chia A9_9		(.A(x9), 		.B(32'h48b13000),	.Out(x9_9));//9!=362880
chia A10_10 	(.A(x11),   	.B(32'hcc184540),  	.Out(x11_11));//11!=39916800
chia A13_13 	(.A(x13),   	.B(32'h4fb99466),   .Out(x13_13));//13!=6227020800
//sinx = x - (x^3)/3! + (x^5)/5! - (x^7)/7! + (x^9)/9! - (x^11)/11! + (x^13)/13! + ...
wire [31:0] sum1, sum2, sum3, sum4, sum5;
cong_tru   SUM_1 (.A(in), 			.B(x3_3), 		.Out(sum1), .Operation(1'b0));
cong_tru   SUM_2 (.A(sum1),			.B(x3_3),		.Out(sum2), .Operation(1'b0));
cong_tru   SUM_3 (.A(sum2),		  	.B(x5_5), 		.Out(sum3), .Operation(1'b0));
cong_tru   SUM_4 (.A(sum3),		    .B(x7_7),		.Out(sum4), .Operation(1'b0));
cong_tru   SUM_5 (.A(sum4),		  	.B(x9_9), 		.Out(sum5), .Operation(1'b0));
cong_tru   SUM_6 (.A(sum5),		    .B(x11_11),		.Out(out),  .Operation(1'b0));

endmodule
