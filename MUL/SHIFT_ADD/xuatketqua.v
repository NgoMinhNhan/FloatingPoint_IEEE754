`include "specialcase.v"

module xuatketqua(in1,in2, tmp_result, result);
	
	input [31:0] in1, in2, tmp_result;
	output [31:0] result;

	reg [31:0] result;
	wire NaN_in1, NaN_in2, Inf_in1, Inf_in2, Zero_in1, Zero_in2;
	
	specialcase check_1(.I(in1), .Inf(Inf_in1), .NaN(NaN_in1), .Zero(Zero_in1));
	specialcase check_2(.I(in2), .Inf(Inf_in2), .NaN(NaN_in2), .Zero(Zero_in2));
	
	always@(in1 or in2 or tmp_result)
		begin
				case({Zero_in1, Inf_in1, NaN_in1, Zero_in2, Inf_in2, NaN_in2})
				// Truong hop in1 = 32bit 0 va in2 specialcase
						6'b100_100: result = 32'h00000000;//in1=zero va in2=zero
						6'b100_010: result = 32'h7FFFFFFF;//in1 = zero va in2 = inf (vo cung)
						6'b100_001: result = 32'h7FFFFFFF;//in1 = zero va in2 = NaN (not a number)
						6'b100_000: result = 32'h00000000;//in1 = zero va in2=so thuc
				// Truong hop in1 = vo cung va in2 specialcase
						6'b010_100: result = 32'h7FFFFFFF;//in1 = inf va in2 = zero
						6'b010_010: result = {tmp_result[31],31'h7F800000};//in1 = inf va in2 = inf
						6'b010_001: result = 32'h7FFFFFFF;//in1 = inf va in2 = NaN
						6'b010_000: result = {tmp_result[31],31'h7F800000};//in1=inf va in2=temp_result
				// Truong hop in1 = not a number (NaN) va in2 specialcase => NaN
						6'b001_100: result = 32'h7FFFFFFF;
						6'b001_010: result = 32'h7FFFFFFF;
						6'b001_001: result = 32'h7FFFFFFF;
						6'b001_000: result = 32'h7FFFFFFF;
				//Truong hop in1 la 1 so IEEE752 va in2 la specialcase
						6'b000_100: result = 32'h00000000;//in2 = zero => in1 = 0
						6'b000_010: result = {tmp_result[31],31'h7F800000};//in2 = inf => ket qua = dau cua in2 + exponent 128
						6'b000_001: result = 32'h7FFFFFFF;//in2 = NaN => vo cung 32bit
						6'b000_000: result = tmp_result; //ket qua bang in1 nhan in2
				endcase
		end
endmodule		
			
