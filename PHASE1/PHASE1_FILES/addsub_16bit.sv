module addsub_16bit(Sum, A, B, Sub, Ovfl);

output [15:0] Sum;
output Ovfl;
input [15:0] A, B;
input Sub;

wire [15:0] temp;
wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15;
wire both_pos, both_neg, overflow;

full_adder_1bit FA0(.c_out(w0), .sum(temp[0]), .a(A[0]), .b(B[0] ^ Sub), .c_in(Sub));
full_adder_1bit FA1(.c_out(w1), .sum(temp[1]), .a(A[1]), .b(B[1] ^ Sub), .c_in(w0));
full_adder_1bit FA2(.c_out(w2), .sum(temp[2]), .a(A[2]), .b(B[2] ^ Sub), .c_in(w1));
full_adder_1bit FA3(.c_out(w3), .sum(temp[3]), .a(A[3]), .b(B[3] ^ Sub), .c_in(w2));
full_adder_1bit FA4(.c_out(w4), .sum(temp[4]), .a(A[4]), .b(B[4] ^ Sub), .c_in(w3));
full_adder_1bit FA5(.c_out(w5), .sum(temp[5]), .a(A[5]), .b(B[5] ^ Sub), .c_in(w4));
full_adder_1bit FA6(.c_out(w6), .sum(temp[6]), .a(A[6]), .b(B[6] ^ Sub), .c_in(w5));
full_adder_1bit FA7(.c_out(w7), .sum(temp[7]), .a(A[7]), .b(B[7] ^ Sub), .c_in(w6));
full_adder_1bit FA8(.c_out(w8), .sum(temp[8]), .a(A[8]), .b(B[8] ^ Sub), .c_in(w7));
full_adder_1bit FA9(.c_out(w9), .sum(temp[9]), .a(A[9]), .b(B[9] ^ Sub), .c_in(w8));
full_adder_1bit FA10(.c_out(w10), .sum(temp[10]), .a(A[10]), .b(B[10] ^ Sub), .c_in(w9));
full_adder_1bit FA11(.c_out(w11), .sum(temp[11]), .a(A[11]), .b(B[11] ^ Sub), .c_in(w10));
full_adder_1bit FA12(.c_out(w12), .sum(temp[12]), .a(A[12]), .b(B[12] ^ Sub), .c_in(w11));
full_adder_1bit FA13(.c_out(w13), .sum(temp[13]), .a(A[13]), .b(B[13] ^ Sub), .c_in(w12));
full_adder_1bit FA14(.c_out(w14), .sum(temp[14]), .a(A[14]), .b(B[14] ^ Sub), .c_in(w13));
full_adder_1bit FA15(.c_out(w15), .sum(temp[15]), .a(A[15]), .b(B[15] ^ Sub), .c_in(w14));

// If no overflow, return computation, otherwise saturate
assign both_pos = ~A[15] & ~B[15];
assign both_neg = A[15] & B[15];
assign Ovfl = w14 ^ w15;
assign Sum = (overflow & both_pos & ~Sub) ? 16'h7FFF :
	     (overflow & both_neg & ~Sub) ? 16'h8000 :
             (overflow & A[15] & ~B[15] & Sub) ? 16'h8000 :
	     (overflow & ~A[15] & B[15] & Sub) ? 16'h7FFF :	
	      temp;

endmodule