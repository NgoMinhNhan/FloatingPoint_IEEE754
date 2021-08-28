`include "taylor_sin.v"
`include "taylor_cos.v"
`include "xuat_result.v"
////////////////////////////////////////////////////

module sin_cos(in, sel, result);
////////////////////////////////////////////////////
input  [31:0] in;
input	      sel;
output [31:0] result;

wire   [31:0] out1, out2;
wire   [31:0] temp_result;
////////////////////////////////////////////////////

taylor_sin SIN(.in(in), .out(out1));
taylor_cos COS(.in(in), .out(out2)); 
////////////////////////////////////////////////////
//sel = 0 choose cos
//sel = 1 choose sin

assign temp_result = sel?out1:out2;

xuat_result KQ(.in(in), .temp_result(temp_result), .result(result));

//assign result = (in == ({in[31],31'h7f800000})? {in[31],31'h7f800000} : ((in == 32'h7FFFFFFF)?32'h7FFFFFFF:temp_result));

////////////////////////////////////////////////////

endmodule





