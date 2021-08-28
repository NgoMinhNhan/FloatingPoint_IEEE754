`include "cong_tru.v"
`include "nhan.v"
`include "chia.v"

module taylor_cos(in, out); 

input [31:0] in;
output [31:0] out;

//x^1,2,3,...
wire [31:0] x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12;

nhan A2 (.a(in), .b(in),  .result(x2));
nhan A4 (.a(x2), .b(x2),  .result(x4));
nhan A6 (.a(x2), .b(x4),  .result(x6));
nhan A8 (.a(x2), .b(x6),  .result(x8));
nhan A10(.a(x2), .b(x8),  .result(x10));
nhan A12(.a(x2), .b(x10), .result(x12));

//x^i/i!
wire [31:0] x2_2, x4_4, x6_6, x8_8, x10_10, x12_12;

chia A2_2	(.a(x2), 	.b(32'h40000000),	.result(x2_2));//2!=2
chia A4_4	(.a(x4),	.b(32'h41c00000), 	.result(x4_4));//4!=24
chia A6_6	(.a(x6), 	.b(32'h44340000), 	.result(x6_6));//6!=720
chia A8_8	(.a(x8), 	.b(32'h471d8000),	.result(x8_8));//8!=40320
chia A10_10 	(.a(x10),  	.b(32'h4a5d7c00),  	.result(x10_10));//10!=3628800
chia A12_12 	(.a(x12),   	.b(32'h4de467e0),   	.result(x12_12));//12!=479001600

//sinx = 1 - (x^2)/2! + (x^4)/4! - (x^6)/6! + (x^8)/8! - (x^10)/10! + (x^12)/12!  ...
wire [31:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7;

cong_tru SUM_4 (.A(32'h00000000),	  .B(x4_4), 			.result(sum1));
cong_tru SUM_5 (.A(sum1),		  .B(x8_8), 		 	.result(sum2));
cong_tru SUM_6 (.A(sum2),		  .B(x12_12), 		 	.result(sum3));
wire [31:0] out1;
assign out1 = sum3; 

cong_tru SUM_1 (.A(32'h00000000), 	  .B({1,{x2_2[30:0]}}),   	.result(sum4));
cong_tru SUM_2 (.A(sum4),		  .B({1,{x6_6[30:0]}}),   	.result(sum5));
cong_tru SUM_3 (.A(sum5),		  .B({1,{x10_10[30:0]}}), 	.result(sum6));
wire [31:0] out2;
assign out2 = sum6;
wire [31:0] out_m;
cong_tru SUM_M(.A(out1),  .B(out2),  .result(out_m));
cong_tru SUM  (.A(out_m),  .B(32'h3f800000),  .result(out));
endmodule
