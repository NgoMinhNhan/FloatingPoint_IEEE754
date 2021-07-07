`include "sosanh_8bit.v"
`include "mux.v"
`include "shift_right.v"
`include "bu2_bit.v"
`include "adder_2.v"
`include "tim_bit1.v"
`include "shift_left.v"
`include "xuatketqua.v"

module cong_tru(A,B,check_pt,result,overflow,underflow);

//Mô tả ngõ vào
input	[31:0]	A,B;
input			check_pt;			//bit phép tính
output			overflow,underflow;
output	[31:0]	result;

wire			signA,signB,exA_ST_exB,check_qualon,check_zero;
wire	[4:0]	nshift,nshiftleft;
wire	[7:0]	expA,expB,exp_out,exp_result;
wire	[9:0]	temp_exp,shiftleft_out,temp_shiftleft_out;
wire	[22:0]	frac_result;
wire	[23:0]	fracA,fracB;
wire	[24:0]	frac_out1,frac_out2,frac_out3,frac1,frac3,frac,frac_out,frac_before_result,frac_before_result2;
wire	[25:0]	frac1_beforeadd,frac2_beforeadd,frac_afteradd;

//Trích xuất sign, exponent, frac
assign	signA	= A[31];
assign	signB	= B[31]^check_pt;
assign	expA	= A[30:23];
assign	expB	= B[30:23];
assign	fracA	= {1'B1,A[22:0]};
assign	fracB	= {1'B1,B[22:0]};

//So sánh 2 exponent 
sosanh_8bit compare_expAandexpB(.in1(expA), .in2(expB), .shift(nshift), .in1_sub_in2(exA_ST_exB), .check_qualon(check_qualon));

//Xuất exponent lớn
mux8 select_exponent(.in1(expA), .in2(expB), .sel(exA_ST_exB), .out(exp_out));

//Chọn frac dịch và không dịch
mux25 find_fraction_noshift(.in1({signA,fracA}), .in2({signB,fracB}), .sel(exA_ST_exB), .out(frac_out1));
mux25 find_fraction_shift(.in1({signB,fracB}), .in2({signA,fracA}), .sel(exA_ST_exB), .out(frac_out2));
shift_right shift_fraction(.in(frac_out2), .shift(nshift), .out(frac_out3));

//Nếu là số âm thì thực hiện bù 2
bu2_25bit compli2_fraction1(.in({1'b0,frac_out1[23:0]}), .out(frac1));
bu2_25bit compli2_fraction2(.in({1'b0,frac_out3[23:0]}), .out(frac3));

assign frac1_beforeadd = frac_out1[24]?{1'b1,frac1}:{2'b00,frac_out1[23:0]};
assign frac2_beforeadd = frac_out2[24]?{1'b1,frac3}:{2'b00,frac_out3[23:0]};

//Thực hiện tính toán
adder_26bit add_1(.in1(frac1_beforeadd), .in2(frac2_beforeadd), .S(frac_afteradd), .Cout());

bu2_25bit bu2_frac(.in(frac_afteradd[24:0]), .out(frac_out));

assign frac = frac_afteradd[25]?frac_out:frac_afteradd[24:0];

assign sign_result = frac_afteradd[25];

//Tìm vị trí số 1 dầu tiên từ bit[23] qua phải
tim_bit1 find_1_in_frac(.in(frac), .shiftleft(nshiftleft), .check_zero(check_zero));
shift_left shift_frac(.in(frac), .shift(nshiftleft), .out(frac_before_result));

//Trường hợp số 1 nằm vì trị 24
shift_right shift_fraction1(.in(frac), .shift(5'd1), .out(frac_before_result2));

assign frac_result = frac[24]?frac_before_result2[22:0]:frac_before_result[22:0];

bu2_10bit compli2_exponent(.in({5'b0,nshiftleft}),.out(temp_shiftleftout));

assign shiftleftout = frac[24]?10'b1:temp_shiftleftout;

//NORMALIZE
adder_10bit	add_2(.in1(shiftleftout), .in2({2'b00,exp_out}), .S(temp_exp), .Cout());

assign underflow = temp_exp[9]&temp_exp[8];
assign overflow = ~temp_exp[9]&(temp_exp[8]|(&({temp_exp[7:0]})));

assign exp_result = temp_exp[8]?8'd0:(check_zero?8'd0:temp_exp[7:0]);

xuatketqua export1(.in1(A), .in2(B), .temp_result({sign_result,exp_result,frac_result}), .qualon({exA_ST_exB,check_qualon}), .result(result));

endmodule
