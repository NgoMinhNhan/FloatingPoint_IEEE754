`include "taylor_cos.v"
module TAYLOR_COS_tb();

reg [31:0] in;
wire [31:0] out;


taylor_cos COS(.in(in),.out(out));

initial begin
	
	#50
	in = 32'h3fc90fdb; // pi/2
	#50
	in = 32'h00000000; // 0
	#50
	in = 32'h3f060a92; // pi/6
	#50
	in = 32'h3f490fdb; // pi/4
	#50
	$finish;	
	
end
initial begin
$vcdplusfile ("taylor_cos_tb.vpd");
$vcdpluson ();
end

endmodule 
