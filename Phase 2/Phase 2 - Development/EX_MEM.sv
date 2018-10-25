module EX_MEM(EX_MemWrite, EX_MemWrite, EX_MemtoReg, EX_RegWrite, EX_ALUval, rst_n, write_en, clk,
			  MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, MEM_RegWrite, MEM_ALUval);

input EX_MemWrite;
input EX_MemWrite;
input EX_MemtoReg;
input EX_RegWrite;
input [15:0] EX_ALUval;

input rst_n;
input write_en;
input clk;

output MEM_MemWrite;
output MEM_MemRead;
output MEM_MemtoReg;
output MEM_RegWrite;
output [15:0] MEM_ALUval;

dff mem_write(.q(MEM_MemWrite), .d(EX_MemWrite), .we(write_en), .clk(clk), .rst(rst_n));
dff mem_read(.q(MEM_MemRead), .d(EX_MemWrite), .we(write_en), .clk(clk), .rst(rst_n));
dff mem_to_reg(.q(MEM_MemtoReg), .d(EX_MemtoReg), .we(write_en), .clk(clk), .rst(rst_n));
dff reg_write(.q(MEM_RegWrite), .d(EX_RegWrite), .we(write_en), .clk(clk), .rst(rst_n));
dff_16bit alu_val(.q(MEM_ALUval), .d(EX_ALUval), .wen(write_en), .clk(clk), .rst(rst_n));

endmodule
