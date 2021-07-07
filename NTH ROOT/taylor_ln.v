`include "cong_tru.v"
`include "nhan.v"
`include "chia.v"

module taylor_ln(in, out);

input [31:0] in;
output [31:0] out;

reg [31:0] number_05 = 32'h3f000000; // 0.5
reg [31:0] number_05_neg = 32'hbf000000;// -0.5
reg [31:0] number_ln05 = 32'hbf317218; // ln(0.5)= -0.69314718
//(x-0.5)
wire [31:0] x_m; 
wire [31:0] x_m_1
wire [31:0] x_m_2, x_m_3, x_m_4, x_m_5, x_m_6, x_m_7, x_m_8, x_m_9, x_m_10;
wire [31:0] x_m_2_2, x_m_3_3, x_m_4_4, x_m_5_5, x_m_6_6, x_m_7_7, x_m_8_8, x_m_9_9, x_m_10_10;
wire [31:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10;

cong_tru N1(.a(in), .b(number_05_neg), .result(x_m), check_pt(1'b0));
//(x-0.5)/0.5
chia A1(.a(x_m), .b(number_05), .result(x_m_1));
//((x-0.5)/0.5)^i ,i=1...10
nhan A2(.a(x_m_1), .b(x_m_1), .result(x_m_2));
nhan A3(.a(x_m_1), .b(x_m_2), .result(x_m_3));
nhan A4(.a(x_m_1), .b(x_m_3), .result(x_m_4));
nhan A5(.a(x_m_1), .b(x_m_4), .result(x_m_5));
nhan A6(.a(x_m_1), .b(x_m_5), .result(x_m_6));
nhan A7(.a(x_m_1), .b(x_m_6), .result(x_m_7));
nhan A8(.a(x_m_1), .b(x_m_7), .result(x_m_8));
nhan A9(.a(x_m_1), .b(x_m_8), .result(x_m_9));
nhan A10(.a(x_m_1), .b(x_m_9), .result(x_m_10));
//((x-0.5)/0.5)^i/i
chia A2(.a(x_m_2), .b(32'h40000000), .result(x_m_22));
chia A3(.a(x_m_3), .b(32'h40400000), .result(x_m_33));
chia A4(.a(x_m_4), .b(32'h40800000), .result(x_m_44));
chia A5(.a(x_m_5), .b(32'h40a00000), .result(x_m_55));
chia A6(.a(x_m_6), .b(32'h40c00000), .result(x_m_66));
chia A7(.a(x_m_7), .b(32'h40e00000), .result(x_m_77));
chia A8(.a(x_m_8), .b(32'h41000000), .result(x_m_88));
chia A9(.a(x_m_9), .b(32'h41100000), .result(x_m_99));
chia A10(.a(x_m_10), .b(32'h41200000), .result(x_m_1010));
//sum = taylor lnx
cong_tru A1(.A(number_ln05), .B(x_m_1), .check_pt(1'b0), .result(sum1));
cong_tru A2(.A(sum1), .B(x_m_2_2), .check_pt(1'b1), .result(sum2));
cong_tru A3(.A(sum2), .B(x_m_3_3), .check_pt(1'b0), .result(sum3));
cong_tru A4(.A(sum3), .B(x_m_4_4), .check_pt(1'b1), .result(sum4));
cong_tru A5(.A(sum4), .B(x_m_5_5), .check_pt(1'b0), .result(sum5));
cong_tru A6(.A(sum5), .B(x_m_6_6), .check_pt(1'b1), .result(sum6));
cong_tru A7(.A(sum6), .B(x_m_7_7), .check_pt(1'b0), .result(sum7));
cong_tru A8(.A(sum7), .B(x_m_8_8), .check_pt(1'b1), .result(sum8));
cong_tru A9(.A(sum8), .B(x_m_9_9), .check_pt(1'b0), .result(sum9));
cong_tru A10(.A(sum9), .B(x_m_10_10), .check_pt(1'b1), .result(sum10));
//xuat ket qua
assign out = (in[30:0] == number_05[30:0])?number_ln05:sum10;









