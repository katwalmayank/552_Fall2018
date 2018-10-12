module PC_control_tb();

reg[3:0] C,F; 
reg[8:0] I; 
reg[15:0] PC_in; 
reg[15:0] PC_out; 
reg[15:0] data_in;  
logic [1:0]opcode; 

PC_control PC(.opcode(opcode),.C(C[2:0]),.I(I),.F(F[2:0]),.PC_in(PC_in),.PC_out(PC_out), .data_in(data_in)); 

initial begin	
		for(opcode = 2'b00; opcode < 2'10; opcode++) begin
			for(C = 3'b000; C <= 3'b111; C++) begin 
				for(F = 3'b000; F <= 3'b111; F++) begin 
						I = 9'b000000011;
						data_in = 16'b0001000100011111
						PC_in = 16'b0000000000000001;
						#5 $display("C: %b  F: %b I: %b  PC_in: %b  PC_out %b", C,F,I,PC_in,PC_out);
				end
			end
		end 
	$stop; 

end 

endmodule 
