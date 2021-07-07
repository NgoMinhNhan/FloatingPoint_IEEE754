//bu 2 8bit
module bu2_8bit(in, out);
  input [7:0] in;
  output [7:0] out;
  
  wire [7:0] not_in;
  
  assign not_in=~in;
  adder_8bit add1(.in1(not_in), .in2(8'd1), .S(out), .Cout());
endmodule
//bu 2 9bit
module bu2_9bit(in, out);
  input [8:0] in;
  output [8:0] out;
  
  wire [8:0] not_in;
  
  assign not_in=~in;
  adder_9bit add1(.in1(not_in), .in2(9'd1), .S(out), .Cout());
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
module bu2_25bit(in, out);
  input [24:0] in;
  output [24:0] out;
  
  wire [24:0] not_in;
  
  assign not_in=~in;
  adder_25bit add1(.in1(not_in), .in2(25'd1), .S(out), .Cout());
endmodule
