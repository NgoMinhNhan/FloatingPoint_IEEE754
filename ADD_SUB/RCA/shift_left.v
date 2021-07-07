module shift_left(in, out, shift);
  input [24:0] in;
  input [4:0] shift;
  input [24:0] out;
  
  wire [24:0] tmp1, tmp2, tmp3, tmp4;
  
  shift_left16 shift_1(.in(in), .sel(shift[4]), .out(tmp1));
  shift_left8 shift_2(.in(tmp1), .sel(shift[3]), .out(tmp2));
  shift_left4 shift_3(.in(tmp2), .sel(shift[2]), .out(tmp3));
  shift_left2 shift_4(.in(tmp3), .sel(shift[1]), .out(tmp4));
  shift_left1 shift_5(.in(tmp4), .sel(shift[0]), .out(out));
  
endmodule  
  
  
//shift 16bit
module shift_left16(in, out, sel);

input	[24:0]	in;
input		sel;
output	[24:0]	out;

assign out = sel?{in[8:0],16'b0}:in;
endmodule

//shift 8bit
module shift_left8(in, out, sel);

input	[24:0]	in;
input		sel;
output	[24:0]	out;

assign out = sel?{in[16:0],8'b0}:in;
endmodule

//shift 4bit
module shift_left4(in, out, sel);

input	[24:0]	in;
input		sel;
output	[24:0]	out;

assign out = sel?{in[20:0],4'b0}:in;
endmodule

//shift 2bit
module shift_left2(in, out, sel);

input	[24:0]	in;
input		sel;
output	[24:0]	out;

assign out = sel?{in[22:0],2'b0}:in;
endmodule

//shift 1bit
module shift_left1(in, out, sel);

input	[24:0]	in;
input		sel;
output	[24:0]	out;

assign out = sel?{in[23:0],1'b0}:in;
endmodule
