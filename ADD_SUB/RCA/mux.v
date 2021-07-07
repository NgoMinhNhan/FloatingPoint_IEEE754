//mux8
module mux8(in1, in2, sel, out);
  input [7:0] in1, in2;
  input sel;
  output [7:0] out;
  
  assign out = sel?in2:in1;
  
endmodule
/////////////////////////
//mux25
module mux25(in1, in2, sel, out);
  input [24:0] in1, in2;
  input sel;
  output [24:0] out;
  
  assign out = sel?in2:in1;
  
endmodule
