//full adder
module FA(a,b,cin,s,cout);

input a, b, cin;
output s, cout;

assign s = a^b^cin;
assign cout = (a&b)|((a^b)&cin);

endmodule
//ripple carry adder 4bits
module RCA4(a,b,cin,S,cout);

input [3:0] a,b;
input cin;
output [3:0] S;
output cout;

wire [3:1] c;

FA FA_0(.a(a[0]), .b(b[0]), .cin(cin), .s(S[0]), .cout(c[1]));
FA FA_1(.a(a[1]), .b(b[1]), .cin(c[1]), .s(S[1]), .cout(c[2]));
FA FA_2(.a(a[2]), .b(b[2]), .cin(c[2]), .s(S[2]), .cout(c[3]));
FA FA_3(.a(a[3]), .b(b[3]), .cin(c[3]), .s(S[3]), .cout(cout));

endmodule
//ripple carry adder 3bit
module RCA3(a,b,cin,S,cout);

input [2:0] a,b;
input cin;
output [2:0] S;
output cout;

wire [2:1] c;

FA FA_0(.a(a[0]), .b(b[0]), .cin(cin), .s(S[0]), .cout(c[1]));
FA FA_1(.a(a[1]), .b(b[1]), .cin(c[1]), .s(S[1]), .cout(c[2]));
FA FA_2(.a(a[2]), .b(b[2]), .cin(c[2]), .s(S[2]), .cout(cout));

endmodule
//ripple carry adder 2bit
module RCA2(a,b,cin,S,cout);

input [1:0] a,b;
input cin;
output [1:0] S;
output cout;

wire c;

FA FA_0(.a(a[0]), .b(b[0]), .cin(cin), .s(S[0]), .cout(c));
FA FA_2(.a(a[1]), .b(b[1]), .cin(c), .s(S[1]), .cout(cout));

endmodule


//skip logic 4bit
module skip_logic4(a, b, cin, cout, cin_next);

input [3:0] a, b;
input cin, cout;
output cin_next;

wire [3:0]p;
wire P,e;

assign p[0] = a[0]|b[0];
assign p[1] = a[1]|b[1];
assign p[2] = a[2]|b[2];
assign p[3] = a[3]|b[3];
assign P = p[0]&p[1]&p[2]&p[3];
assign e = P&cin;
assign cin_next=e|cout;

endmodule

//skip logic 3bit
module skip_logic3(a, b, cin, cout, cin_next);

input [2:0] a, b;
input cin, cout;
output cin_next;

wire [2:0]p;
wire P,e;

assign p[0] = a[0]|b[0];
assign p[1] = a[1]|b[1];
assign p[2] = a[2]|b[2];
assign P = p[0]&p[1]&p[2];
assign e = P&cin;
assign cin_next=e|cout;

endmodule

//skip logic 2bit
module skip_logic2(a, b, cin, cout, cin_next);

input [1:0] a, b;
input cin, cout;
output cin_next;

wire [2:0]p;
wire P,e;

assign p[0] = a[0]|b[0];
assign p[1] = a[1]|b[1];
assign P = p[0]&p[1];
assign e = P&cin;
assign cin_next=e|cout;

endmodule

