`include"taylor_ln.v"
module TAYLOR_LN_tb();

reg [31:0] in;
wire [31:0] out;


taylor TAYLOR_LN_0 (.in(in),.out(out));

initial begin
	
	
	#10
	in = 32'b00111110110000000000000000000000; // 0.375
	#10
	in = 32'b00111110110011001100110011001101; // 0.4
	#10
	in = 32'b00111110010011001100110011001101; // 0.2
	
end
initial begin
$vcdplusfile ("taylor_ln_tb.vpd");
$vcdpluson ();
end


endmodule 