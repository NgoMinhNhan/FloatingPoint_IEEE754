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

