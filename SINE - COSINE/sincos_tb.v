`include "sin_cos.v"

module TAYLOR_SIN_tb();

reg 	[31:0] in;
reg 	       sel;	
wire    [31:0] result;

sin_cos SIN_COSIN(.in(in), .sel(sel), .result(result));

initial begin
/////////////////////////////////////////////////////////
//cos x	
	#0  sel = 0;
    	    in = 32'h3fc90fdb; // pi/2
	#50
	    in = 32'h00000000; // 0
	#50
	    in = 32'h3f060a92; // pi/6
	#50
	    in = 32'h3f490fdb; // pi/4
	#50
	    in = 32'h3f860a92; // pi/3
	#50
	    in = 32'h40490fdb; //pi
	#50
	    in = 32'h40C90FDB; //2pi
	#50
	    in = 32'h4096CBE4; //3pi/2
	#50
	    in = 32'h7f800000; //Inf
	#50
	    in = 32'h7fffffff; //NaN


////////////////////////////////////////////////////////
//sin x

	#50 sel = 1;
    	    in = 32'h3fc90fdb; // pi/2
	#50
	    in = 32'h00000000; // 0
	#50
	    in = 32'h3f060a92; // pi/6
	#50
	    in = 32'h3f490fdb; // pi/4
	#50
	    in = 32'h3f860a92; // pi/3
	#50
	    in = 32'h40490fdb; //pi
	#50
	    in = 32'h40C90FDB; //2pi
	#50
	    in = 32'h4096CBE4; //3pi/2
	#50
	    in = 32'h7f800000; //Inf
	#50
	    in = 32'h7fffffff; //NaN
	#50 
   	    $finish;	
	
end

initial begin
$vcdplusfile ("sincos_tb.vpd");
$vcdpluson ();
end


endmodule 
