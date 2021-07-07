module FP_sang_TP(a,dau,dau2,phannguyen,phanmu,b,c,c1);
input [31:0]a;   // so fp
output [7:0]dau;
 output [7:0]dau2;
output real phanmu;
output real phannguyen ;
wire [7:0]dau1,S;
wire [7:0]dau;
output wire [23:0]b;   // chua gia tri nguyen 
output wire [22:0]c;
output wire [22:0] c1;   // chua gia tri mu 
wire Cout;

assign dau=(a[31]==1'b0)?(8'b0010_1011):(8'b0010_1101);  // xác d?nh dau 
botru  z(.in1(a[30:23]),.S(S), .Cout(Cout),.dau(dau1));  /// tinh phan 2^S và dau 
tim_phan_nguyen z1( .mu(S), .dau(dau1),.a(a[22:0]),.b(b),.c(c));
  tinh_phan_tp z2(.a(c),.b(c1));
tinhmu1 z3(.a(b),.b(phannguyen),.c(c1),.mu(phanmu),.mu1(dau2));

endmodule
module t_FP_sang_TP;
	 real phanmu; 
        wire [7:0]dau;
       wire [7:0]dau2;
	reg [31:0]a;
        real phannguyen;
         wire [23:0]b; wire [22:0]c1;wire [22:0]c;
parameter time_out = 100;
	FP_sang_TP z(.a(a),.dau(dau),.phannguyen(phannguyen),.dau2(dau2),.phanmu(phanmu),.c(c),.b(b),.c1(c1));
      
initial $monitor($time," %b so %c%f *10^ %c%d ",a,dau,phannguyen,dau2,phanmu );
	initial begin

	#0  a=32'b1_1000_1100_1111_0000_0000_0000_0000_000;
        #10 a=32'b0_1000_0010_1110_0001_0000_0000_0000_000;
        #10 a=32'b1_0111_1100_1000_0000_0000_0000_0000_000;
        #10 a=33'b1_1000_1011_1000_0000_0000_0000_0000_000;
        #10 a=33'b1_1000_0101_1000_0000_0100_0000_0000_000;
        #10 a=32'b0_0111_1111_0000_0000_0000_0000_0000_000;
        #10 a=32'b11000001010101100000000000000000;

       
        
end 
endmodule