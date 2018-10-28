module ID_EX(
	input clk, 
	input rst_n, 
	input wen,
	input [2:0] ID_ALUOp,
	input ID_MemtoReg, 
	input ID_MemWrite, 
	input ID_ALUSrc, 
	input ID_RegWrite, 
	input ID_Mem, 
	input ID_Modify, 
	input ID_Shift,
	input [15:0] ID_ReadData1,
	input [15:0] ID_ReadData2,
	input [3:0] ID_MemOffset,
	input ID_PCS,
	input [3:0] ID_Rt,
	input [3:0] ID_Rd,
	input [7:0] ID_Imm,
	input [15:0] ID_PC_INC_OUT,
	input [3:0] ID_opcode,
	output [2:0] EX_ALUOp,
	output EX_MemtoReg,
	output EX_MemWrite,
	output EX_ALUSrc,
	output EX_RegWrite,
	output EX_Mem,
	output EX_Modify,
	output EX_Shift,
	output [15:0] EX_ReadData1,
	output [15:0] EX_ReadData2,
	output [3:0] EX_MemOffset,
	output EX_PCS,
	output [3:0] EX_Rt,
	output [3:0] EX_Rd,
	output [7:0] EX_Imm,
	output [15:0] EX_PC_INC_OUT,
	output [3:0] EX_opcode
);

wire [3:0] temp;

assign EX_ALUOp = temp[2:0];

// ALUOp
dff_4bit FF_ALUOp(.q(temp), .d({1'b0,ID_ALUOp}), .wen(wen), .clk(clk), .rst(~rst_n));
// MemtoReg
dff FF_MemtoReg(.q(EX_MemtoReg), .d(ID_MemtoReg), .wen(wen), .clk(clk), .rst(~rst_n));
// MemWrite
dff FF_MemWrite(.q(EX_MemWrite), .d(ID_MemWrite), .wen(wen), .clk(clk), .rst(~rst_n));
// ALUSrc
dff FF_ALUSrc(.q(EX_ALUSrc), .d(ID_ALUSrc), .wen(wen), .clk(clk), .rst(~rst_n));
// RegWrite
dff FF_RegWrite(.q(EX_RegWrite), .d(ID_RegWrite), .wen(wen), .clk(clk), .rst(~rst_n));
// Mem
dff FF_Mem(.q(EX_Mem), .d(ID_Mem), .wen(wen), .clk(clk), .rst(~rst_n));
// Modify
dff FF_Modify(.q(EX_Modify), .d(ID_Modify), .wen(wen), .clk(clk), .rst(~rst_n));
// Shift
dff FF_Shift(.q(EX_Shift), .d(ID_Shift), .wen(wen), .clk(clk), .rst(~rst_n));
// PCS
dff FF_PCS(.q(EX_PCS), .d(ID_PCS), .wen(wen), .clk(clk), .rst(~rst_n));
// MemOffset
dff_4bit FF_MemOffset(.q(EX_MemOffset), .d(ID_MemOffset), .wen(wen), .clk(clk), .rst(~rst_n));

// Read Data 1
dff_16bit FF_ReadData1(.q(EX_ReadData1), .d(ID_ReadData1), .wen(wen), .clk(clk), .rst(~rst_n));
// Read Data 2
dff_16bit FF_ReadData2(.q(EX_ReadData2), .d(ID_ReadData2), .wen(wen), .clk(clk), .rst(~rst_n));
// Rt
dff_4bit FF_Rt(.q(EX_Rt), .d(ID_Rt), .wen(wen), .clk(clk), .rst(~rst_n));
// Rd
dff_4bit FF_Rd(.q(EX_Rd), .d(ID_Rd), .wen(wen), .clk(clk), .rst(~rst_n));
// PC INC OUT
dff_16bit FF_PC_INC_OUT(.q(EX_PC_INC_OUT), .d(ID_PC_INC_OUT), .wen(wen), .clk(clk), .rst(~rst_n));

// imm [3:0]
dff_4bit FF_imm1(.q(EX_Imm[3:0]), .d(ID_Imm[3:0]), .wen(wen), .clk(clk), .rst(~rst_n));
// imm [7:4]
dff_4bit FF_imm2(.q(EX_Imm[7:4]), .d(ID_Imm[7:4]), .wen(wen), .clk(clk), .rst(~rst_n));
// opcode
dff_4bit FF_opcode(.q(EX_opcode), .d(ID_opcode), .wen(wen), .clk(clk), .rst(~rst_n));
endmodule
