`timescale 1ns/1ps
`include "cong_tru.v"

module add_sub_tb;
	wire	[31:0]	result;
	wire 			underflag,overflag;

	reg 	[31:0]	A,B;
	reg				add_or_sub;


	cong_tru  uut(.A(A),
				.B(B),
				.check_pt(add_or_sub),
				.overflow(overflag),
				.underflow(underflag),
				.result(result));

	initial
		begin
			add_or_sub = 0;
				
			A = 32'h4C8583B0;
			B = 32'h4E221FE8;
			#50    
				   
			A = 32'h3E7AE148;
			B = 32'h3F600000;
			#50
				
			A = 32'h00000000;
			B = 32'h00000000;
			#50
				
			A = 32'h7F800000;
			B = 32'h00000000;
			#50
				
			A = 32'h00000000;
			B = 32'h7F800000;
			#50    
				   
			A = 32'h7F800000;
			B = 32'h7F800000;
			#50   
				  
			A = 32'h201BBE08;
			B = 32'hFFFFFFFF;
			#50
			add_or_sub = 1;
				
			A = 32'h4D3532B8;
			B = 32'h4B5D40A0;
			#50    
				   
			A = 32'h3DE66666;
			B = 32'h3F5F9724;
			#50
				
			A = 32'h00000000;
			B = 32'h00000000;
			#50
				
			A = 32'h7F800000;
			B = 32'h00000000;
			#50
				
			A = 32'h00000000;
			B = 32'h7F800000;
			#50    
				   
			A = 32'h7F800000;
			B = 32'h7F800000;
			#50   
				  
			A = 32'h12A345B;
			B = 32'hFFFFFFFF;
			#50
$finish;
		end
	initial
	begin 
	$vcdplusfile("tb.vpd");
	$vcdpluson();
end
		
endmodule


