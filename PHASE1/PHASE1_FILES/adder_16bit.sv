module adder_16bit(sum, a, b);

input [15:0] a, b;
output [15:0] sum;

wire c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;

full_adder_1bit b0(.c_out(c0), .sum(sum[0]), .a(a[0]), .b(b[0]), .c_in(1'b0));
full_adder_1bit b1(.c_out(c1), .sum(sum[1]), .a(a[1]), .b(b[1]), .c_in(c0));
full_adder_1bit b2(.c_out(c2), .sum(sum[2]), .a(a[2]), .b(b[2]), .c_in(c1));
full_adder_1bit b3(.c_out(c3), .sum(sum[3]), .a(a[3]), .b(b[3]), .c_in(c2));
full_adder_1bit b4(.c_out(c4), .sum(sum[4]), .a(a[4]), .b(b[4]), .c_in(c3));
full_adder_1bit b5(.c_out(c5), .sum(sum[5]), .a(a[5]), .b(b[5]), .c_in(c4));
full_adder_1bit b6(.c_out(c6), .sum(sum[6]), .a(a[6]), .b(b[6]), .c_in(c5));
full_adder_1bit b7(.c_out(c7), .sum(sum[7]), .a(a[7]), .b(b[7]), .c_in(c6));
full_adder_1bit b8(.c_out(c8), .sum(sum[8]), .a(a[8]), .b(b[8]), .c_in(c7));
full_adder_1bit b9(.c_out(c9), .sum(sum[9]), .a(a[9]), .b(b[9]), .c_in(c8));
full_adder_1bit b10(.c_out(c10), .sum(sum[10]), .a(a[10]), .b(b[10]), .c_in(c9));
full_adder_1bit b11(.c_out(c11), .sum(sum[11]), .a(a[11]), .b(b[11]), .c_in(c10));
full_adder_1bit b12(.c_out(c12), .sum(sum[12]), .a(a[12]), .b(b[12]), .c_in(c11));
full_adder_1bit b13(.c_out(c13), .sum(sum[13]), .a(a[13]), .b(b[13]), .c_in(c12));
full_adder_1bit b14(.c_out(c14), .sum(sum[14]), .a(a[14]), .b(b[14]), .c_in(c13));
full_adder_1bit b15(.c_out(c15), .sum(sum[15]), .a(a[15]), .b(b[15]), .c_in(c14));

endmodule
