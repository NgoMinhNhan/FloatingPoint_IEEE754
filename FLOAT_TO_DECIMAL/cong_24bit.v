module cong_24bit(in1,in2,sum,c);
  output [24:0] sum;
  output [24:0]c;
  input [23:0] in1;
  input [23:0] in2;  
  wire  [23:0]cout;
	
  FA FA[23:0] (in1[23:0], in2[23:0], {c[22:0],1'b0},  sum[23:0],c[23:0]);
	
  assign cout = c[23];
  assign sum[24] = cout;
	
endmodule
module t_cong_24;
	reg [23:0]in1;  reg [23:0]in2;
	wire [24:0]sum;
         wire c;
      
parameter time_out = 100;
	cong_24bit z(.in1(in1),.in2(in2),.sum(sum),.c(c));
      
initial $monitor($time," so in1 %d so in2 %d , %d  , %d   ", in1,in2,sum,c );
	initial begin

	#0 in1=24'd5000_000;   in2=24'd2500_000;
        #10 in1=24'd1250_000;  in2=24'd100_0000;
        //#10 in1=8'b0010_1111;  in1=8'b1000_0000;
        //#10 in1=8'b0111_1111;  in1=8'b1000_0000;
	
end 
endmodule