module addsub_4bit (Sum, Ovfl, A, B, sub);
input[3:0] A, B; //Input values
input sub; // add-sub indicator
output[3:0] Sum; //sum output
output Ovfl; //To indicate overflow

wire carry1, carry2, carry3, carry4; 
reg[3:0] new_b;

assign new_b = sub ? ~B : B;
 

full_adder_1bit FA1 (.A(A[0]),.B(new_b[0]),.Cin(sub),.Cout(carry1),.Sum(Sum[0]));
full_adder_1bit FA2 (.A(A[1]),.B(new_b[1]),.Cin(carry1),.Cout(carry2),.Sum(Sum[1]));
full_adder_1bit FA3 (.A(A[2]),.B(new_b[2]),.Cin(carry2),.Cout(carry3),.Sum(Sum[2]));
full_adder_1bit FA4 (.A(A[3]),.B(new_b[3]),.Cin(carry3),.Cout(carry4),.Sum(Sum[3]));
assign Ovfl = carry3 ^ carry4; 

endmodule
