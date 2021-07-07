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
		       		       		
		       	
