module full_adder_1bit(Sum, Cin, Cout, A, B);

input  A, B, Cin; 
output Cout, Sum;  

assign Cout = (B&Cin) | (A&Cin) | (A&B);
assign Sum = (A&~B&~Cin)|(~A&B&~Cin)| (~A&~B&Cin)| (A&B&Cin) ; 

endmodule
