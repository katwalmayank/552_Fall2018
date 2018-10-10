module PC_control_tb();

reg[2:0] C,F; 
reg[8:0] I; 
reg[15:0] PC_in; 
reg[15:0] PC_out;  

PC_control PC(.C(C),.I(I),.F(F),.PC_in(PC_in),.PC_out(PC_out)); 

initial begin	
		for(C = 3'b000; C <= 3'b111; C++) begin 
			for(F = 3'b000; F <= 3'b111; F++) begin 
					I = 9'b000000011;
					PC_in = 16'b0000000000000001;
					#5 $display("C: %b  F: %b I: %b  PC_in: %b  PC_out %b", C,F,I,PC_in,PC_out);
			end
		end 
end 

endmodule 
