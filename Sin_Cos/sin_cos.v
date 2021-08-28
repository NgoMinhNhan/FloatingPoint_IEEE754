module sin_cos(in, out, sel);

input [31:0] in1, in2;
input sel;
output [31:0] out;

wire out1, out2;
wire temp_result;


taylor_sin SIN(.in(in1), .out(out1));
taylor_cos COS(.in(in2), .out(out2)); 

//sel = 0 choose sin
//sel = 1 choose cos

assign temp_result = sel?in1:in0;

xuat_result KETQUA(.in(in), .temp_result(temp_result), .result(out));

endmodule





