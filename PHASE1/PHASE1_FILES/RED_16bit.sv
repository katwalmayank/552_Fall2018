module RED_16bit(A, B, Sum);

input [15:0] A, B;
output [15:0] Sum;

wire [8:0] top_half, bottom_half;
wire [3:0] BD_Bottom, BD_Top, AC_Bottom, AC_Top, sum_bottom, sum_top, sum_carry;
wire bd1_c, bd2_c, ac1_c, ac2_c, carry_bottom, carry_top, final_carry;

//INPUT: AAAAAAAA_BBBBBBBB + CCCCCCCC_DDDDDDDD

// BBBB + DDDD - bottom
CLA_4bit CLA1(.Sum(BD_Bottom), .Cout(bd1_c), .A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .Prop_Val(), .Gen_Val());

// BBBB + DDDD - top
CLA_4bit CLA2(.Sum(BD_Top), .Cout(bd2_c), .A(A[7:4]), .B(B[7:4]), .Cin(bd1_c), .Prop_Val(), .Gen_Val());

// AAAA + CCCC - bottom
CLA_4bit CLA3(.Sum(AC_Bottom), .Cout(ac1_c), .A(A[11:8]), .B(B[11:8]), .Cin(1'b0), .Prop_Val(), .Gen_Val());

// AAAA + CCCC - top
CLA_4bit CLA4(.Sum(AC_Top), .Cout(ac2_c), .A(A[11:8]), .B(B[11:8]), .Cin(ac1_c), .Prop_Val(), .Gen_Val());

// Concat (BBBBBBBB + DDDDDDDD)
assign bottom_half = {bd2_c, BD_Top, BD_Bottom};

// Concat (AAAAAAAA + CCCCCCCC)
assign top_half = {ac2_c, AC_Top, AC_Bottom};

// Add low bits of concat
CLA_4bit CLA5(.Sum(sum_bottom), .Cout(carry_bottom), .A(bottom_half[3:0]), .B(top_half[3:0]), .Cin(1'b0), .Prop_Val(), .Gen_Val());

// Add top bits of concat
CLA_4bit CLA6(.Sum(sum_top), .Cout(carry_top), .A(bottom_half[7:4]), .B(top_half[7:4]), .Cin(carry_bottom), .Prop_Val(), .Gen_Val());

// Add carry
CLA_4bit CLA7(.Sum(sum_carry), .Cout(final_carry), .A({3'b0, bottom_half[8]}), .B({3'b0, top_half[8]}), .Cin(carry_top), .Prop_Val(), .Gen_Val()); 

assign Sum = {{8{sum_carry[0]}}, sum_top, sum_bottom};
endmodule