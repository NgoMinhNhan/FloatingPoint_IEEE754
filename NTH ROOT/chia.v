module chia(a,b,result);
	input [31:0]a,b;
	output [31:0]result;
	wire Sign;
	wire [31:0]o1,o2,o3,o4,o5,o6,o7,o8,o9,KQ_NoSign,achiab,Zero,Inf,NaN;
/**/
	assign Inf=32'b01111111100000000000000000000000; 
	assign NaN=32'b01111111111111111111111111111111; 
	assign Zero=32'b00000000000000000000000000000000; 
	SpecCase s1(a[31:0],infA,nanA,zeroA,btA);
	SpecCase s2(b[31:0],infB,nanB,zeroB,btB);
	xor a1(Sign,a[31],b[31]);
	achiab a2(a[31:0],b[31:0],achiab[31:0]);
/*Truong Hop Dac Biet*/
	mux2to1kq m1(zeroB,Zero[31:0],NaN[31:0],o1[31:0]);
	mux2to1kq m2(nanB,o1[31:0],NaN[31:0],o2[31:0]);
	mux2to1kq m3(infB,Inf[31:0],NaN[31:0],o3[31:0]);
	mux2to1kq m4(nanB,o3[31:0],NaN[31:0],o4[31:0]);
	mux2to1kq m5(infB,achiab[31:0],Zero[31:0],o5[31:0]);
	mux2to1kq m6(zeroB,o5[31:0],Inf[31:0],o6[31:0]);
	mux2to1kq m7(nanB,o6[31:0],NaN[31:0],o7[31:0]);
	mux2to1kq m8(infA,o7[31:0],o4[31:0],o8[31:0]);
	mux2to1kq m9(zeroA,o8[31:0],o2[31:0],o9[31:0]);
	mux2to1kq m0(nanA,o9[31:0],NaN[31:0],KQ_NoSign[31:0]);
	assign result[31:0]={Sign,KQ_NoSign[30:0]};
endmodule
//**************************achiab****************************************
module achiab(A,B,KQ); // Chi Xet Duong
	input [31:0]A,B;
	output [31:0]KQ;
	wire [31:0]Inf,Zero,NaN;
	wire [9:0]ex,ex1;
	wire [22:0]tpAB;
	wire [23:0]Thuong;
	wire [31:0]p1,kqAB;
	wire [7:0]exAB;
        wire [23:0] A1,B1;
        wire Sign;
	wire [31:0]o1,o2,o3,o4,o5,o6,o7,o8,o9,KQ_NoSign,achiab;
/**/ 
	assign Inf=32'b01111111100000000000000000000000; //inf
	assign Zero=32'b00000000000000000000000000000000;
        assign NaN=32'b01111111111111111111111111111111;
/*Tru Mu*/
	Div_TruMu a1(A[30:23],B[30:23],ex[9:0]); // mu a tru mu b cong 127
/*Giam Mu Di 1*/
	tru10bit a2(ex[9:0],10'b1,ex1[9:0]);
/*Chia Thap Phan*/
       assign A1[23:0]={1'b1,A[22:0]};
	assign B1[23:0]={1'b1,B[22:0]};
	chia_25bit a3(A1[23:0],B1[23:0],Thuong[23:0]);
/*Dich Thap Phan*/
	mux2to1kq a4(Thuong[23],{Thuong[21:0],1'b0},Thuong[22:0],tpAB[22:0]);
/*Xac Dinh Mu*/
	mux2to1kq a5(Thuong[23],ex1[7:0],ex[7:0],exAB[7:0]);
/*A Chia B*/
	assign kqAB[31:0]={1'b0,exAB[7:0],tpAB[22:0]};
/*ex[9]=1 Zero | ex[8]=1 Inf | aChiab*/
	mux2to1kq a6(ex[8],kqAB[31:0],Inf[31:0],p1[31:0]);
	mux2to1kq a7(ex[9],p1[31:0],Zero[31:0],achiab[31:0]);	


/**/
	SpecCase s1(A[31:0],infA,nanA,zeroA,btA);
	SpecCase s2(B[31:0],infB,nanB,zeroB,btB);
	xor b1(Sign,A[31],B[31]);
	
/*Truong Hop Dac Biet*/
	mux2to1kq m1(zeroB,Zero[31:0],NaN[31:0],o1[31:0]);
	mux2to1kq m2(nanB,o1[31:0],NaN[31:0],o2[31:0]);
	mux2to1kq m3(infB,Inf[31:0],NaN[31:0],o3[31:0]);
	mux2to1kq m4(nanB,o3[31:0],NaN[31:0],o4[31:0]);
	mux2to1kq m5(infB,achiab[31:0],Zero[31:0],o5[31:0]);
	mux2to1kq m6(zeroB,o5[31:0],Inf[31:0],o6[31:0]);
	mux2to1kq m7(nanB,o6[31:0],NaN[31:0],o7[31:0]);
	mux2to1kq m8(infA,o7[31:0],o4[31:0],o8[31:0]);
	mux2to1kq m9(zeroA,o8[31:0],o2[31:0],o9[31:0]);
	mux2to1kq m0(nanA,o9[31:0],NaN[31:0],KQ_NoSign[31:0]);
	assign KQ[31:0]={Sign,KQ_NoSign[30:0]};

endmodule

//*************************************chia25bit***********************************
module chia_25bit  (a, b, ketqua);
input  [23:0] a,b;
output [23:0] ketqua;
wire [23:0]C; 
wire [24:0] ab1, ab2, ab3, ab4, ab5, ab6, ab7, ab8, ab9, ab10, ab11, ab12, ab13, ab14, ab15, ab16, ab17, ab18, ab19, ab20, ab21, ab22, ab23;
wire [24:0] frac[23:0];
sosanhfrac sosanh1 (.a({1'b0,a}), .b({1'b0,b}), .C1(C[23]));
assign frac[1]=C[23]?{1'b0,b}:25'b0;
tru_25bit tru0 (.a({1'b0,a}),.b(frac[1]),.ab(ab1));

sosanhfrac sosanh2 (.a({ab1[23:0],1'b0}), .b({1'b0,b}), .C1(C[22]));
assign frac[2]=C[22]?{1'b0,b}:25'b0;
tru_25bit tru1 (.a({ab1[23:0],1'b0}),.b(frac[2]),.ab(ab2) );

sosanhfrac sosanh3 (.a({ab2[23:0],1'b0}), .b({1'b0,b}), .C1(C[21]));
assign frac[3]=C[21]?{1'b0,b}:25'b0;
tru_25bit tru2 (.a({ab2[23:0],1'b0}),.b(frac[3]),.ab(ab3));

sosanhfrac sosanh4 (.a({ab3[23:0],1'b0}), .b({1'b0,b}), .C1(C[20]));
assign frac[4]=C[20]?{1'b0,b}:25'b0;
tru_25bit tru3 (.a({ab3[23:0],1'b0}),.b(frac[4]),.ab(ab4));

sosanhfrac sosanh5 (.a({ab4[23:0],1'b0}), .b({1'b0,b}), .C1(C[19]));
assign frac[5]=C[19]?{1'b0,b}:25'b0;
tru_25bit tru4 (.a({ab4[23:0],1'b0}),.b(frac[5]),.ab(ab5));

sosanhfrac sosanh6 (.a({ab5[23:0],1'b0}), .b({1'b0,b}), .C1(C[18]));
assign frac[6]=C[18]?{1'b0,b}:25'b0;
tru_25bit tru5 (.a({ab5[23:0],1'b0}),.b(frac[6]),.ab(ab6));

sosanhfrac sosanh7 (.a({ab6[23:0],1'b0}), .b({1'b0,b}), .C1(C[17]));
assign frac[7]=C[17]?{1'b0,b}:25'b0;
tru_25bit tru6 (.a({ab6[23:0],1'b0}),.b(frac[7]),.ab(ab7));

sosanhfrac sosanh8 (.a({ab7[23:0],1'b0}), .b({1'b0,b}), .C1(C[16]));
assign frac[8]=C[16]?{1'b0,b}:25'b0;
tru_25bit tru7 (.a({ab7[23:0],1'b0}),.b(frac[8]),.ab(ab8));

sosanhfrac sosanh9 (.a({ab8[23:0],1'b0}), .b({1'b0,b}), .C1(C[15]));
assign frac[9]=C[15]?{1'b0,b}:25'b0;
tru_25bit tru8 (.a({ab8[23:0],1'b0}),.b(frac[9]),.ab(ab9));

sosanhfrac sosanh10 (.a({ab9[23:0],1'b0}), .b({1'b0,b}), .C1(C[14]));
assign frac[10]=C[14]?{1'b0,b}:25'b0;
tru_25bit tru9 (.a({ab9[23:0],1'b0}),.b(frac[10]),.ab(ab10));

sosanhfrac sosanh11 (.a({ab10[23:0],1'b0}), .b({1'b0,b}), .C1(C[13]));
assign frac[11]=C[13]?{1'b0,b}:25'b0;
tru_25bit tru10 (.a({ab10[23:0],1'b0}),.b(frac[11]),.ab(ab11));

sosanhfrac sosanh12 (.a({ab11[23:0],1'b0}), .b({1'b0,b}), .C1(C[12]));
assign frac[12]=C[12]?{1'b0,b}:25'b0;
tru_25bit tru11 (.a({ab11[23:0],1'b0}),.b(frac[12]),.ab(ab12));

sosanhfrac sosanh13 (.a({ab12[23:0],1'b0}), .b({1'b0,b}), .C1(C[11]));
assign frac[13]=C[11]?{1'b0,b}:25'b0;
tru_25bit tru12 (.a({ab12[23:0],1'b0}),.b(frac[13]),.ab(ab13));

sosanhfrac sosanh14 (.a({ab13[23:0],1'b0}), .b({1'b0,b}), .C1(C[10]));
assign frac[14]=C[10]?{1'b0,b}:25'b0;
tru_25bit tru13 (.a({ab13[23:0],1'b0}),.b(frac[14]),.ab(ab14));

sosanhfrac sosanh15 (.a({ab14[23:0],1'b0}), .b({1'b0,b}), .C1(C[9]));
assign frac[15]=C[9]?{1'b0,b}:25'b0;
tru_25bit tru14 (.a({ab14[23:0],1'b0}),.b(frac[15]),.ab(ab15));

sosanhfrac sosanh16 (.a({ab15[23:0],1'b0}), .b({1'b0,b}), .C1(C[8]));
assign frac[16]=C[8]?{1'b0,b}:25'b0;
tru_25bit tru15 (.a({ab15[23:0],1'b0}),.b(frac[16]),.ab(ab16));

sosanhfrac sosanh17 (.a({ab16[23:0],1'b0}), .b({1'b0,b}), .C1(C[7]));
assign frac[17]=C[7]?{1'b0,b}:25'b0;
tru_25bit tru16 (.a({ab16[23:0],1'b0}),.b(frac[17]),.ab(ab17));

sosanhfrac sosanh18 (.a({ab17[23:0],1'b0}), .b({1'b0,b}), .C1(C[6]));
assign frac[18]=C[6]?{1'b0,b}:25'b0;
tru_25bit tru17 (.a({ab17[23:0],1'b0}),.b(frac[18]),.ab(ab18));

sosanhfrac sosanh19 (.a({ab18[23:0],1'b0}), .b({1'b0,b}), .C1(C[5]));
assign frac[19]=C[5]?{1'b0,b}:25'b0;
tru_25bit tru18 (.a({ab18[23:0],1'b0}),.b(frac[19]),.ab(ab19));

sosanhfrac sosanh20 (.a({ab19[23:0],1'b0}), .b({1'b0,b}), .C1(C[4]));
assign frac[20]=C[4]?{1'b0,b}:25'b0;
tru_25bit tru19 (.a({ab19[23:0],1'b0}),.b(frac[20]),.ab(ab20));

sosanhfrac sosanh21 (.a({ab20[23:0],1'b0}), .b({1'b0,b}), .C1(C[3]));
assign frac[21]=C[3]?{1'b0,b}:25'b0;
tru_25bit tru20 (.a({ab20[23:0],1'b0}),.b(frac[21]),.ab(ab21));

sosanhfrac sosanh22 (.a({ab21[23:0],1'b0}), .b({1'b0,b}), .C1(C[2]));
assign frac[22]=C[2]?{1'b0,b}:25'b0;
tru_25bit tru21 (.a({ab21[23:0],1'b0}),.b(frac[22]),.ab(ab22));

sosanhfrac sosanh23 (.a({ab22[23:0],1'b0}), .b({1'b0,b}), .C1(C[1]));
assign frac[23]=C[1]?{1'b0,b}:25'b0;
tru_25bit tru22 (.a({ab22[23:0],1'b0}),.b(frac[23]),.ab(ab23));

sosanhfrac sosanh24 (.a({ab23[23:0],1'b0}), .b({1'b0,b}), .C1(C[0]));

assign ketqua = {C[23],C[22],C[21],C[20],C[19],C[18],C[17],C[16],C[15],C[14],C[13],C[12],C[11],C[10],C[9],C[8],C[7],C[6],C[5],C[4],C[3],C[2],C[1],C[0]};
endmodule 
//*******************************************div_trumu****************************************
module Div_tru8bit(in1,in2,sub,cout); // in1 - in2 = {cout,sub}
	input [8:0]in1,in2;
	output [9:0]sub;
	output cout;
	wire [8:0] c;

	Tru1bit T[8:0] (.a (in1[8:0]), .b (in2[8:0]), .cin ({c[7:0],1'b0}), .cout (c[8:0]), .s (sub[8:0]));
 	assign cout = c[8];	
	assign sub[9]=cout;
endmodule

module Div_cong9bit(in1,in2,sum,cout);
	input [9:0] in1;
  	input [9:0] in2;  
  	output [9:0] sum;
  	output cout;  
 	
	wire [9:0] c;
	
  FA_2 FA_111[9:0] (.in1 (in1[9:0]), .in2 (in2[9:0]), .cin ({c[8:0],1'b0}), .cout (c[9:0]), .sum (sum[9:0]));
	
  assign cout = c[9];
 
endmodule
/**/
module Div_TruMu(muA,muB,out);
	input [7:0]muA,muB;
	output [9:0]out;
	wire [9:0]sub;
	wire [8:0]muAA,muBB;
	assign muAA[8:0]={1'b0,muA[7:0]};
	assign muBB[8:0]={1'b0,muB[7:0]};
	Div_tru8bit a(muAA[8:0],muBB[8:0],sub[9:0],/**/);
	Div_cong9bit b(sub[9:0],10'b0001111111,out[9:0],/**/);
endmodule
module FA_2(in1,in2,cin,sum,cout);  //cong1bit
  input wire in1;
  input wire in2;
  input wire cin;
  output wire sum;
  output wire cout;  
  wire temp1, temp2, temp3;

  xor(sum,in1,in2,cin);
  and(temp1,in1,in2);
  and(temp2,in1,cin);
  and(temp3,in2,cin);
  or(cout,temp1,temp2,temp3);
endmodule
//*************************mux2to1***********************************************
module mux2to1kq(s,in1,in2,out); //s=0 out=in1 // s=1 out=in2
	input wire s;
	input wire [31:0]in1,in2;
	output wire [31:0]out;
	
	assign out = (s)? in2 : in1;
	
endmodule
//********************************sosanh*******************************************
module sosanhfrac (a,b,C1);
input  [24:0]a,b;
output reg C1;

wire [24:0]d;
always @(*)
if(b>a)
 C1<=1'b0;
else
C1<=1'b1;
endmodule
//*************************************speccase******************************************
module SpecCase(in,inf,NaN,zero,bt); // chi xet duong // ko xet dau
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
//******************************tru_25bit****************************************
module tru_25bit (a, b, ab);
 input 	[24:0] a;
 input 	[24:0] b;
 output [24:0] ab;
 wire [24:0] C;
 wire [24:0] temp1, temp2, S1;
 assign temp1 = a;
 assign temp2 = ~b;
FA1bit  FA[24:0] ( temp1[24:0], temp2[24:0], {C[23:0],1'b1}, C[24:0], S1[24:0]);

assign ab = S1;
endmodule

module FA1bit ( a, b, cin, cout, s);
 input 	a, b, cin;
 output cout, s;
 assign s = a ^ b ^ cin;
 assign cout = a & b | ( cin & ( a ^ b));
endmodule
//*******************************************tru1bit**************************************
module Tru1bit(a,b,cin,s,cout);
	input a,b,cin;
	output s,cout;
	wire A_xor_B;
	wire not_a, B_or_Cin,c1,c2;
	/* tinh s */
	//xor 
         assign A_xor_B=a^b;
	//xor 
        assign s=cin^A_xor_B;
	/* tinh cout */
	 //not 
       assign not_a=!a;
	//or  
         assign B_or_Cin=b|cin;
	//and 
        assign c1=not_a & B_or_Cin;
	//and 
        assign c2=b & cin ;
	//or  	
         assign cout = c1|c2;
endmodule
//******************************tru10bit*********************************************
module tru10bit(in1,in2,sub,cout); // in1 - in2 = {cout,sub}
	input [9:0]in1,in2;
	output [9:0]sub;
	output cout;
	wire [9:0] c;

	Tru1bit T[9:0] (.a (in1[9:0]), .b (in2[9:0]), .cin ({c[8:0],1'b0}), .cout (c[9:0]), .s (sub[9:0]));
 	assign cout = c[9];	
endmodule
//*******************************************************************