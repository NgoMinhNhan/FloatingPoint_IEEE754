`include "shift_left.v"
`include "bu2_bit.v"
`include "xuatketqua.v"
`include "full_adder.v"
`include "tim_bit1.v"

module div(A, B, clk, n_rst, result, overflow, underflow, enable);

input [31:0] A, B;
input clk, n_rst;

output [31:0] result;
output enable, overflow, underflow; //co bao tran tren, tran duoi

wire sign_A, sign_B, sign_result; //significant

wire [7:0] exp_A, exp_B, exp_tmp1, exp_tmp2, exp_result, exp_out; //exponent
wire [4:0] shiftleft;
wire [5:0] count;//bien dem, bien dich
wire [9:0] shiftleft_out, tmp_exp;//bien tinh toan exponent

wire [22:0] frac_result;
wire [23:0] frac_A, frac_B, frac_before_result;
wire [47:0] frac_An, frac_Bn;
wire [48:0] neg_M;

wire [7:0] bu_exp;
wire [5:0] bu_count;

reg ena,enable, q;
reg [5:0] count_out;
reg [23:0] frac_out;
reg [47:0] Q;
reg [48:0] M, A1, data_A, data_A_out, tmp_A, data_out;
reg [96:0] AQq;
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
adder_8bit find_adder( .in1(exp_B), .in2(bu_exp), .S(exp_tmp1), .Cout());//exp - 127
bu2_8bit sosanh_exp(.in(exp_tmp1), .out(exp_tmp2));
adder_8bit exponent_add( .in1(exp_A), .in2(exp_tmp2), .S(exp_out), .Cout());//exponent de cong = exp B+(exp-127)
//tinh fraction
//so sanh 49bit va cong49bit
bu2_49bit bu_M(.in1(M), .out(neg_M));
adder_49bit add_AM(.in1(data_A), .in2(neg_M), .S(tmp_AM), .Cout());
always @(*)
	begin
	tmp_A = tmp_AM;
	end
//thiet lap frac_An va frac_Bn 
assign frac_An = {frac_A,24'b0};
assign frac_Bn = {24'b0, frac_B};
//thiet lap cac gia tri AQq, dataA, dataA_out, q
always @(*)
begin
	AQq = {A1[47:0],Q,q};
	data_A = AQq[96:48];
	q = ~tmp_A[48];
	data_A_out = tmp_A[48]?data_A:tmp_A;
end
//bo dem
bu2_6bit count_bu(.in(6'd1), .out(bu_count));
adder_6bit dem_xuong( .in1(count_out), .in2(bu_count), .S(count), .Cout());//count - 1 
//thiet lap xung clk va rst
always @(posedge clk or negedge n_rst)
begin
	if (!n_rst)
		begin
		Q <= frac_An;//so bi chia
		M <= {1'b0,frac_Bn};//so chia
		A1 <= 49'b0;//du 
		count_out <= 6'd48; 
		end
	else
		begin
		A1 <= ena?data_A_out:A1;
		Q <= ena?AQq[47:0]:Q;
		count_out <= ena?count:count_out;
		end
end
//tao frac_out va co enable
always @(*)
begin
frac_out = (~(|(count_out)))?Q[24:1]:24'b0;
ena	= |(count_out);
enable = ~ena;
end

//tim fraction result
tim_bit1 tim(.in(frac_out), .shiftleft(shiftleft)); //tim gia tri dich trai
shift_left shift_frac_left(.in(frac_out), .shift(shiftleft), .out(frac_before_result));//fraction da dich trai

assign frac_result = frac_before_result[22:0];
//tim exponent result 
bu2_10bit bu2_exponent(.in({5'b0,shiftleft}),.out(shiftleft_out));

adder_10bit	add_2(.in1({2'b00,exp_out}), .in2(shiftleft_out), .S(tmp_exp), .Cout());

assign underflow = tmp_exp[9]&tmp_exp[8];
assign overflow = ~tmp_exp[9]&(tmp_exp[8]|(&({tmp_exp[7:0]})));

assign exp_result = tmp_exp[8]?8'd0:tmp_exp[7:0];

xuatketqua export1(.in1(A), .in2(B), .tmp_result({sign_result,exp_result,frac_result}), .result(result));

endmodule
