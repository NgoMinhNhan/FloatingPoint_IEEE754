`include "specialcase.v"

module xuatketqua(in1,in2,temp_result,qualon,result);
	input   [31:0]in1,in2,temp_result;
	input	[1:0]	qualon;
	output	[31:0]result;
	reg	[31:0]result;

	wire	flagNaNin1,flagInfin1,flagZeroin1,flagNaNin2,flagInfin2,flagZeroin2;

	specialcase	check1(.I(in1),.Inf(flagInfin1),.NaN(flagNaNin1),.Zero(flagZeroin1));
	specialcase	check2(.I(in2),.Inf(flagInfin2),.NaN(flagNaNin2),.Zero(flagZeroin2));
		
	always@(in1 or in2 or temp_result)
	begin
		if (qualon[0])
			begin
				if (qualon[1])
					result = in2;
				else
					result = in1;
			end
		else
		case ({flagZeroin1,flagInfin1,flagNaNin1,flagZeroin2,flagInfin2,flagNaNin2})
				6'b100_100: result=32'h00000000;
				6'b100_010: result={in2[31],31'h7f800000};
				6'b100_001: result=32'h7FFFFFFF;
				6'b100_000: result=in2;

				6'b010_100: result=in1;
				6'b010_010: result=(in2[31]^in1[31])?32'h7FFFFFFF:{in1[31],31'h7f800000};
				6'b010_001:	result=32'h7FFFFFFF;
				6'b010_000: result={in1[31],31'h7f800000};

				6'b001_100, 6'b001_010, 6'b001_001, 6'b001_000:	result=32'h7FFFFFFF;

				6'b000_100: result=in1;
				6'b000_010: result={in2[31],31'h7f800000};
				6'b000_001:	result=32'h7FFFFFFF;
				6'b000_000:	result=temp_result;	
		endcase
	end
endmodule

