module Control(Opcode, RegDst, Branch, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Mem, Modify);

input [3:0] Opcode;
output [2:0] ALUOp;
output RegDst, Branch, MemtoReg, MemWrite, ALUSrc, RegWrite, Mem, Modify;

// Unused at the moment, maybe we replace Mem with this at some point?
//assign RegDst = 
//assign Branch = 

// LW
assign MemtoReg = (Opcode == 4'b1000);

// SW
assign MemWrite = (Opcode == 4'b1001);

// ALU gets value from reg2 (default) or from offset/imm?
// LW, SW
assign ALUSrc = (Opcode == 4'b1000 | Opcode == 4'b1001);

// This should be set to change rt from the instruction[3:0] to instruction[11:8]
// Ex. LW, SW
assign Mem = (Opcode == 4'b1000 | Opcode == 4'b1001);

// The four bit opcode we'll send to the ALU
// ADD for SW and LW (to compute mem location)
// Otherwise use last three bits of Opcode
assign ALUOp = (Mem) ? 3'b000 : Opcode[2:0];

// LW, LLB, LHB, any Compute Op
assign RegWrite = (Opcode == 4'b1000 | Opcode == 4'b1010 | Opcode == 4'b1011 | ~Opcode[3]);

// This should be set to read from rd instead of rt
// Ex. LLB, LHB
assign Modify = (Opcode == 4'b1010 | Opcode == 4'b1011);

endmodule
