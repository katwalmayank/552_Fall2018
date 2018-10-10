module adder_16bit (Sum, Ovfl, A, B);
input[15:0] A, B; //Input values
output[15:0] Sum; //sum output
output Ovfl; //To indicate overflow

wire carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9, carry10,carry11,carry12, carry13, carry14, carry15, carry16; 

 

full_adder_1bit FA1 (.A(A[0]),.B(B[0]),.Cin(1'b0),.Cout(carry1),.Sum(Sum[0]));
full_adder_1bit FA2 (.A(A[1]),.B(B[1]),.Cin(carry1),.Cout(carry2),.Sum(Sum[1]));
full_adder_1bit FA3 (.A(A[2]),.B(B[2]),.Cin(carry2),.Cout(carry3),.Sum(Sum[2]));
full_adder_1bit FA4 (.A(A[3]),.B(B[3]),.Cin(carry3),.Cout(carry4),.Sum(Sum[3]));
full_adder_1bit FA5 (.A(A[4]),.B(B[4]),.Cin(carry4),.Cout(carry5),.Sum(Sum[4]));
full_adder_1bit FA6 (.A(A[5]),.B(B[5]),.Cin(carry5),.Cout(carry6),.Sum(Sum[5]));
full_adder_1bit FA7 (.A(A[6]),.B(B[6]),.Cin(carry6),.Cout(carry7),.Sum(Sum[6]));
full_adder_1bit FA8 (.A(A[7]),.B(B[7]),.Cin(carry7),.Cout(carry8),.Sum(Sum[7]));
full_adder_1bit FA9 (.A(A[8]),.B(B[8]),.Cin(carry8),.Cout(carry9),.Sum(Sum[8]));
full_adder_1bit FA10 (.A(A[9]),.B(B[9]),.Cin(carry9),.Cout(carry10),.Sum(Sum[9]));
full_adder_1bit FA11 (.A(A[10]),.B(B[10]),.Cin(carry10),.Cout(carry11),.Sum(Sum[10]));
full_adder_1bit FA12 (.A(A[11]),.B(B[11]),.Cin(carry11),.Cout(carry12),.Sum(Sum[11]));
full_adder_1bit FA13 (.A(A[12]),.B(B[12]),.Cin(carry12),.Cout(carry13),.Sum(Sum[12]));
full_adder_1bit FA14 (.A(A[13]),.B(B[13]),.Cin(carry13),.Cout(carry14),.Sum(Sum[13]));
full_adder_1bit FA15 (.A(A[14]),.B(B[14]),.Cin(carry14),.Cout(carry15),.Sum(Sum[14]));
full_adder_1bit FA16 (.A(A[15]),.B(B[15]),.Cin(carry15),.Cout(carry16),.Sum(Sum[15]));


assign Ovfl = carry15 ^ carry16; 

endmodule
