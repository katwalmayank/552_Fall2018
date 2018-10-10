module addsub_4bit_tb();
logic sub; 
reg signed [3:0] Sum,A,B;
logic Ovfl; 
reg signed [4:0] result; 

addsub_4bit ripple_carry_adder(.Sum(Sum), .A(A),.B(B),.sub(sub),.Ovfl(Ovfl)); 

initial begin	
	repeat(20) begin 
		A = $random; 
		B = $random; 
		sub = $random;	
		result = sub ? A-B : A+B; 
 
		#5 $display("A: %d  B: %d  sub: %d, Expected: %d  Actual: %d  Overflow: %d", A,B,sub,result,Sum,Ovfl);
		end
end 

endmodule 