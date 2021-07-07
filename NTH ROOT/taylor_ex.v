`include "cong_tru.v"
`include "nhan.v"
`include "chia.v"
module taylor_exp(in, out); //taylor cua e^x

input [31:0] in;
output [31:0] out;

//x^i
wire [31:0] x2, x3, x4, x5, x6, x7, x8, x9, x10;

nhan A2(.a(in), .b(in), .result(x2));
nhan A3(.a(in), .b(x2), .result(x3));
nhan A4(.a(in), .b(x3), .result(x4));
nhan A5(.a(in), .b(x4), .result(x5));
nhan A6(.a(in), .b(x5), .result(x6));
nhan A7(.a(in), .b(x6), .result(x7));
nhan A8(.a(in), .b(x7), .result(x8));
nhan A9(.a(in), .b(x8), .result(x9));
nhan A10(.a(in), .b(x9), .result(x10));

//x^i/i!
wire [31:0] x2_2, x3_3, x4_4, x5_5, x6_6, x7_7, x8_8, x9_9, x10_10;

chia A2_2(.a(x2), .b(32'h40000000), .result(x2_2));//2!=2
chia A3_3(.a(x3), .b(32'h40c00000), .result(x3_3));//3!=6
chia A4_4(.a(x4), .b(32'h41c00000), .result(x4_4));//4!=24
chia A5_5(.a(x5), .b(32'h42f00000), .result(x5_5));//5!=120
chia A6_6(.a(x6), .b(32'h44340000), .result(x6_6));//6!=720
chia A7_7(.a(x7), .b(32'h459d8000), .result(x7_7));//7!=5040
chia A8_8(.a(x8), .b(32'h471d8000), .result(x8_8));//8!=40320
chia A9_9(.a(x9), .b(32'h48b13000), .result(x9_9));//9!=362880
chia A10_10(.a(x10), .b(32'h4a5d7c00), .result(x10_10));//10!=3628800
//e^x = taylor()
wire [31:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10;
cong_tru SUM_1 (.A(32'h3f800000), .B(in), .check_pt(1'b0), .result(sum1));
cong_tru SUM_2 (.A(sum1), .B(x2_2), .check_pt(1'b0), .result(sum2));
cong_tru SUM_3 (.A(sum2), .B(x3_3), .check_pt(1'b0), .result(sum3));
cong_tru SUM_4 (.A(sum3), .B(x4_4), .check_pt(1'b0), .result(sum4));
cong_tru SUM_5 (.A(sum4), .B(x5_5), .check_pt(1'b0), .result(sum5));
cong_tru SUM_6 (.A(sum5), .B(x6_6), .check_pt(1'b0), .result(sum6));
cong_tru SUM_7 (.A(sum6), .B(x7_7), .check_pt(1'b0), .result(sum7));
cong_tru SUM_8 (.A(sum7), .B(x8_8), .check_pt(1'b0), .result(sum8));
cong_tru SUM_9 (.A(sum8), .B(x9_9), .check_pt(1'b0), .result(sum9));
cong_tru SUM_10 (.A(sum9), .B(x10_10), .check_pt(1'b0), .result(sum10));

assign out = sum10;
endmodule