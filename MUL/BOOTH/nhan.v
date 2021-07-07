//*********************main**********************************
module nhan(a,b,result);

input	wire[31:0]a,b; 
output	wire [31:0]result;
wire	dauC,dauA,dauB;
wire	[7:0]	munho,muout,muC,muA,muB;
wire [47:0]cout;
wire [22:0]tpAB;      // bien de luu gia tri sau khi dich bit 
wire [24:0]tpAB_cd;  // 1 bit chua du 23 bit chua kq A*B
wire [31:0]Inf,C1,kqAB,Zero;
wire [7:0]exAB;
wire [8:0]ex1;wire [7:0]tru;
wire [9:0]ex;
wire [23:0]gtA,gtB;
wire infA,nanA,zeroA,btA,infB,nanB,zeroB,btB,Sign;
wire [31:0]NaN,KQ_NoSign,o1,o2,o3,o4,o5,o6,AxB,AxB1;
assign	dauA = a[31];
assign	muA  = a[30:23];    
assign	gtA = {1'b1,a[22:0]}; 
assign	dauB = b[31];
assign	muB  = b[30:23];
assign	gtB = {1'b1,b[22:0]};
assign Inf=32'b01111111100000000000000000000000; //inf
assign Zero=32'b00000000000000000000000000000000;
assign NaN=32'b01111111111111111111111111111111; 
assign tru= 8'b0000_0001;
assign	Sign = a[31]^b[31];
Multi_CongMu n1(a[31:0],b[31:0],ex[9:0]);
// Nhan Thap Phan 
	nhan_24bit k2(gtA,gtB,cout,tpAB_cd);     
   //assign tpAB_cd[24:0]=out[47:23];
// Dich Thap Phan
	mux2to123bit k3(tpAB_cd[24],tpAB_cd[23:1],tpAB_cd[22:0],tpAB[22:0]);
        cong8bit h1(ex[7:0],tru,ex1[7:0]);
// Xac Dinh Mu
	mux2to1 k4(tpAB_cd[24],ex1[7:0],ex[7:0],exAB[7:0]); // neu co them bit du tang them so mu 

// A Nhan B 
	assign kqAB[31:0]={Sign,exAB[7:0],tpAB[22:0]};   // bien de dat kq cuoi cung 

/* ex[9]=1_Zero | ex[8]=1_Inf | AxB */
//mux2to1kq m5(ex[8],kqAB[31:0],Inf[31:0],o1[31:0]);	//ex[8]=1 => e(A) + e(B) tràn
	//mux2to1kq m6(ex[9],o1[31:0],Zero[31:0],AxB[31:0]);	//ex[9]=1 => ex(AB)<0

        SpecCase_1 s1(a[31:0],infA,nanA,zeroA,btA);
	SpecCase_1 s2(b[31:0],infB,nanB,zeroB,btB);

	mux2to1kq_1 m52(ex[8],kqAB[31:0],Inf[31:0],C1[31:0]);	// neu tran tren thi ra infinity
	mux2to1kq_1 m62(ex[9],C1[31:0],Zero[31:0],AxB[31:0]);	//neu tran duoi thi zero 
         
       assign o1=btB?AxB1:b;
        mux2to1kq_1 m_1(btB,b[31:0],AxB[31:0],o1[31:0]);
	mux2to1kq_1 m_2(zeroB,Inf[31:0],Zero[31:0],o2[31:0]);
	mux2to1kq_1 m_3(nanB,o2[31:0],NaN[31:0],o3[31:0]);
	mux2to1kq_1 m_4(infA,o1[31:0],o3[31:0],o4[31:0]);
	mux2to1kq_1 m_9(nanB,Zero[31:0],NaN[31:0],o5[31:0]);
	mux2to1kq_1 m_10(zeroA,o4[31:0],o5[31:0],o6[31:0]);
	mux2to1kq_1 m_7(nanA,o6[31:0],NaN[31:0],KQ_NoSign[31:0]);	
	assign result[31:0]=KQ_NoSign[31:0];

endmodule
//*********************************cong1bitFA***********************
module FA_1(a, b, cin, s ,cout);
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
//***********************cong8bit**********************************
module cong8bit(in1, in2, S, Cout);//bo cong 8bit
  input [7:0] in1, in2;
  output [8:0] S;
  output Cout;
  wire [7:1] temp;
  wire Cout;
  FA_1 A_0(in1[0], in2[0], 1'b0, S[0], temp[1]);
  FA_1 A_1(in1[1],in2[1], temp[1], S[1], temp[2]);
  FA_1 A_2(in1[2], in2[2], temp[2], S[2], temp[3]);
  FA_1 A_3(in1[3], in2[3], temp[3], S[3], temp[4]);
  FA_1 A_4(in1[4], in2[4], temp[4], S[4], temp[5]);
  FA_1 A_5(in1[5], in2[5], temp[5], S[5], temp[6]);
  FA_1 A_6(in1[6], in2[6], temp[6],S[6], temp[7]);
  FA_1 A_7(in1[7], in2[7],temp[7], S[7], Cout);
  assign S[8] = Cout;
 
endmodule
//*********************************multi_CongMu********************
module Multi_tru9bit(in1,in2,sub,cout); // in1 - in2 = {cout,sub}
	input [8:0]in1,in2;
	output [9:0]sub;
	output cout;
	
	wire [8:0] c;
	
  Tru1bit_1 T[8:0] (.a (in1[8:0]), .b (in2[8:0]), .cin ({c[7:0],1'b0}), .cout (c[8:0]), .s (sub[8:0]));
	
  assign cout = c[8];
  assign sub[9] = cout;
	
	
endmodule
module Multi_CongMu(A,B,ex);
	input [31:0]A,B;
	output [9:0]ex;
	wire [8:0]ex1;		
	cong8bit a1(A[30:23],B[30:23],ex1[8:0],/**/);
	Multi_tru9bit a2(ex1[8:0],9'b001111111,ex[9:0],/**/);  //ex(A) + ex(B) - 127
endmodule 
//***************************mux2to1kq**********************************
module mux2to1kq_1(s,in1,in2,out); //s=0 out=in1 // s=1 out=in2
	input wire s;
	input wire [31:0]in1,in2;
	output wire [31:0]out;
	
	assign out = (s)? in2 : in1;
	
endmodule
module mux2to123bit(s,in1,in2,out); //s=0 out=in1 // s=1 out=in2
	input wire s;
	input wire [22:0]in1,in2;
	output wire [22:0]out;
	
	assign out = (s)? in1 : in2;
	
endmodule
module mux2to1(s,in1,in2,out); //s=0 out=in1 // s=1 out=in2
	input wire s;
	input wire [7:0]in1,in2;
	output wire [7:0]out;
	
	assign out = (s)? in1 : in2;
	
endmodule
//*******************************nhanfrac**********************************
module nhan_24bit(a,b,ketquatruoc,ketqua);
input  [23:0] a,b;
output [47:0] ketquatruoc;
output [24:0] ketqua;
wire [47:0]X[24:1];
wire [47:0]S[23:0];

	assign X[1]  = b[0]?{24'b0,a}:48'b0;
	assign X[2] = b[1]?{23'b0,a,1'b0}:48'b0;
adder_48bit add1(.in1(X[1]), .in2(X[2]), .Sout(S[1]), .Cout());
        assign X[3]  = b[2]?{22'b0,a,2'b0}:48'b0;
adder_48bit add2(.in1(S[1]), .in2(X[3]), .Sout(S[2]), .Cout());  
        assign X[4]  = b[3]?{21'b0,a,3'b0}:48'b0;
adder_48bit add3(.in1(S[2]), .in2(X[4]), .Sout(S[3]), .Cout());
        assign X[5]  = b[4]?{20'b0,a,4'b0}:48'b0;
adder_48bit add4(.in1(S[3]), .in2(X[5]), .Sout(S[4]), .Cout());
        assign X[6]  = b[5]?{19'b0,a,5'b0}:48'b0;
adder_48bit add5(.in1(S[4]), .in2(X[6]), .Sout(S[5]), .Cout());
        assign X[7]  = b[6]?{18'b0,a,6'b0}:48'b0;
adder_48bit add6(.in1(S[5]), .in2(X[7]), .Sout(S[6]), .Cout());
        assign X[8]  = b[7]?{17'b0,a,7'b0}:48'b0;
adder_48bit add7(.in1(S[6]), .in2(X[8]), .Sout(S[7]), .Cout());
        assign X[9]  = b[8]?{16'b0,a,8'b0}:48'b0;
adder_48bit add8(.in1(S[7]), .in2(X[9]), .Sout(S[8]), .Cout());
        assign X[10] = b[9]?{15'b0,a,9'b0}:48'b0;
adder_48bit add9(.in1(S[8]), .in2(X[10]), .Sout(S[9]), .Cout());
        assign X[11] = b[10]?{14'b0,a,10'b0}:48'b0;
adder_48bit add10(.in1(S[9]), .in2(X[11]), .Sout(S[10]), .Cout());
	assign X[12] = b[11]?{13'b0,a,11'b0}:48'b0;
adder_48bit add11(.in1(S[10]), .in2(X[12]), .Sout(S[11]), .Cout());
        assign X[13] = b[12]?{12'b0,a,12'b0}:48'b0;
adder_48bit add12(.in1(S[11]), .in2(X[13]), .Sout(S[12]), .Cout());
        assign X[14] = b[13]?{11'b0,a,13'b0}:48'b0;
adder_48bit add13(.in1(S[12]), .in2(X[14]), .Sout(S[13]), .Cout());
        assign X[15] = b[14]?{10'b0,a,14'b0}:48'b0;
adder_48bit add14(.in1(S[13]), .in2(X[15]), .Sout(S[14]), .Cout());
        assign X[16] = b[15]?{9'b0,a,15'b0}:48'b0;
adder_48bit add15(.in1(S[14]), .in2(X[16]), .Sout(S[15]), .Cout());
        assign X[17] = b[16]?{8'b0,a,16'b0}:48'b0;
adder_48bit add16(.in1(S[15]), .in2(X[17]), .Sout(S[16]), .Cout());
        assign X[18] = b[17]?{7'b0,a,17'b0}:48'b0;
adder_48bit add17(.in1(S[16]), .in2(X[18]), .Sout(S[17]), .Cout());
        assign X[19]= b[18]?{6'b0,a,18'b0}:48'b0;
adder_48bit add18(.in1(S[17]), .in2(X[19]), .Sout(S[18]), .Cout());
        assign X[20] = b[19]?{5'b0,a,19'b0}:48'b0;
adder_48bit add19(.in1(S[18]), .in2(X[20]), .Sout(S[19]), .Cout());
        assign X[21] = b[20]?{4'b0,a,20'b0}:48'b0;
adder_48bit add20(.in1(S[19]), .in2(X[21]), .Sout(S[20]), .Cout());
        assign X[22] = b[21]?{3'b0,a,21'b0}:48'b0;
adder_48bit add21(.in1(S[20]), .in2(X[22]), .Sout(S[21]), .Cout());
        assign X[23] = b[22]?{2'b0,a,22'b0}:48'b0;
adder_48bit add22(.in1(S[21]), .in2(X[23]), .Sout(S[22]), .Cout());
        assign X[24] = b[23]?{1'b0,a,23'b0}:48'b0;
adder_48bit add23(.in1(S[22]), .in2(X[24]), .Sout(S[23]), .Cout()); 
assign ketquatruoc = S[23];
assign ketqua = ketquatruoc[47:23]; //25 bit???
endmodule
  module adder_48bit(in1, in2, Sout, Cout);
input	[47:0]	in1,in2;
output [47:0] Sout;
output			Cout;
wire	[47:0]	S;
wire	[48:1]	temp_c;
FA_1 FA[47:0](in1[47:0],in2[47:0],{temp_c[47:1],1'b0},S[47:0],{Cout,temp_c[47:1]});
assign Sout = S;
endmodule
//*********************************************speccase********************************
module SpecCase_1(in,inf,NaN,zero,bt); // chi xet duong // ko xet dau
	input wire [31:0]in;
	output wire inf,NaN,zero,bt;
	wire [7:0]mu;
	wire [22:0]frac;

	assign mu[7:0]=in[30:23];
	assign frac[22:0]=in[22:0];

	assign zero=(mu[7:0]==8'b0000_0000) ? 1'b1 : 1'b0;
	assign inf=(mu[7:0]==8'b1111_1111) ? ((frac[22:0]==23'b0)? 1'b1 : 1'b0) : 1'b0;
	assign NaN=(mu[7:0]==8'b1111_1111) ? ((frac[22:0]!=23'b0)? 1'b1 : 1'b0) : 1'b0;
	assign bt= ~zero && ~inf && ~NaN;
	
endmodule
//*************************************tru1bit*******************
module Tru1bit_1(a,b,cin,s,cout);
	input a,b,cin;
	output s,cout;
	wire A_xor_B;
	wire not_a, B_or_Cin,c1,c2;

	//tinh s
	xor (A_xor_B, a, b);
	xor (s, cin, A_xor_B);

	//tinh cout
	not (not_a,a);
	or  (B_or_Cin,b,cin);
	and (c1,not_a,B_or_Cin);
	and (c2,b,cin);
	or  (cout,c1,c2);	
endmodule



