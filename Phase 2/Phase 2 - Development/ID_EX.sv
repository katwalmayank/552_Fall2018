module ID_EX(
	input clk, 
	input rst_n, 
	input wen,
	input ID_MemtoReg, 
	input ID_MemWrite, 
	input ID_ALUSrc, 
	input ID_RegWrite, 
	input ID_Mem, 
	input ID_Modify, 
	input ID_Shift,
	input [15:0] IF_ReadData1,
	input [15:0] IF_ReadData2,
	output EX_MemtoReg,
	output EX_MemWrite,
	output EX_ALUSrc,
	output EX_RegWrite,
	output EX_Mem,
	output EX_Modify,
	output EX_Shift,
	output [15:0] EX_ReadData1,
	output [15:0] EX_ReadData2
);

// MemtoReg
dff FF_MemtoReg(.q(ID_MemtoReg), .d(EX_MemtoReg), .wen(wen), .clk(clk), .rst(~rst_n));
// MemWrite
dff FF_MemWrite(.q(ID_MemWrite), .d(EX_MemWrite), .wen(wen), .clk(clk), .rst(~rst_n));
// ALUSrc
dff FF_ALUSrc(.q(ID_ALUSrc), .d(EX_ALUSrc), .wen(wen), .clk(clk), .rst(~rst_n));
// RegWrite
dff FF_RegWrite(.q(ID_RegWrite), .d(EX_RegWrite), .wen(wen), .clk(clk), .rst(~rst_n));
// Mem
dff FF_Mem(.q(ID_Mem), .d(EX_Mem), .wen(wen), .clk(clk), .rst(~rst_n));
// Modify
dff FF_Modify(.q(ID_Modify), .d(EX_Modify), .wen(wen), .clk(clk), .rst(~rst_n));
// Shift
dff FF_Shift(.q(ID_Shift), .d(EX_Shift), .wen(wen), .clk(clk), .rst(~rst_n));

// Read Data 1
dff_16bit FF_ReadData1(.q(IF_ReadData1), .d(EX_ReadData1), .wen(wen), .clk(clk), .rst(~rst_n));
// Read Data 2
dff_16bit FF_ReadData2(.q(IF_ReadData2), .d(EX_ReadData2), .wen(wen), .clk(clk), .rst(~rst_n));



endmodule
