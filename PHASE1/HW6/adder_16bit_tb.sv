module adder_16bit_tb();
reg [15:0] Sum,A,B;
logic Ovfl; 
reg [16:0] result; 

adder_16bit ripple_carry_adder(.Sum(Sum), .A(A),.B(B),.Ovfl(Ovfl)); 

initial begin	
		#5
		A = 16'b 0110001010101010; 
		B = 16'b 1101010101010111; 	
		result = A+B; 
 
		#5$display("A: %d  B: %d Expected: %d  Actual: %d  Overflow: %d", A,B,result,Sum,Ovfl);
end 

endmodule 