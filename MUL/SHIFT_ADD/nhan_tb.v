`include "nhan.v"
module test();
//input define
reg [31:0] A, B;
reg t_clk, t_rst;
//output define
wire [31:0] result;
wire over, under;

always begin
	t_clk = 1'b0;
	# 50;
	t_clk = 1'b1;
	# 50;
end
//instance define
mult nhan( .A(A), .B(B), .result(result), .clk(t_clk), .n_rst(t_rst), 
			.overflow(over), .underflow(under));

//display 
initial begin
$monitor("time=%d, clk=%b, n_rst=%b, A=%h, B=%h, result=%h, overflow=%b, underflow=%b \n",
			$time, t_clk, t_rst, A, B, result, over, under );
end
//declare testcase
initial begin
            A = 32'h410C0000; 
            B = 32'h4086B852; 
			#0 t_rst = 1'B1;
			#5 t_rst = 1'B0;
			#5 t_rst = 1'B1;
			#1000000;


			$finish;
end
//output to simv
initial begin
	$vcdplusfile ("test.vpd");
	$vcdpluson();
end
endmodule
