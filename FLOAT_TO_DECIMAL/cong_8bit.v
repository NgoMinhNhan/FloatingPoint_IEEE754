module FA (a, b, cin, s ,cout);
input a , b , cin;
output s , cout;
wire a,b,cin;
wire c1,c0;
wire sum,cout,s  ;
half_adder half_adder_00(a , b , c0, sum );
half_adder half_adder_01(sum , cin , c1 , s);
assign cout = c1 | c0;
endmodule
module half_adder (a, b, c, s);
input a,b;
output s,c;
wire a,b,c,s;
assign s = a ^ b;
assign c = a &b;
endmodule
module cong_8bit(  in1,in2  , S , Cout);
input [7:0]in1,in2; 
output [7:0]S ;
output Cout; 
wire [8:1] temp;

FA FA_0(in1[0], in2[0], 1'b0, S[0], temp[1]);
  FA FA_1(in1[1], in2[1], temp[1], S[1], temp[2]);
  FA FA_2(in1[2], in2[2], temp[2], S[2], temp[3]);
  FA FA_3(in1[3], in2[3], temp[3], S[3], temp[4]);
  FA FA_4(in1[4], in2[4], temp[4], S[4], temp[5]);
  FA FA_5(in1[5], in2[5], temp[5], S[5], temp[6]);
  FA FA_6(in1[6], in2[6], temp[6], S[6], temp[7]);
  FA FA_7(in1[7], in2[7], temp[7], S[7], temp[8]);
 
assign Cout=temp[8];
//assign S[8]=Cout;

endmodule 
module chia_4bit(
input [3:0]a,
output [3:0]b,
output c
);
wire [3:0]a1;
assign a1=4'b0101;
FA FA[3:0](.a(a[3:0]), .b(a1[3:0]), .cin(1'b1), .s(b) ,.cout(c) );

endmodule 
module t_bocong;
	reg [7:0]in1;
        reg [7:0]in2;
	wire [7:0]S;
         wire Cout;
       
parameter time_out = 100;
	cong_8bit z(.in1(in1),.in2(in2),.S(S),.Cout(Cout));
      
initial $monitor($time," so in1 %d , so in2 %d so s  %d ,dau  %b  ", in1,in2,S,Cout );
	initial begin

	#0 in1=8'b1000_0000;
           in2=8'b1000_0001;
        #10 in1=8'b0110_1010;
           in2=8'b0000_0111;
        #10 in1=8'b0010_1111;
           in2=8'b0000_0001;
        #10 in1=8'b0111_1111;
           in2=8'b0000_1101;
	
end 
endmodule