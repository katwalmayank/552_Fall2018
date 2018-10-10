module CLA_16bit(A, B, Cin, Sum, Cout); 


input [15:0] A, B;
input Cin;
output [15:0] Sum;
output Cout;

wire [3:0] Propagate, Generate, Carry;




CLA_4bit CLA1(.Sum(Sum[3:0]), .Cout(Carry[0]), .Prop_Val(Propagate[0]), .Gen_Val(Generate[0]), .A(A[3:0]), .B(B[3:0]), .Cin(Cin);
CLA_4bit CLA2(.Sum(Sum[7:4]), .Cout(Carry[1]), .Prop_Val(Propagate[1]), .Gen_Val(Generate[1]), .A(A[7:4]), .B(B[7:4]), .Cin(Cin);
CLA_4bit CLA3(.Sum(Sum[11:8]), .Cout(Carry[2]), .Prop_Val(Propagate[2]), .Gen_Val(Generate[2]), .A(A[11:8]), .B(B[11:8]), .Cin(Cin);
CLA_4bit CLA4(.Sum(Sum[15:12]), .Cout(Carry[3]), .Prop_Val(Propagate[3]), .Gen_Val(Generate[3]), .A(A[15:12]), .B(B[15:12]), .Cin(Cin);

//logic here for sum or cla? 


endmodule
