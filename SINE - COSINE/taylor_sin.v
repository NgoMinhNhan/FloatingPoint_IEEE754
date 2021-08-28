module taylor_sin(in, out);

input [31:0] in;
output [31:0] out;

//x^1,2,3,...
wire [31:0] x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13;

nhan A2 (.a(in), .b(in),  .result(x2));
nhan A3 (.a(in), .b(x2),  .result(x3));
nhan A4 (.a(in), .b(x3),  .result(x4));
nhan A5 (.a(in), .b(x4),  .result(x5));
nhan A6 (.a(in), .b(x5),  .result(x6));
nhan A7 (.a(in), .b(x6),  .result(x7));
nhan A8 (.a(in), .b(x7),  .result(x8));
nhan A9 (.a(in), .b(x8),  .result(x9));
nhan A10(.a(in), .b(x9),  .result(x10));
nhan A11(.a(in), .b(x10), .result(x11));
nhan A12(.a(in), .b(x11), .result(x12));
nhan A13(.a(in), .b(x12), .result(x13));

//x^i/i!
wire [31:0] x3_3, x5_5, x7_7, x9_9, x11_11, x13_13;

chia A3_3	(.a(x3), 		.b(32'h40c00000),	.result(x3_3));//3!=6
chia A5_5	(.a(x5),		.b(32'h42f00000), 	.result(x5_5));//5!=120
chia A7_7	(.a(x7), 		.b(32'h459d8000), 	.result(x7_7));//7!=5040
chia A9_9	(.a(x9), 		.b(32'h48b13000),	.result(x9_9));//9!=362880
chia A10_10 	(.a(x11),   		.b(32'h4c184540),  	.result(x11_11));//11!=39916800
chia A13_13	(.a(x13),   		.b(32'h4fb99466),  	.result(x13_13));//13!=6227020800
//sinx = x - (x^3)/3! + (x^5)/5! - (x^7)/7! + (x^9)/9! - (x^11)/11! + (x^13)/13! + ...
wire [31:0] sum1, sum2, sum3, sum4, sum5, sum6;
 
cong_tru SUM_1 (.A(in),	  		      .B(x3_3), 	.Out(sum1), .Operation(1'b1));
cong_tru SUM_2 (.A(x5_5),		      .B(x7_7), 	.Out(sum2), .Operation(1'b1));
cong_tru SUM_3 (.A(x9_9),		      .B(x11_11), 	.Out(sum3), .Operation(1'b1));
cong_tru SUM_4 (.A(x13_13),                   .B(32'h0),	.Out(sum4), .Operation(1'b1));
///////////////////////////////////////////////////
cong_tru SUM_5 (.A(sum1),		      .B(sum2),		.Out(sum5), .Operation(1'b0));
cong_tru SUM_6 (.A(sum3),		      .B(sum4),		.Out(sum6), .Operation(1'b0));
/////////////////////////////////////////////////////
cong_tru SUM_7 (.A(sum5),		      .B(sum6),		.Out(out),  .Operation(1'b0));

endmodule

