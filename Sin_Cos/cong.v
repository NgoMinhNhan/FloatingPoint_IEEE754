module cong_tru(
	input [31:0] A,B, 
	input Operation,				  
	output [31:0] Out              
	);

	wire Oper;
	wire En;
	wire SignOut;

	wire [31:0] TempA,TempB;
	wire [23:0] MemA,MemB;
	wire [7:0] ExpDiff;


	wire [23:0] MemOp;
	wire [7:0] ExpOp;

	wire [24:0] MemAdd;
	wire [30:0] FullAdd;

	wire [23:0] PreMemSub;
	wire [24:0] MemSub;
	wire [30:0] FullSub;
	wire [24:0] MemDiff; 
	wire [7:0] ExpSub;

	assign {En,TempA,TempB} = (A[30:0] < B[30:0]) ? {1'b1,B,A} : {1'b0,A,B};

	assign Exception = (&TempA[30:23]) | (&TempB[30:23]);
	assign SignOut = Operation ? En ? !TempA[31] : TempA[31] : TempA[31] ;
	assign Oper = Operation ? TempA[31] ^ TempB[31] : ~(TempA[31] ^ TempB[31]);

	assign MemA = (|TempA[30:23]) ? {1'b1,TempA[22:0]} : {1'b0,TempA[22:0]};
	assign MemB = (|TempB[30:23]) ? {1'b1,TempB[22:0]} : {1'b0,TempB[22:0]};

	assign ExpDiff = TempA[30:23] - TempB[30:23];
	assign MemOp = MemB >> ExpDiff;
	assign ExpOp = TempB[30:23] + ExpDiff; 
	assign perform = (TempA[30:23] == ExpOp);

	assign MemAdd = (perform & Oper) ? (MemA + MemOp) : 25'd0; 
	assign FullAdd[22:0] = MemAdd[24] ? MemAdd[23:1] : MemAdd[22:0];
	assign FullAdd[30:23] = MemAdd[24] ? (1'b1 + TempA[30:23]) : TempA[30:23];

	assign PreMemSub = (perform & !Oper) ? ~(MemOp) + 24'd1 : 24'd0 ; 
	assign MemSub = perform ? (MemA + PreMemSub) : 25'd0;
	PriorityEncoder pe(MemSub,TempA[30:23],MemDiff,ExpSub);
	assign FullSub[30:23] = ExpSub;
	assign FullSub[22:0] = MemDiff[22:0];

	assign Out = Exception ? 32'b0 : ((!Oper) ? {SignOut,FullSub} : {SignOut,FullAdd});

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////
module PriorityEncoder(
			input [24:0] MemIn,
			input [7:0] ExpA,
			output reg [24:0] MemOut,
			output [7:0] ExpSub
			);

reg [4:0] Shift;

always @(MemIn)
begin
	casex (MemIn)
		25'b1_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx :	begin
													MemOut = MemIn;
									 				Shift = 5'd0;
								 			  	end
		25'b1_01xx_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin						
										 			MemOut = MemIn << 1;
									 				Shift = 5'd1;
								 			  	end

		25'b1_001x_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin						
										 			MemOut = MemIn << 2;
									 				Shift = 5'd2;
								 				end

		25'b1_0001_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin 							
													MemOut = MemIn << 3;
								 	 				Shift = 5'd3;
								 				end

		25'b1_0000_1xxx_xxxx_xxxx_xxxx_xxxx : 	begin						
									 				MemOut = MemIn << 4;
								 	 				Shift = 5'd4;
								 				end

		25'b1_0000_01xx_xxxx_xxxx_xxxx_xxxx : 	begin						
									 				MemOut = MemIn << 5;
								 	 				Shift = 5'd5;
								 				end

		25'b1_0000_001x_xxxx_xxxx_xxxx_xxxx : 	begin						// 24'h020000
									 				MemOut = MemIn << 6;
								 	 				Shift = 5'd6;
								 				end

		25'b1_0000_0001_xxxx_xxxx_xxxx_xxxx : 	begin						// 24'h010000
									 				MemOut = MemIn << 7;
								 	 				Shift = 5'd7;
								 				end

		25'b1_0000_0000_1xxx_xxxx_xxxx_xxxx : 	begin						// 24'h008000
									 				MemOut = MemIn << 8;
								 	 				Shift = 5'd8;
								 				end

		25'b1_0000_0000_01xx_xxxx_xxxx_xxxx : 	begin						// 24'h004000
									 				MemOut = MemIn << 9;
								 	 				Shift = 5'd9;
								 				end

		25'b1_0000_0000_001x_xxxx_xxxx_xxxx : 	begin						// 24'h002000
									 				MemOut = MemIn << 10;
								 	 				Shift = 5'd10;
								 				end

		25'b1_0000_0000_0001_xxxx_xxxx_xxxx : 	begin						// 24'h001000
									 				MemOut = MemIn << 11;
								 	 				Shift = 5'd11;
								 				end

		25'b1_0000_0000_0000_1xxx_xxxx_xxxx : 	begin						// 24'h000800
									 				MemOut = MemIn << 12;
								 	 				Shift = 5'd12;
								 				end

		25'b1_0000_0000_0000_01xx_xxxx_xxxx : 	begin						// 24'h000400
									 				MemOut = MemIn << 13;
								 	 				Shift = 5'd13;
								 				end

		25'b1_0000_0000_0000_001x_xxxx_xxxx : 	begin						// 24'h000200
									 				MemOut = MemIn << 14;
								 	 				Shift = 5'd14;
								 				end

		25'b1_0000_0000_0000_0001_xxxx_xxxx  : 	begin						// 24'h000100
									 				MemOut = MemIn << 15;
								 	 				Shift = 5'd15;
								 				end

		25'b1_0000_0000_0000_0000_1xxx_xxxx : 	begin						// 24'h000080
									 				MemOut = MemIn << 16;
								 	 				Shift = 5'd16;
								 				end

		25'b1_0000_0000_0000_0000_01xx_xxxx : 	begin						// 24'h000040
											 		MemOut = MemIn << 17;
										 	 		Shift = 5'd17;
												end

		25'b1_0000_0000_0000_0000_001x_xxxx : 	begin						// 24'h000020
									 				MemOut = MemIn << 18;
								 	 				Shift = 5'd18;
								 				end

		25'b1_0000_0000_0000_0000_0001_xxxx : 	begin						// 24'h000010
									 				MemOut = MemIn << 19;
								 	 				Shift = 5'd19;
												end

		25'b1_0000_0000_0000_0000_0000_1xxx :	begin						// 24'h000008
									 				MemOut = MemIn << 20;
								 					Shift = 5'd20;
								 				end

		25'b1_0000_0000_0000_0000_0000_01xx : 	begin						// 24'h000004
									 				MemOut = MemIn << 21;
								 	 				Shift = 5'd21;
								 				end

		25'b1_0000_0000_0000_0000_0000_001x : 	begin						// 24'h000002
									 				MemOut = MemIn << 22;
								 	 				Shift = 5'd22;
								 				end

		25'b1_0000_0000_0000_0000_0000_0001 : 	begin						// 24'h000001
									 				MemOut = MemIn << 23;
								 	 				Shift = 5'd23;
								 				end

		25'b1_0000_0000_0000_0000_0000_0000 : 	begin						// 24'h000000
								 					MemOut = MemIn << 24;
							 	 					Shift = 5'd24;
								 				end
		default : 	begin
						MemOut = (~MemIn) + 1'b1;
						Shift = 8'd0;
					end

	endcase
end
assign ExpSub = ExpA - Shift;

endmodule