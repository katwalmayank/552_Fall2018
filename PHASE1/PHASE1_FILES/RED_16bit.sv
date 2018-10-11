module RED_16bit(A, B, Sum);

input [15:0] A, B;
output [15:0] Sum;

wire [8:0] top_half, bottom_half;
wire [3:0] sum_ab1, sum_ab2, sum_cd1, sum_cd2, sum_bottom, sum_top, sum_carry;
wire ab1_c, ab2_c, cd1_c, cd2_c, carry_bottom, carry_top, final_carry;


// Add A and B [3:0]
CLA_4bit CLA1(.Sum(sum_ab1), .Cout(ab1_c), .A(A[3:0]), .B(B[3:0]), .Cin(1'b0));
// Add A and B [7:4] 
CLA_4bit CLA2(.Sum(sum_ab2), .Cout(ab2_c), .A(A[7:4]), .B(B[7:4]), .Cin(ab1_c));

// Add C and D [11:8]
CLA_4bit CLA3(.Sum(sum_cd1), .Cout(cd1_c), .A(A[11:8]), .B(B[11:8]), .Cin(1'b0));
// Add C and D [15:12]
CLA_4bit CLA4(.Sum(sum_cd2), .Cout(cd2_c), .A(A[11:8]), .B(B[11:8]), .Cin(cd1_c));

// Concat bottom half
assign bottom_half = {ab2_c, sum_ab2, sum_ab1};
// Concat top half
assign top_half = {cd2_c, sum_cd2, sum_cd1};

// Add low bits of concat
CLA_4bit CLA5(.Sum(sum_bottom), .Cout(carry_bottom), .A(bottom_half[3:0]), .B(top_half[3:0]), .Cin(1'b0));
// Add top bits of concat
CLA_4bit CLA6(.Sum(sum_top), .Cout(carry_top), .A(bottom_half[7:4]), .B(top_half[7:4]), .Cin(carry_bottom));

// Add carry
CLA_4bit(.Sum(sum_carry), .Cout(final_carry), .A({3'b0, bottom_half[8]}), .B({3'b0, top_half[8]}), .Cin(carry_top)); 

assign Sum = {{8{sum_carry[0]}}, sum_top, sum_bottom};
endmodule