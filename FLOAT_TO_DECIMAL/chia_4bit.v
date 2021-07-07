module chia_4bit(
input cp,
input [3:0]a,
output [3:0]b,
output c
);
wire [3:0]a1;
//assign a1=4'b0110;
assign a1=(cp==1'b1)?(4'b0110):(4'b0000);
FA FA[3:0](.a(a[3:0]), .b(a1[3:0]), .cin(1'b0), .s(b) ,.cout(c) );

endmodule 
module t_chia_4bit;
	reg [3:0]a;  reg cp;
	wire [3:0]b;
        wire c;
parameter time_out = 100;
	chia_4bit da(.cp(cp),.a(a),.b(b),.c(c));
      
initial $monitor($time," so a %b la %b,%b    ", a,b,c );
	initial begin

	#0 a=4'b1111; cp=1'b1;
        #10 a=4'b1010;cp=1'b1;
        #10 a=4'b0000;cp=1'b1;
        //#10 in1=8'b0010_1111;  in1=8'b1000_0000;
        //#10 in1=8'b0111_1111;  in1=8'b1000_0000;
	
end 
endmodule
