module Control(Opcode, MemtoReg, ALUOp, MemRead, MemWrite, ALUSrc, RegWrite, Mem, Modify, Shift, ID_Rd);

input [3:0] Opcode, ID_Rd;
output [2:0] ALUOp;
output MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, Mem, Modify, Shift;

// LW
assign MemtoReg = (Opcode == 4'b1000);

// LW read signal
assign MemRead = (Opcode == 4'b1000);

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

// LW, LLB, LHB, any Compute Op, PCS
assign RegWrite = (Opcode == 4'b1000 | Opcode == 4'b1010 | Opcode == 4'b1011 | (~Opcode[3] & (ID_Rd != 4'b0000)) | Opcode == 4'b1110);

// This should be set to read from rd instead of rt
// Ex. LLB, LHB
assign Modify = (Opcode == 4'b1010 | Opcode == 4'b1011);

// Sets ALU to grab imm value for second operand instead of rt
// Ex. SLL, SRA, ROR
assign Shift = (Opcode == 4'b0100 | Opcode == 4'b0101 | Opcode == 4'b0110);


endmodule
