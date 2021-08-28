`include "cong_tru.v"
`include "nhan.v"
`include "chia.v"

module taylor_cos(in, out); 

input [31:0] in;
output [31:0] out;

//x^1,2,3,...
wire [31:0] x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12;

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

//x^i/i!
wire [31:0] x2_2, x4_4, x6_6, x8_8, x10_10, x12_12;

chia A2_2	(.a(x2), 	.b(32'h40000000),	.result(x2_2));//2!=2
chia A4_4	(.a(x4),	.b(32'h41c00000), 	.result(x4_4));//4!=24
chia A6_6	(.a(x6), 	.b(32'h44340000), 	.result(x6_6));//6!=720
chia A8_8	(.a(x8), 	.b(32'h471d8000),	.result(x8_8));//8!=40320
chia A10_10 	(.a(x10),  	.b(32'h4a5d7c00),  	.result(x10_10));//10!=3628800
chia A12_12 	(.a(x12),   	.b(32'h4de467e0),   	.result(x12_12));//12!=479001600

//sinx = (1 - (x^2)/2!) + ((x^4)/4! - (x^6)/6!) + ((x^8)/8! - (x^10)/10!) + (x^12)/12!  ...
wire [31:0] sum1, sum2, sum3, sum4, sum5, sum6;
 
cong_tru SUM_1 (.A(32'h3f800000),	      .B(x2_2), 	.Out(sum1), .Operation(1'b1));
cong_tru SUM_2 (.A(x4_4),		      .B(x6_6), 	.Out(sum2), .Operation(1'b1));
cong_tru SUM_3 (.A(x8_8),		      .B(x10_10), 	.Out(sum3), .Operation(1'b1));
cong_tru SUM_4 (.A(x12_12),                   .B(32'h0),	.Out(sum4), .Operation(1'b1));
///////////////////////////////////////////////////
cong_tru SUM_5 (.A(sum1),		      .B(sum2),		.Out(sum5), .Operation(1'b0));
cong_tru SUM_6 (.A(sum3),		      .B(sum4),		.Out(sum6), .Operation(1'b0));
/////////////////////////////////////////////////////
cong_tru SUM_7 (.A(sum5),		      .B(sum6),		.Out(out),  .Operation(1'b0));
endmodule
