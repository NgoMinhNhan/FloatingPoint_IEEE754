//bu2 5bit
module bu2_6bit(in, out);
  input [5:0] in;
  output [5:0] out;
  
  wire [5:0] not_in;
  
  assign not_in=~in;
  adder_6bit add1(.in1(not_in), .in2(6'd1), .S(out), .Cout());
endmodule
//bu 2 8bit
module bu2_8bit(in, out);
  input [7:0] in;
  output [7:0] out;
  
  wire [7:0] not_in;
  
  assign not_in=~in;
  adder_8bit add1(.in1(not_in), .in2(8'd1), .S(out), .Cout());
endmodule
//bu 2 10bit
module bu2_10bit(in, out);
  input [9:0] in;
  output [9:0] out;
  
  wire [9:0] not_in;
  
  assign not_in=~in;
  adder_10bit add1(.in1(not_in), .in2(10'd1), .S(out), .Cout());
endmodule

//bu 2 25bit
module bu2_49bit(in, out);
  input [48:0] in;
  output [48:0] out;
  
  wire [48:0] not_in;
  
  assign not_in=~in;
  adder_49bit add1(.in1(not_in), .in2(49'd1), .S(out), .Cout());
endmodule
