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





 







