module EX_MEM(EX_MemWrite, EX_MemRead, EX_MemtoReg, EX_RegWrite, EX_ALUval, EX_ReadData2, EX_DstReg, rst_n, write_en, clk,
			  MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, MEM_RegWrite, MEM_ALUval, MEM_ReadData2, MEM_DstReg);

input EX_MemWrite;
input EX_MemRead;
input EX_MemtoReg;
input EX_RegWrite;
input [15:0] EX_ALUval;
input [15:0] EX_ReadData2;
input [3:0] EX_DstReg;

input rst_n;
input write_en;
input clk;

output MEM_MemWrite;
output MEM_MemRead;
output MEM_MemtoReg;
output MEM_RegWrite;
output [15:0] MEM_ALUval;
output [15:0] MEM_ReadData2;
output [3:0] MEM_DstReg;

dff mem_write(.q(MEM_MemWrite), .d(EX_MemWrite), .wen(write_en), .clk(clk), .rst(~rst_n));
dff mem_read(.q(MEM_MemRead), .d(EX_MemRead), .wen(write_en), .clk(clk), .rst(~rst_n));
dff mem_to_reg(.q(MEM_MemtoReg), .d(EX_MemtoReg), .wen(write_en), .clk(clk), .rst(~rst_n));
dff reg_write(.q(MEM_RegWrite), .d(EX_RegWrite), .wen(write_en), .clk(clk), .rst(~rst_n));
dff_16bit alu_val(.q(MEM_ALUval), .d(EX_ALUval), .wen(write_en), .clk(clk), .rst(~rst_n));
dff_16bit read_data2(.q(MEM_ReadData2), .d(EX_ReadData2), .wen(write_en), .clk(clk), .rst(~rst_n));
dff_4bit DstReg(.q(MEM_DstReg), .d(EX_DstReg), .wen(write_en), .clk(clk), .rst(~rst_n));

endmodule
