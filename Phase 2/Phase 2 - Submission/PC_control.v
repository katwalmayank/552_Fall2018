module PC_control(opcode, data_in, C, I, F, PC_in, PC_out, branch_taken);

input [15:0] PC_in;
input [8:0] I;
input [2:0] C, F;
input [15:0] data_in; 
input [3:0] opcode; 
output [15:0] PC_out;
output branch_taken;

wire [15:0] I_shift, target, pc_next, imm;

wire [15:0] branch_out, brach_reg_out; 

assign I_shift = {6'b0, I, 1'b0};

// PC + 2
adder_16bit add1(.sum(pc_next), .a(PC_in), .b(16'h0002));

// Since we get our branch in the decode stage, the pc has already incremented.  Thus PC_in is already PC + 2
// (PC + 2) + I << 1
adder_16bit add2(.sum(imm), .a(PC_in), .b(I_shift));

//B if opcode is 0 BR if opcode is 1
assign target = opcode[0] ? data_in : imm;

// F[2:0] = [Z,V,N]
assign branch_taken = ((opcode == 4'b1100) | (opcode == 4'b1101)) & 
		((C == 3'b000 & ~F[2]) | (C == 3'b001 &  F[2]) | (C == 3'b010 & (~F[2] & ~F[0])) | (C == 3'b011 &  F[0]) |				
		(C == 3'b100 &  (F[2] | (~F[2] & ~F[0]))) | (C == 3'b101 & (F[2] | F[0])) | (C == 3'b110 & F[1]) | (C == 3'b111));	

assign PC_out = branch_taken ? target : pc_next;

endmodule