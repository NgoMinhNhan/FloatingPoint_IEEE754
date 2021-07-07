module shift_right(in, out, shift);

input	[24:0]	in;
input	[4:0]	shift;
output	[24:0]	out;

wire	[23:0]	tmp1,tmp2,tmp3,tmp4;


shift_right16 shift_1(.in(in[23:0]), .sel(shift[4]), .out(tmp1));
shift_right8  shift_2(.in(tmp1), .sel(shift[3]), .out(tmp2));
shift_right4  shift_3(.in(tmp2), .sel(shift[2]), .out(tmp3));
shift_right2  shift_4(.in(tmp3), .sel(shift[1]), .out(tmp4));
shift_right1  shift_5(.in(tmp4), .sel(shift[0]), .out(out[23:0]));

assign out[24] = in[24];

endmodule

//shift 16bit
module shift_right16(in, out, sel);

input	[23:0]	in;
input		sel;
output	[23:0]	out;

assign out = sel?{16'b0,in[23:16]}:in;
endmodule

//shift 8bit
module shift_right8(in, out, sel);

input	[23:0]	in;
input		sel;
output	[23:0]	out;

assign out = sel?{8'b0,in[23:8]}:in;
endmodule

//shift 4bit
module shift_right4(in, out, sel);

input	[23:0]	in;
input		sel;
output	[23:0]	out;

assign out = sel?{4'b0,in[23:4]}:in;
endmodule

//shift 2bit
module shift_right2(in, out, sel);

input	[23:0]	in;
input		sel;
output	[23:0]	out;

assign out = sel?{2'b0,in[23:2]}:in;
endmodule

//shift 1bit
module shift_right1(in, out, sel);

input	[23:0]	in;
input		sel;
output	[23:0]	out;

assign out = sel?{1'b0,in[23:1]}:in;
endmodule
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
