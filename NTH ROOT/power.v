`include "taylor_ln.v"
`include "taylor_ex."

module power(a, b, result);

input [31:0] a, b;
output [31:0] result;

//tinh ln(A)
wire [31:0] ln_A;
taylor_ln tinh_lnA(.in(a), .out(ln_A));
//tinh B*ln(A)
nhan B_lnA(.a(ln_A), .b(B), .result(in_tmp));
//tinh e^(B*lnA)
taylor_ex tinh_mu(.a(in_tmp), .b(result));
endmodule
