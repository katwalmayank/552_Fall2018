module PSA_16bit_tb();

reg [15:0] Sum,A,B;
logic Error; 
reg[16:0] loop_A, loop_B; //to check for max value 

 
PSA_16bit PSA(.Sum(Sum), .A(A),.B(B),.Error(Error)); 

initial begin	
		 A = 16'b00000000000000000000;
		 B = 16'b00000000000000000000; 
		for(loop_A = 0; loop_A < 65536; loop_A++)
		begin 
			A = A+1; 
			for(loop_B = 0; loop_B < 65536; loop_B++)
			begin
				B = B+1; 
				#5 $display("A: %h  B: %h , Sum: %h  Error: %d", A,B,Sum,Error);
			end 
		end
		
end 

endmodule 
