module addsub_4bit(Sum, Ovfl, A, B, sub);

output [3:0] Sum;
output Ovfl;
input [3:0] A, B;
input sub;
wire w1, w2, w3, w4;

full_adder_1bit FA1(.c_out(w1), .sum(Sum[0]), .a(A[0]), .b(B[0] ^ sub), .c_in(sub));
full_adder_1bit FA2(.c_out(w2), .sum(Sum[1]), .a(A[1]), .b(B[1] ^ sub), .c_in(w1));
full_adder_1bit FA3(.c_out(w3), .sum(Sum[2]), .a(A[2]), .b(B[2] ^ sub), .c_in(w2));
full_adder_1bit FA4(.c_out(w4), .sum(Sum[3]), .a(A[3]), .b(B[3] ^ sub), .c_in(w3));

assign Ovfl = w4 ^ w3;

endmodule