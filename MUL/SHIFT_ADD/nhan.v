`include "shift_left.v"
`include "shift_right.v"
`include "bu2_bit.v"
`include "xuatketqua.v"
`include "full_adder.v"
`include "tim_bit1.v"

module mult(A, B, clk, n_rst, result, overflow, underflow);

input [31:0] A, B;
input clk, n_rst;

output [31:0] result;
output overflow, underflow; //co bao tran tren, tran duoi

wire sign_A, sign_B, sign_result; //significant

wire [7:0] exp_A, exp_B, exp_tmp, exp_result, exp_out; //exponent
wire [4:0] shiftleft, count;//bien dem, bien dich
wire [9:0] shiftleft_out, tmp_exp, exp_add;//bien tinh toan exponent

wire [22:0] frac_result;
wire [23:0] frac_A, frac_B, frac_right_before, frac_left_before;
wire [24:0] neg_M, data_sub, data_add;

wire [7:0] bu_exp;
wire [4:0] bu_count;

reg ena, q, q0;
reg [4:0] count_out;
reg [23:0] frac_out;
reg [24:0] M, Q, A1, data_A;
reg [49:0] AQq, tmp_fracCPA;
// so A
assign sign_A = A[31];
assign exp_A = A[30:23];
assign frac_A = {1'b1, A[22:0]};
//so B
assign sign_B = B[31];
assign exp_B = B[30:23];
assign frac_B = {1'b1, B[22:0]};
//tim bit dau sign
assign sign_result = sign_A^sign_B;
//tim so mu exponent
bu2_8bit exp_bu(.in(8'd127), .out(bu_exp));
adder_8bit find_adder( .in1(exp_A), .in2(bu_exp), .S(exp_tmp), .Cout());//exp - 127
adder_8bit exponent_add( .in1(exp_B), .in2(exp_tmp), .S(exp_out), .Cout());//exponent de cong = exp B+(exp-127)

//bo dem
bu2_5bit count_bu(.in(5'd1), .out(bu_count));
adder_5bit add_count( .in1(count_out), .in2(bu_count), .S(count), .Cout());//count - 1 

//cong_tru 25bit bo nhan 
bu2_25bit negM(.in(M), .out(neg_M));//bu 2 25bit negative M
adder_25bit add_AM(.in1(A1), .in2(M), .S(data_add), .Cout());//cong	
adder_25bit sub_AM(.in1(A1), .in2(neg_M), .S(data_sub), .Cout());//tru
//thiet lap AQq va q0
always @(*)
begin
	case ({Q[0],q})
		2'b10: data_A = data_sub;
		2'b01: data_A = data_add;
		default: data_A = A1;
	endcase
	AQq = {data_A[24],data_A,Q[24:1]};
	q0 = Q[0];
end
//thiet lap xung clk va rst
always @(posedge clk or negedge n_rst)
begin
	if (!n_rst)
		begin
		M <= {1'b0,frac_A};
		Q <= {1'b0,frac_B};
		q <= 1'b0;
		A1 <= 25'b0;
		count_out <= 5'd25; 
		end
	else
		begin
		{A1,Q,q} <= ena?{AQq,q0}:{A1,Q,q};
		count_out <= ena?count:count_out;
		end
end

//tao frac_out va tmp_fracCPA
always @(*)
begin
tmp_fracCPA = {A1,Q};
frac_out = (~(|(count_out)))?tmp_fracCPA[46:23]:24'b0;
ena	= |(count_out);
end

//tim fraction result
tim_bit1 tim(.in(frac_out), .shiftleft(shiftleft)); //tim gia tri dich trai
shift_left shift_frac_left(.in(frac_out), .shift(shiftleft), .out(frac_left_before));//fraction da dich trai
shift_right shift_frac_right(.in(frac_out), .shift(5'b1), .out(frac_right_before));//fraction da dich phai

assign frac_result = tmp_fracCPA[47]?frac_right_before[22:0]:frac_left_before[22:0];//CPA[47]?phai:trai
//tim exponent result 
bu2_10bit bu2_exponent(.in({5'b0,shiftleft}),.out(shiftleft_out));
assign exp_add = tmp_fracCPA[47]?10'b1:shiftleft_out;
adder_10bit	add_2(.in1(exp_add), .in2({2'b00,exp_out}), .S(tmp_exp), .Cout());

assign underflow = tmp_exp[9]&tmp_exp[8];
assign overflow = ~tmp_exp[9]&(tmp_exp[8]|(&({tmp_exp[7:0]})));

assign exp_result = tmp_exp[8]?8'd0:tmp_exp[7:0];

xuatketqua export1(.in1(A), .in2(B), .tmp_result({sign_result,exp_result,frac_result}), .result(result));

endmodule
