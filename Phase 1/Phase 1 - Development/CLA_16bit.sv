module CLA_16bit(A, B, Cin, Sum, Cout, overflow); 


input [15:0] A, B;
input Cin;
output [15:0] Sum;
output Cout;
output overflow; 

wire [15:0] temp;
wire [3:0] Propagate, Generate;
wire c0, c1, c2, c3, both_pos, both_neg;

//TODO: look at chapter 8.6 for logic
CLA_4bit CLA1(.Sum(temp[3:0]), .Prop_Val(Propagate[0]), .Gen_Val(Generate[0]), .A(A[3:0]), .B(B[3:0]), .Cin(c0), .Cout());
CLA_4bit CLA2(.Sum(temp[7:4]),  .Prop_Val(Propagate[1]), .Gen_Val(Generate[1]), .A(A[7:4]), .B(B[7:4]), .Cin(c1), .Cout());
CLA_4bit CLA3(.Sum(temp[11:8]),  .Prop_Val(Propagate[2]), .Gen_Val(Generate[2]), .A(A[11:8]), .B(B[11:8]), .Cin(c2), .Cout());
CLA_4bit CLA4(.Sum(temp[15:12]),  .Prop_Val(Propagate[3]), .Gen_Val(Generate[3]), .A(A[15:12]), .B(B[15:12]), .Cin(c3), .Cout());


//logic here for CIN
assign c0 = Cin; 
assign c1 = Generate[0] | (Propagate[0] & c0);
assign c2 = Generate[1] | (Propagate[1] & Generate[0]) | (Propagate[1] & Propagate[0] & c0);
assign c3 = Generate[2] | (Propagate[2] & Generate[1]) | (Propagate[2] & Propagate[1] & Generate[0]) | (Propagate[2] & Propagate[1] & Propagate[0] & c0); 

//Cout
assign Cout = Generate[3] | (Propagate[3] & Generate[2]) | (Propagate[3] & Propagate[2] & Generate[1]) | (Propagate[3] & Propagate[2] & Propagate[1] & Generate[0]) |(Propagate[3] & Propagate[2] & Propagate[1] & Propagate[0] & c0);

//Overflow
assign both_pos = ~A[15] & ~B[15];
assign both_neg = A[15] & B[15];
assign overflow = (temp[15] & both_pos | ~temp[15] & both_neg); 
assign Sum = (temp[15] & both_pos) ? 16'h7FFF :
	     (~temp[15] & both_neg) ? 16'h8000 : temp;
endmodule
