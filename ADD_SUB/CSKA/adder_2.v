//carry_skip_adder 8bit
`include "carry_skip_adder.v"
module adder_8bit(in1,in2,S,Cout);

input [7:0] in1,in2;
output [7:0] S;
output Cout;

wire cout0, cout1, e;

RCA4 add1(.a(in1[3:0]),.b(in2[3:0]), .cin(1'b0), .S(S[3:0]), .cout(cout0));
RCA4 add2(.a(in1[7:4]),.b(in2[7:4]), .cin(e), .S(S[7:4]), .cout(cout1));

skip_logic4 skip1(.a(in1[3:0]), .b(in2[3:0]), .cin(1'b0), .cout(cout0), .cin_next(e));
skip_logic4 skip2(.a(in1[7:4]), .b(in2[7:4]), .cin(e), .cout(cout1), .cin_next(Cout));
 
endmodule

//carry_skip_adder 9bit
module adder_9bit(in1,in2,S,Cout);

input [8:0] in1,in2;
output [8:0] S;
output Cout;

wire cout0, cout1, cout2, e1, e2;

RCA4 add1(.a(in1[3:0]),.b(in2[3:0]), .cin(1'b0), .S(S[3:0]), .cout(cout0));
RCA3 add2(.a(in1[6:4]),.b(in2[6:4]), .cin(e1), .S(S[6:4]), .cout(cout1));
RCA2 add3(.a(in1[8:7]),.b(in2[8:7]), .cin(e2), .S(S[8:7]), .cout(cout2));

skip_logic4 skip1(.a(in1[3:0]), .b(in2[3:0]), .cin(1'b0), .cout(cout0), .cin_next(e1));
skip_logic3 skip2(.a(in1[6:4]), .b(in2[6:4]), .cin(e1), .cout(cout1), .cin_next(e2));
skip_logic2 skip3(.a(in1[8:7]), .b(in2[8:7]), .cin(e2), .cout(cout2), .cin_next(Cout));
 
endmodule
//carry_skip_adder 10bit
module adder_10bit(in1,in2,S,Cout);

input [9:0] in1,in2;
output [9:0] S;
output Cout;

wire cout0, cout1, cout2, e1, e2;

RCA4 add1(.a(in1[3:0]),.b(in2[3:0]), .cin(1'b0), .S(S[3:0]), .cout(cout0));
RCA4 add2(.a(in1[7:4]),.b(in2[7:4]), .cin(e1), .S(S[7:4]), .cout(cout1));
RCA2 add3(.a(in1[9:8]),.b(in2[9:8]), .cin(e2), .S(S[9:8]), .cout(cout2));

skip_logic4 skip1(.a(in1[3:0]), .b(in2[3:0]), .cin(1'b0), .cout(cout0), .cin_next(e1));
skip_logic4 skip2(.a(in1[7:4]), .b(in2[7:4]), .cin(e1), .cout(cout1), .cin_next(e2));
skip_logic2 skip3(.a(in1[9:8]), .b(in2[9:8]), .cin(e2), .cout(cout2), .cin_next(Cout)); 

endmodule
//carry_skip_adder 25bit
module adder_25bit(in1,in2,S,Cout);

input [24:0] in1,in2;
output [24:0] S;
output Cout;

wire [6:0] cout;
wire [5:0] e;

RCA4 add1(.a(in1[3:0]),.b(in2[3:0]), .cin(1'b0), .S(S[3:0]), .cout(cout[0]));
RCA4 add2(.a(in1[7:4]),.b(in2[7:4]), .cin(e[0]), .S(S[7:4]), .cout(cout[1]));
RCA4 add3(.a(in1[11:8]),.b(in2[11:8]), .cin(e[1]), .S(S[11:8]), .cout(cout[2]));
RCA4 add4(.a(in1[15:12]),.b(in2[15:12]), .cin(e[2]), .S(S[15:12]), .cout(cout[3]));
RCA4 add5(.a(in1[19:16]),.b(in2[19:16]), .cin(e[3]), .S(S[19:16]), .cout(cout[4]));
RCA3 add6(.a(in1[22:20]),.b(in2[22:20]), .cin(e[4]), .S(S[22:20]), .cout(cout[5]));
RCA2 add7(.a(in1[24:23]),.b(in2[24:23]), .cin(e[5]), .S(S[24:23]), .cout(cout[6]));


skip_logic4 skip1(.a(in1[3:0]), .b(in2[3:0]), .cin(1'b0), .cout(cout[0]), .cin_next(e[0]));
skip_logic4 skip2(.a(in1[7:4]), .b(in2[7:4]), .cin(e[0]), .cout(cout[1]), .cin_next(e[1]));
skip_logic4 skip3(.a(in1[11:8]), .b(in2[11:8]), .cin(e[1]), .cout(cout[2]), .cin_next(e[2]));
skip_logic4 skip4(.a(in1[15:12]), .b(in2[15:12]), .cin(e[2]), .cout(cout[3]), .cin_next(e[3]));
skip_logic4 skip5(.a(in1[19:16]), .b(in2[19:16]), .cin(e[3]), .cout(cout[4]), .cin_next(e[4]));
skip_logic3 skip6(.a(in1[22:20]), .b(in2[22:20]), .cin(e[4]), .cout(cout[5]), .cin_next(e[5]));
skip_logic2 skip7(.a(in1[24:23]), .b(in2[24:23]), .cin(e[5]), .cout(cout[6]), .cin_next(Cout));
endmodule
//carry_skip_adder 26bit
module adder_26bit(in1,in2,S,Cout);

input [25:0] in1,in2;
output [25:0] S;
output Cout;

wire [6:0] cout;
wire [5:0] e;

RCA4 add1(.a(in1[3:0]),.b(in2[3:0]), .cin(1'b0), .S(S[3:0]), .cout(cout[0]));
RCA4 add2(.a(in1[7:4]),.b(in2[7:4]), .cin(e[0]), .S(S[7:4]), .cout(cout[1]));
RCA4 add3(.a(in1[11:8]),.b(in2[11:8]), .cin(e[1]), .S(S[11:8]), .cout(cout[2]));
RCA4 add4(.a(in1[15:12]),.b(in2[15:12]), .cin(e[2]), .S(S[15:12]), .cout(cout[3]));
RCA4 add5(.a(in1[19:16]),.b(in2[19:16]), .cin(e[3]), .S(S[19:16]), .cout(cout[4]));
RCA4 add6(.a(in1[23:20]),.b(in2[23:20]), .cin(e[4]), .S(S[23:20]), .cout(cout[5]));
RCA2 add7(.a(in1[25:24]),.b(in2[25:24]), .cin(e[5]), .S(S[25:24]), .cout(cout[6]));

skip_logic4 skip1(.a(in1[3:0]), .b(in2[3:0]), .cin(1'b0), .cout(cout[0]), .cin_next(e[0]));
skip_logic4 skip2(.a(in1[7:4]), .b(in2[7:4]), .cin(e[0]), .cout(cout[1]), .cin_next(e[1]));
skip_logic4 skip3(.a(in1[11:8]), .b(in2[11:8]), .cin(e[1]), .cout(cout[2]), .cin_next(e[2]));
skip_logic4 skip4(.a(in1[15:12]), .b(in2[15:12]), .cin(e[2]), .cout(cout[3]), .cin_next(e[3]));
skip_logic4 skip5(.a(in1[19:16]), .b(in2[19:16]), .cin(e[3]), .cout(cout[4]), .cin_next(e[4]));
skip_logic4 skip6(.a(in1[23:20]), .b(in2[23:20]), .cin(e[4]), .cout(cout[5]), .cin_next(e[5]));
skip_logic2 skip7(.a(in1[25:24]), .b(in2[25:24]), .cin(e[5]), .cout(cout[6]), .cin_next(Cout));
endmodule
