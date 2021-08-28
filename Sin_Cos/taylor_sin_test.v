module TAYLOR_SIN_tb();

reg [31:0] in;
wire [31:0] out;

taylor_sin SINE(.in(in),.out(out));

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
	in = 32'h3f860a92; // pi/3	
	
end
endmodule 
