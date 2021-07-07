module FA(a, b, cin, S, cout); //bo cong full adder
  input a,b,cin;
  output S,cout;
  
  assign S=a^b^cin;
  assign cout=((a&b)|(cin&(a^b)));
  
endmodule

//adder 6bit
module adder_6bit(in1, in2, S, Cout);//bo cong 5bit
  input [5:0] in1, in2;
  output [5:0] S;
  output Cout;
  
  wire [5:1] temp;
 
  FA FA_0(.a(in1[0]), .b(in2[0]), .cin(1'b0), .S(S[0]), .cout(temp[1]));
  FA FA_1(.a(in1[1]), .b(in2[1]), .cin(temp[1]), .S(S[1]), .cout(temp[2]));
  FA FA_2(.a(in1[2]), .b(in2[2]), .cin(temp[2]), .S(S[2]), .cout(temp[3]));
  FA FA_3(.a(in1[3]), .b(in2[3]), .cin(temp[3]), .S(S[3]), .cout(temp[4]));
  FA FA_4(.a(in1[4]), .b(in2[4]), .cin(temp[4]), .S(S[4]), .cout(temp[5]));
  FA FA_5(.a(in1[5]), .b(in2[5]), .cin(temp[5]), .S(S[5]), .cout(Cout));
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

//adder 49bit
module adder_49bit(in1, in2, S, Cout);//bo cong 25bit
  input [48:0] in1, in2;
  output [48:0] S;
  output Cout;
  
  wire [48:1] temp;
  
  FA FA_0(.a(in1[0]), .b(in2[0]), .cin(1'b0), .S(S[0]), .cout(temp[1]));
  FA FA_1(.a(in1[1]), .b(in2[1]), .cin(temp[1]), .S(S[1]), .cout(temp[2]));
  FA FA_2(.a(in1[2]), .b(in2[2]), .cin(temp[2]), .S(S[2]), .cout(temp[3]));
  FA FA_3(.a(in1[3]), .b(in2[3]), .cin(temp[3]), .S(S[3]), .cout(temp[4]));
  FA FA_4(.a(in1[4]), .b(in2[4]), .cin(temp[4]), .S(S[4]), .cout(temp[5]));
  FA FA_5(.a(in1[5]), .b(in2[5]), .cin(temp[5]), .S(S[5]), .cout(temp[6]));
  FA FA_6(.a(in1[6]), .b(in2[6]), .cin(temp[6]), .S(S[6]), .cout(temp[7]));
  FA FA_7(.a(in1[7]), .b(in2[7]), .cin(temp[7]), .S(S[7]), .cout(temp[8]));
  FA FA_8(.a(in1[8]), .b(in2[8]), .cin(temp[8]), .S(S[8]), .cout(temp[9]));
  FA FA_9(.a(in1[9]), .b(in2[9]), .cin(temp[9]), .S(S[9]), .cout(temp[10]));
  FA FA_10(.a(in1[10]), .b(in2[10]), .cin(temp[10]), .S(S[10]), .cout(temp[11]));
  FA FA_11(.a(in1[11]), .b(in2[11]), .cin(temp[11]), .S(S[11]), .cout(temp[12]));
  FA FA_12(.a(in1[12]), .b(in2[12]), .cin(temp[12]), .S(S[12]), .cout(temp[13]));
  FA FA_13(.a(in1[13]), .b(in2[13]), .cin(temp[13]), .S(S[13]), .cout(temp[14]));
  FA FA_14(.a(in1[14]), .b(in2[14]), .cin(temp[14]), .S(S[14]), .cout(temp[15]));
  FA FA_15(.a(in1[15]), .b(in2[15]), .cin(temp[15]), .S(S[15]), .cout(temp[16]));
  FA FA_16(.a(in1[16]), .b(in2[16]), .cin(temp[16]), .S(S[16]), .cout(temp[17]));
  FA FA_17(.a(in1[17]), .b(in2[17]), .cin(temp[17]), .S(S[17]), .cout(temp[18]));
  FA FA_18(.a(in1[18]), .b(in2[18]), .cin(temp[18]), .S(S[18]), .cout(temp[19]));
  FA FA_19(.a(in1[19]), .b(in2[19]), .cin(temp[19]), .S(S[19]), .cout(temp[20]));
  FA FA_20(.a(in1[20]), .b(in2[20]), .cin(temp[20]), .S(S[20]), .cout(temp[21]));
  FA FA_21(.a(in1[21]), .b(in2[21]), .cin(temp[21]), .S(S[21]), .cout(temp[22]));
  FA FA_22(.a(in1[22]), .b(in2[22]), .cin(temp[22]), .S(S[22]), .cout(temp[23]));
  FA FA_23(.a(in1[23]), .b(in2[23]), .cin(temp[23]), .S(S[23]), .cout(temp[24]));
  FA FA_24(.a(in1[24]), .b(in2[24]), .cin(temp[24]), .S(S[24]), .cout(temp[25]));
  FA FA_25(.a(in1[25]), .b(in2[25]), .cin(temp[25]), .S(S[25]), .cout(temp[26]));
  FA FA_26(.a(in1[26]), .b(in2[26]), .cin(temp[26]), .S(S[26]), .cout(temp[27]));
  FA FA_27(.a(in1[27]), .b(in2[27]), .cin(temp[27]), .S(S[27]), .cout(temp[28]));
  FA FA_28(.a(in1[28]), .b(in2[28]), .cin(temp[28]), .S(S[28]), .cout(temp[29]));
  FA FA_29(.a(in1[29]), .b(in2[29]), .cin(temp[29]), .S(S[29]), .cout(temp[30]));
  FA FA_30(.a(in1[30]), .b(in2[30]), .cin(temp[30]), .S(S[30]), .cout(temp[31]));
  FA FA_31(.a(in1[31]), .b(in2[31]), .cin(temp[31]), .S(S[31]), .cout(temp[32]));
  FA FA_32(.a(in1[32]), .b(in2[32]), .cin(temp[32]), .S(S[32]), .cout(temp[33]));
  FA FA_33(.a(in1[33]), .b(in2[33]), .cin(temp[33]), .S(S[33]), .cout(temp[34]));
  FA FA_34(.a(in1[34]), .b(in2[34]), .cin(temp[34]), .S(S[34]), .cout(temp[35]));
  FA FA_35(.a(in1[35]), .b(in2[35]), .cin(temp[35]), .S(S[35]), .cout(temp[36]));
  FA FA_36(.a(in1[36]), .b(in2[36]), .cin(temp[36]), .S(S[36]), .cout(temp[37]));
  FA FA_37(.a(in1[37]), .b(in2[37]), .cin(temp[37]), .S(S[37]), .cout(temp[38]));
  FA FA_38(.a(in1[38]), .b(in2[38]), .cin(temp[38]), .S(S[38]), .cout(temp[39]));
  FA FA_39(.a(in1[39]), .b(in2[39]), .cin(temp[39]), .S(S[39]), .cout(temp[40]));
  FA FA_40(.a(in1[40]), .b(in2[40]), .cin(temp[40]), .S(S[40]), .cout(temp[41]));
  FA FA_41(.a(in1[41]), .b(in2[41]), .cin(temp[41]), .S(S[41]), .cout(temp[42]));
  FA FA_42(.a(in1[42]), .b(in2[42]), .cin(temp[42]), .S(S[42]), .cout(temp[43]));
  FA FA_43(.a(in1[43]), .b(in2[43]), .cin(temp[43]), .S(S[43]), .cout(temp[44]));
  FA FA_44(.a(in1[44]), .b(in2[44]), .cin(temp[44]), .S(S[44]), .cout(temp[45]));
  FA FA_45(.a(in1[45]), .b(in2[45]), .cin(temp[45]), .S(S[45]), .cout(temp[46]));
  FA FA_46(.a(in1[46]), .b(in2[46]), .cin(temp[46]), .S(S[46]), .cout(temp[47]));
  FA FA_47(.a(in1[47]), .b(in2[47]), .cin(temp[47]), .S(S[47]), .cout(temp[48]));
  FA FA_48(.a(in1[48]), .b(in2[48]), .cin(temp[48]), .S(S[48]), .cout(Cout));
endmodule 
