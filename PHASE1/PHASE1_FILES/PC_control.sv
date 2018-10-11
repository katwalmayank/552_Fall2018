module PC_control(input C[3], input I[9], input F[3], input PC_in[16], output PC_out[16]);

input [15:0] PC_in;
input [8:0] I;
input [2:0] C, F;

output [15:0] PC_out;

wire [15:0] I_shift, target, pc_next;

assign I_shift = {6'b0, I, 1'b0};

// PC + 2
adder_16bit add1(.sum(pc_next), .a(PC_in), .b(2));

// (PC + 2) + I << 1
adder_16bit add2(.sum(target), .a(pc_next), .b(I_shift));

// F[2:0] = [Z,V,N]
assign PC_out = (C == 3'b000 & (~F[2]))  			 ? target : 
		(C == 3'b001 &  (F[2])) 			 ? target : 
		(C == 3'b010 & (~F[2] & ~F[0])) 		 ? target : 
		(C == 3'b011 &  (F[0])) 			 ? target : 
		(C == 3'b100 &  (F[2] | (~F[2] & ~F[0])))	 ? target : 
		(C == 3'b101 & (F[2] | F[0]))			 ? target : 
		(C == 3'b110 & (F[1])) 				 ? target : 
		(C == 3'b111) 					 ? target : 
							         pc_next;

endmodule