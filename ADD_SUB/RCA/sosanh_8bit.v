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
  
  
  
  
