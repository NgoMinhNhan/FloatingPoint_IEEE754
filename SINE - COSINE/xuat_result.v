`include "spec_case.v"
//----------------------------------------xuat ket qua---------------------------------------//

module xuat_result(in, temp_result,result);
	input	   [31:0]  in;	
	input  	   [31:0]  temp_result;
	output reg [31:0]  result;

	wire	NaN,Inf,Zero;

	spec_case	check_case(.I(in),.Inf(Inf),.NaN(NaN),.Zero(Zero));
		
	always@(in or temp_result)
	begin
		case({Zero,Inf,NaN})
			3'b000: result = temp_result;
			3'b100: result = temp_result;
			3'b010: result = {in[31],31'h7f800000}; //Inf
			3'b001: result = 32'h7FFFFFFF; 		//NaN
		endcase
	end
endmodule
