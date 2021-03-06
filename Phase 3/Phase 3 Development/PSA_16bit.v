module PSA_16bit(Sum, A, B);

input [15:0] A, B;
output [15:0] Sum;

wire [3:0] temp1, temp2, temp3, temp4;
wire check1, check2, check3, check4;

addsub_4bit ADD1(.Sum(temp1), .Ovfl(check1), .A(A[3:0]), .B(B[3:0]), .sub(1'b0));
addsub_4bit ADD2(.Sum(temp2), .Ovfl(check2), .A(A[7:4]), .B(B[7:4]), .sub(1'b0));
addsub_4bit ADD3(.Sum(temp3), .Ovfl(check3), .A(A[11:8]), .B(B[11:8]), .sub(1'b0));
addsub_4bit ADD4(.Sum(temp4), .Ovfl(check4), .A(A[15:12]), .B(B[15:12]), .sub(1'b0));

// If there is overflow, saturate the result
assign Sum[3:0] = (~check1) ? temp1 :
		  (A[3] & B[3]) ? 4'h8 : 4'h7;

assign Sum[7:4] = (~check2) ? temp2 :
		  (A[7] & B[7]) ? 4'h8 : 4'h7;

assign Sum[11:8] = (~check3) ? temp3 :
		  (A[11] & B[11]) ? 4'h8 : 4'h7;

assign Sum[15:12] = (~check4) ? temp4 :
		  (A[15] & B[15]) ? 4'h8 : 4'h7;
endmodule