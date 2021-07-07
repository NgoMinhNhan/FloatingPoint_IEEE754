module specialcase(I,Inf,NaN,Zero);	
	input	[31:0]I;
	output	Zero, Inf, NaN;

	wire	zero_frac,one_exp;

	assign	Zero=~I[0]&~I[1]&~I[2]&~I[3]&~I[4]&~I[5]&~I[6]&~I[7]
		       		&~I[8]&~I[9]&~I[10]&~I[11]&~I[12]&~I[13]&~I[14]&~I[15]
		       		&~I[16]&~I[17]&~I[18]&~I[19]&~I[20]&~I[21]&~I[22]&~I[23]
		       		&~I[24]&~I[25]&~I[26]&~I[27]&~I[28]&~I[29]&~I[30];

	assign	zero_frac=~I[0]&~I[1]&~I[2]&~I[3]&~I[4]&~I[5]&~I[6]&~I[7]
		       		&~I[8]&~I[9]&~I[10]&~I[11]&~I[12]&~I[13]&~I[14]&~I[15]
		       		&~I[16]&~I[17]&~I[18]&~I[19]&~I[20]&~I[21]&~I[22];

	assign	one_exp=I[23]&I[24]&I[25]&I[26]&I[27]&I[28]&I[29]&I[30];

	assign	NaN=(one_exp==1&&zero_frac==0)?1:0;
	assign	Inf=(zero_frac&one_exp)?1:0;
endmodule
