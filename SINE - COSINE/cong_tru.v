module cong_tru(A,B,Out,Operation);

//Mô tả ngõ vào
input	[31:0]	A,B;
input			Operation;			//bit phép tính (cong = 0, tru = 1)
wire			overflow,underflow;
output	[31:0]	Out;

wire			signA,signB,exA_ST_exB,check_qualon,check_zero;
wire	[4:0]	nshift,nshiftleft;
wire	[7:0]	expA,expB,exp_out,exp_result;
wire	[9:0]	temp_exp,shiftleft_out,temp_shiftleft_out;
wire	[22:0]	frac_result;
wire	[23:0]	fracA,fracB;
wire	[24:0]	frac_out1,frac_out2,frac_out3,frac1,frac3,frac,frac_out,frac_before_result,frac_before_result2;
wire	[25:0]	frac1_beforeadd,frac2_beforeadd,frac_afteradd;

//Trích xuất sign, exponent, frac
assign	signA	= A[31];
assign	signB	= B[31]^Operation;
assign	expA	= A[30:23];
assign	expB	= B[30:23];
assign	fracA	= {1'B1,A[22:0]};
assign	fracB	= {1'B1,B[22:0]};

//So sánh 2 exponent 
sosanh_8bit compare_expAandexpB(.in1(expA), .in2(expB), .shift(nshift), .in1_sub_in2(exA_ST_exB), .check_qualon(check_qualon));

//Xuất exponent lớn
mux8 select_exponent(.in1(expA), .in2(expB), .sel(exA_ST_exB), .out(exp_out));

//Chọn frac dịch và không dịch
mux25 find_fraction_noshift(.in1({signA,fracA}), .in2({signB,fracB}), .sel(exA_ST_exB), .out(frac_out1));
mux25 find_fraction_shift(.in1({signB,fracB}), .in2({signA,fracA}), .sel(exA_ST_exB), .out(frac_out2));
shift_right shift_fraction(.in(frac_out2), .shift(nshift), .out(frac_out3));

//Nếu là số âm thì thực hiện bù 2
bu2_25bit compli2_fraction1(.in({1'b0,frac_out1[23:0]}), .out(frac1));
bu2_25bit compli2_fraction2(.in({1'b0,frac_out3[23:0]}), .out(frac3));

assign frac1_beforeadd = frac_out1[24]?{1'b1,frac1}:{2'b00,frac_out1[23:0]};
assign frac2_beforeadd = frac_out2[24]?{1'b1,frac3}:{2'b00,frac_out3[23:0]};

//Thực hiện tính toán
adder_26bit add_1(.in1(frac1_beforeadd), .in2(frac2_beforeadd), .S(frac_afteradd), .Cout());

bu2_25bit bu2_frac(.in(frac_afteradd[24:0]), .out(frac_out));

assign frac = frac_afteradd[25]?frac_out:frac_afteradd[24:0];

assign sign_result = frac_afteradd[25];

//Tìm vị trí số 1 dầu tiên từ bit[23] qua phải
tim_bit1 find_1_in_frac(.in(frac), .shiftleft(nshiftleft), .check_zero(check_zero));
shift_left shift_frac(.in(frac), .shift(nshiftleft), .out(frac_before_result));

//Trường hợp số 1 nằm vì trị 24
shift_right shift_fraction1(.in(frac), .shift(5'd1), .out(frac_before_result2));

assign frac_result = frac[24]?frac_before_result2[22:0]:frac_before_result[22:0];

bu2_10bit compli2_exponent(.in({5'b0,nshiftleft}),.out(temp_shiftleftout));

assign shiftleftout = frac[24]?10'b1:temp_shiftleftout;

//NORMALIZE
adder_10bit	add_2(.in1(shiftleftout), .in2({2'b00,exp_out}), .S(temp_exp), .Cout());

assign underflow = temp_exp[9]&temp_exp[8];
assign overflow = ~temp_exp[9]&(temp_exp[8]|(&({temp_exp[7:0]})));

assign exp_result = temp_exp[8]?8'd0:(check_zero?8'd0:temp_exp[7:0]);

xuatketqua export1(.in1(A), .in2(B), .temp_result({sign_result,exp_result,frac_result}), .qualon({exA_ST_exB,check_qualon}), .result(Out));

endmodule
//*****************************************************full_adder***************************************************************
module FA(a, b, cin, S, cout); //bo cong full adder
  input a,b,cin;
  output S,cout;
  
  assign S=a^b^cin;
  assign cout=((a&b)|(cin&(a^b)));
  
endmodule


//adder 8bit
module adder_8bit(in1, in2, S, Cout);//bo cong 8 bit
  input [7:0] in1, in2;
  output [7:0] S;
  output Cout;
  
  wire [7:1] temp;
  
  FA FA_0(.a(in1[0]), .b(in2[0]), .cin(1'b0), .S(S[0]), .cout(temp[1]));
  FA FA_1(.a(in1[1]), .b(in2[1]), .cin(temp[1]), .S(S[1]), .cout(temp[2]));
  FA FA_2(.a(in1[2]), .b(in2[2]), .cin(temp[2]), .S(S[2]), .cout(temp[3]));
  FA FA_3(.a(in1[3]), .b(in2[3]), .cin(temp[3]), .S(S[3]), .cout(temp[4]));
  FA FA_4(.a(in1[4]), .b(in2[4]), .cin(temp[4]), .S(S[4]), .cout(temp[5]));
  FA FA_5(.a(in1[5]), .b(in2[5]), .cin(temp[5]), .S(S[5]), .cout(temp[6]));
  FA FA_6(.a(in1[6]), .b(in2[6]), .cin(temp[6]), .S(S[6]), .cout(temp[7]));
  FA FA_7(.a(in1[7]), .b(in2[7]), .cin(temp[7]), .S(S[7]), .cout(Cout));
endmodule 
//adder 9bit
module adder_9bit(in1, in2, S, Cout);//bo cong 9bit
  input [8:0] in1, in2;
  output [8:0] S;
  output Cout;
  
  wire [8:1] temp;
 
  FA FA_0(.a(in1[0]), .b(in2[0]), .cin(1'b0), .S(S[0]), .cout(temp[1]));
  FA FA_1(.a(in1[1]), .b(in2[1]), .cin(temp[1]), .S(S[1]), .cout(temp[2]));
  FA FA_2(.a(in1[2]), .b(in2[2]), .cin(temp[2]), .S(S[2]), .cout(temp[3]));
  FA FA_3(.a(in1[3]), .b(in2[3]), .cin(temp[3]), .S(S[3]), .cout(temp[4]));
  FA FA_4(.a(in1[4]), .b(in2[4]), .cin(temp[4]), .S(S[4]), .cout(temp[5]));
  FA FA_5(.a(in1[5]), .b(in2[5]), .cin(temp[5]), .S(S[5]), .cout(temp[6]));
  FA FA_6(.a(in1[6]), .b(in2[6]), .cin(temp[6]), .S(S[6]), .cout(temp[7]));
  FA FA_7(.a(in1[7]), .b(in2[7]), .cin(temp[7]), .S(S[7]), .cout(temp[8]));
  FA FA_8(.a(in1[8]), .b(in2[8]), .cin(temp[8]), .S(S[8]), .cout(Cout));
endmodule
//adder 10bit

module adder_10bit(in1, in2, S, Cout);//bo cong 10bit
  input [9:0] in1, in2;
  output [9:0] S;
  output Cout;
  
  wire [9:1] temp;

  FA FA_10(.a(in1[0]), .b(in2[0]), .cin(1'b0), .S(S[0]), .cout(temp[1]));
  FA FA_11(.a(in1[1]), .b(in2[1]), .cin(temp[1]), .S(S[1]), .cout(temp[2]));
  FA FA_12(.a(in1[2]), .b(in2[2]), .cin(temp[2]), .S(S[2]), .cout(temp[3]));
  FA FA_13(.a(in1[3]), .b(in2[3]), .cin(temp[3]), .S(S[3]), .cout(temp[4]));
  FA FA_14(.a(in1[4]), .b(in2[4]), .cin(temp[4]), .S(S[4]), .cout(temp[5]));
  FA FA_15(.a(in1[5]), .b(in2[5]), .cin(temp[5]), .S(S[5]), .cout(temp[6]));
  FA FA_16(.a(in1[6]), .b(in2[6]), .cin(temp[6]), .S(S[6]), .cout(temp[7]));
  FA FA_17(.a(in1[7]), .b(in2[7]), .cin(temp[7]), .S(S[7]), .cout(temp[8]));
  FA FA_18(.a(in1[8]), .b(in2[8]), .cin(temp[8]), .S(S[8]), .cout(temp[9]));
  FA FA_19(.a(in1[9]), .b(in2[9]), .cin(temp[9]), .S(S[9]), .cout(Cout));
endmodule

//adder 25bit
module adder_25bit(in1, in2, S, Cout);//bo cong 25bit
  input [24:0] in1, in2;
  output [24:0] S;
  output Cout;
  
  wire [24:1] temp;
  
  FA FA_20(.a(in1[0]), .b(in2[0]), .cin(1'b0), .S(S[0]), .cout(temp[1]));
  FA FA_21(.a(in1[1]), .b(in2[1]), .cin(temp[1]), .S(S[1]), .cout(temp[2]));
  FA FA_22(.a(in1[2]), .b(in2[2]), .cin(temp[2]), .S(S[2]), .cout(temp[3]));
  FA FA_23(.a(in1[3]), .b(in2[3]), .cin(temp[3]), .S(S[3]), .cout(temp[4]));
  FA FA_24(.a(in1[4]), .b(in2[4]), .cin(temp[4]), .S(S[4]), .cout(temp[5]));
  FA FA_25(.a(in1[5]), .b(in2[5]), .cin(temp[5]), .S(S[5]), .cout(temp[6]));
  FA FA_26(.a(in1[6]), .b(in2[6]), .cin(temp[6]), .S(S[6]), .cout(temp[7]));
  FA FA_27(.a(in1[7]), .b(in2[7]), .cin(temp[7]), .S(S[7]), .cout(temp[8]));
  FA FA_28(.a(in1[8]), .b(in2[8]), .cin(temp[8]), .S(S[8]), .cout(temp[9]));
  FA FA_29(.a(in1[9]), .b(in2[9]), .cin(temp[9]), .S(S[9]), .cout(temp[10]));
  FA FA_30(.a(in1[10]), .b(in2[10]), .cin(temp[10]), .S(S[10]), .cout(temp[11]));
  FA FA_31(.a(in1[11]), .b(in2[11]), .cin(temp[11]), .S(S[11]), .cout(temp[12]));
  FA FA_32(.a(in1[12]), .b(in2[12]), .cin(temp[12]), .S(S[12]), .cout(temp[13]));
  FA FA_33(.a(in1[13]), .b(in2[13]), .cin(temp[13]), .S(S[13]), .cout(temp[14]));
  FA FA_34(.a(in1[14]), .b(in2[14]), .cin(temp[14]), .S(S[14]), .cout(temp[15]));
  FA FA_35(.a(in1[15]), .b(in2[15]), .cin(temp[15]), .S(S[15]), .cout(temp[16]));
  FA FA_36(.a(in1[16]), .b(in2[16]), .cin(temp[16]), .S(S[16]), .cout(temp[17]));
  FA FA_37(.a(in1[17]), .b(in2[17]), .cin(temp[17]), .S(S[17]), .cout(temp[18]));
  FA FA_38(.a(in1[18]), .b(in2[18]), .cin(temp[18]), .S(S[18]), .cout(temp[19]));
  FA FA_39(.a(in1[19]), .b(in2[19]), .cin(temp[19]), .S(S[19]), .cout(temp[20]));
  FA FA_40(.a(in1[20]), .b(in2[20]), .cin(temp[20]), .S(S[20]), .cout(temp[21]));
  FA FA_41(.a(in1[21]), .b(in2[21]), .cin(temp[21]), .S(S[21]), .cout(temp[22]));
  FA FA_42(.a(in1[22]), .b(in2[22]), .cin(temp[22]), .S(S[22]), .cout(temp[23]));
  FA FA_43(.a(in1[23]), .b(in2[23]), .cin(temp[23]), .S(S[23]), .cout(temp[24]));
  FA FA_44(.a(in1[24]), .b(in2[24]), .cin(temp[24]), .S(S[24]), .cout(Cout));
endmodule 

//adder 26bit

module adder_26bit(in1, in2, S, Cout);//bo cong 26bit
  input [25:0] in1, in2;
  output [25:0] S;
  output Cout;
  
  wire [25:1] temp;
  
  FA FA_50(.a(in1[0]), .b(in2[0]), .cin(1'b0), .S(S[0]), .cout(temp[1]));
  FA FA_51(.a(in1[1]), .b(in2[1]), .cin(temp[1]), .S(S[1]), .cout(temp[2]));
  FA FA_52(.a(in1[2]), .b(in2[2]), .cin(temp[2]), .S(S[2]), .cout(temp[3]));
  FA FA_53(.a(in1[3]), .b(in2[3]), .cin(temp[3]), .S(S[3]), .cout(temp[4]));
  FA FA_54(.a(in1[4]), .b(in2[4]), .cin(temp[4]), .S(S[4]), .cout(temp[5]));
  FA FA_55(.a(in1[5]), .b(in2[5]), .cin(temp[5]), .S(S[5]), .cout(temp[6]));
  FA FA_56(.a(in1[6]), .b(in2[6]), .cin(temp[6]), .S(S[6]), .cout(temp[7]));
  FA FA_57(.a(in1[7]), .b(in2[7]), .cin(temp[7]), .S(S[7]), .cout(temp[8]));
  FA FA_58(.a(in1[8]), .b(in2[8]), .cin(temp[8]), .S(S[8]), .cout(temp[9]));
  FA FA_59(.a(in1[9]), .b(in2[9]), .cin(temp[9]), .S(S[9]), .cout(temp[10]));
  FA FA_60(.a(in1[10]), .b(in2[10]), .cin(temp[10]), .S(S[10]), .cout(temp[11]));
  FA FA_61(.a(in1[11]), .b(in2[11]), .cin(temp[11]), .S(S[11]), .cout(temp[12]));
  FA FA_62(.a(in1[12]), .b(in2[12]), .cin(temp[12]), .S(S[12]), .cout(temp[13]));
  FA FA_63(.a(in1[13]), .b(in2[13]), .cin(temp[13]), .S(S[13]), .cout(temp[14]));
  FA FA_64(.a(in1[14]), .b(in2[14]), .cin(temp[14]), .S(S[14]), .cout(temp[15]));
  FA FA_65(.a(in1[15]), .b(in2[15]), .cin(temp[15]), .S(S[15]), .cout(temp[16]));
  FA FA_66(.a(in1[16]), .b(in2[16]), .cin(temp[16]), .S(S[16]), .cout(temp[17]));
  FA FA_67(.a(in1[17]), .b(in2[17]), .cin(temp[17]), .S(S[17]), .cout(temp[18]));
  FA FA_68(.a(in1[18]), .b(in2[18]), .cin(temp[18]), .S(S[18]), .cout(temp[19]));
  FA FA_69(.a(in1[19]), .b(in2[19]), .cin(temp[19]), .S(S[19]), .cout(temp[20]));
  FA FA_70(.a(in1[20]), .b(in2[20]), .cin(temp[20]), .S(S[20]), .cout(temp[21]));
  FA FA_71(.a(in1[21]), .b(in2[21]), .cin(temp[21]), .S(S[21]), .cout(temp[22]));
  FA FA_72(.a(in1[22]), .b(in2[22]), .cin(temp[22]), .S(S[22]), .cout(temp[23]));
  FA FA_73(.a(in1[23]), .b(in2[23]), .cin(temp[23]), .S(S[23]), .cout(temp[24]));
  FA FA_74(.a(in1[24]), .b(in2[24]), .cin(temp[24]), .S(S[24]), .cout(temp[25]));
  FA FA_75(.a(in1[25]), .b(in2[25]), .cin(temp[25]), .S(S[25]), .cout(Cout));
endmodule 
//**********************************sosanh_8bit******************************************
module sosanh_8bit(in1, in2, shift, in1_sub_in2, check_qualon);
  
  input [7:0] in1, in2;
  output [4:0] shift;
  output in1_sub_in2, check_qualon;
  
  wire [8:0] tmp1, tmp2, tmp3, tmp4;
  wire [7:0] tmp5, tmp6;
  
  assign tmp1 = {1'b0,in1};
  assign tmp2 = {1'b0,in2};
  
  bu2_9bit bu2_9bit(.in(tmp2), .out(tmp3));//bu exponent 2
  //tru 2 exponent
  adder_9bit subtract(.in1(tmp1), .in2(tmp3), .S(tmp4), .Cout()); //output tmp4 = so duong
  //bu 2 8 bit hieu exp1-exp2
  bu2_8bit bu2_8bit_1(.in(tmp4[7:0]), .out(tmp5)); //output tmp5 = so am
 //luu bit8 tmp4, neu = 1 thi tmp5, =0 thi [7:0]tmp4 
  assign in1_sub_in2 = tmp4[8];
  assign tmp6 = tmp4[8]?tmp5:tmp4[7:0]; 
   //data > 24 => so cong qua lon
  assign check_qualon = tmp6[7]|tmp6[6]|tmp6[5]|(tmp6[4]&tmp6[3]&(|tmp6[2:0]));
  assign shift = check_qualon?5'd0:tmp6[4:0];
  
endmodule
  
// *************************************shift left**************************************************
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
//*******************************************shift right*********************************************
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
//****************************************************special_case*******************************************************
 module specialcase(I, Inf, NaN, Zero);
  input [31:0] I;
  output Inf, NaN, Zero;
  
  wire zero_Fraction, one_Exponent;
  //Kiem tra truong hop 32bit 0
  assign Zero = ~I[0]&~I[1]&~I[2]&~I[3]&~I[4]&~I[5]&~I[6]&~I[7]&~I[8]&~I[9]&~I[10]&~I[11]&~I[12]&~I[13]&~I[14]&~I[15]&~I[16]&~I[17]&~I[18]&~I[19]&~I[20]&~I[21]&~I[22]&~I[23]&~I[24]&~I[25]&~I[26]&~I[27]&~I[28]&~I[29]&~I[30]; 
  //Kiem tra truong hop fraction = 0     		
	assign zero_Fraction =~I[0]&~I[1]&~I[2]&~I[3]&~I[4]&~I[5]&~I[6]&~I[7]&~I[8]&~I[9]&~I[10]&~I[11]&~I[12]&~I[13]&~I[14]&~I[15]&~I[16]&~I[17]&~I[18]&~I[19]&~I[20]&~I[21]&~I[22];
	//Kiem tra truong hop Exponent = 1
	assign one_Exponent = I[23]&I[24]&I[25]&I[26]&I[27]&I[28]&I[29]&I[30];
	//Kiem tra truong hop exponent=128 va fraction~=0
	assign NaN=(one_Exponent==1&&zero_Fraction==0)?1:0;
	//Kiem tra truong hop vo cung infinity exponent=128 va fraction=0
	assign Inf=(one_Exponent&zero_Fraction)?1:0;
	
endmodule	       		
//******************************************************bu 2 bit **********************************************
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

//*************************************************mux*****************************************************
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
//********************************************tim bit 1******************************************************
module tim_bit1(in, shiftleft, check_zero);
  
	input	[24:0] in;
	output	[4:0] shiftleft;
	output check_zero;

//Kiem tra so 0 trong chuoi 32bit so 
assign 	check_zero = ~(|(in));
//dich trai 1 bit phan significant
assign 	shiftleft[0]=	  (~in[23]&in[22])
                        |(~in[23]&~in[21]&in[20])
			|(~in[23]&~in[21]&~in[19]&in[18])
			|(~in[23]&~in[21]&~in[19]&~in[17]&in[16])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&in[14])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&~in[13]&in[12])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&~in[13]&~in[11]&in[10])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&~in[13]&~in[11]&~in[9]&in[8])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&~in[13]&~in[11]&~in[9]&~in[7]&in[6])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&~in[13]&~in[11]&~in[9]&~in[7]&~in[5]&in[4])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&~in[13]&~in[11]&~in[9]&~in[7]&~in[5]&~in[3]&in[2])
			|(~in[23]&~in[21]&~in[19]&~in[17]&~in[15]&~in[13]&~in[11]&~in[9]&~in[7]&~in[5]&~in[3]&~in[1]&in[0]);
//dich trai 2 bit phan significant
assign	shiftleft[1]=    (~in[23]&~in[22]&in[21])
                        |(~in[23]&~in[22]&in[20])
			|(~in[23]&~in[22]&~in[19]&~in[18]&in[17])
			|(~in[23]&~in[22]&~in[19]&~in[18]&in[16])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&in[13])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&in[12])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&~in[11]&~in[10]&in[9])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&~in[11]&~in[10]&in[8])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&~in[11]&~in[10]&~in[7]&~in[6]&in[5])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&~in[11]&~in[10]&~in[7]&~in[6]&in[4])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&~in[11]&~in[10]&~in[7]&~in[6]&~in[3]&~in[3]&in[1])
			|(~in[23]&~in[22]&~in[19]&~in[18]&~in[15]&~in[14]&~in[11]&~in[10]&~in[7]&~in[6]&~in[3]&~in[2]&in[0]);
//dich trai 4 bit phan significant
assign	shiftleft[2]=	 (~in[23]&~in[22]&~in[21]&~in[20]&in[19])
                        |(~in[23]&~in[22]&~in[21]&~in[20]&in[18])
			|(~in[23]&~in[22]&~in[21]&~in[20]&in[17])
			|(~in[23]&~in[22]&~in[21]&~in[20]&in[16])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&in[11])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&in[10])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&in[9])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&in[8])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&~in[7]&~in[6]&~in[5]&~in[4]&in[3])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&~in[7]&~in[6]&~in[5]&~in[4]&in[2])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&~in[7]&~in[6]&~in[5]&~in[4]&in[1])
			|(~in[23]&~in[22]&~in[21]&~in[20]&~in[15]&~in[14]&~in[13]&~in[12]&~in[7]&~in[6]&~in[5]&~in[4]&in[0]);
//dich trai 8 bit phan significant
assign	shiftleft[3]=	((&(~in[23:16]))&(|in[15:8]));
//dich trai 16 bit phan significant
assign	shiftleft[4]=	((&(~in[23:8]))&(|in[7:0]));
endmodule
//*******************************************************xuatketqua*****************************************************  
module xuatketqua(in1,in2,temp_result,qualon,result);
	input   [31:0]in1,in2,temp_result;
	input	[1:0]	qualon;
	output	[31:0]result;
	reg	[31:0]result;

	wire	flagNaNin1,flagInfin1,flagZeroin1,flagNaNin2,flagInfin2,flagZeroin2;

	specialcase	check1(.I(in1),.Inf(flagInfin1),.NaN(flagNaNin1),.Zero(flagZeroin1));
	specialcase	check2(.I(in2),.Inf(flagInfin2),.NaN(flagNaNin2),.Zero(flagZeroin2));
		
	always@(in1 or in2 or temp_result)
	begin
		if (qualon[0])
			begin
				if (qualon[1])
					result = in2;
				else
					result = in1;
			end
		else
		case ({flagZeroin1,flagInfin1,flagNaNin1,flagZeroin2,flagInfin2,flagNaNin2})
				6'b100_100: result=32'h00000000;
				6'b100_010: result={in2[31],31'h7f800000};
				6'b100_001: result=32'h7FFFFFFF;
				6'b100_000: result=in2;

				6'b010_100: result=in1;
				6'b010_010: result=(in2[31]^in1[31])?32'h7FFFFFFF:{in1[31],31'h7f800000};
				6'b010_001:	result=32'h7FFFFFFF;
				6'b010_000: result={in1[31],31'h7f800000};

				6'b001_100, 6'b001_010, 6'b001_001, 6'b001_000:	result=32'h7FFFFFFF;

				6'b000_100: result=in1;
				6'b000_010: result={in2[31],31'h7f800000};
				6'b000_001:	result=32'h7FFFFFFF;
				6'b000_000:	result=temp_result;	
		endcase
	end
endmodule
//******************************************************************************************************  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
