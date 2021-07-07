`include "power.v"
module root( a_base, b_root, result);

input [31:0] a_base, b_root;
output [31:0] result;

wire [31:0] one_root;
wire [31:0] out_tmp;

wire NaN_flag, Inf_flag;
parameter NaN = 32'h7FFF_FFFF;
parameter Inf = 32'h7F80_0000;
//tinh 1/B
chia (.a(32'h3f800000), .b(b_root), .result(one_root));
//tinh a^(1/b)
power khaican(.a_base(a_base), .b_exp(one_root), .result(out_tmp);
//kiem tra truong hop dac biet
assign NaN_flag = (a_base == NaN)|(root == NaN);
assign Inf_flag = a_base[30:0] == Inf;
assign out = (NaN_flag==1'b1)?NaN:
			 (Inf_flag==1'b0)?{1'b0,inf}:
			 ((a_base[31]==1'b1)?NaN:out_tmp);
endmodule
