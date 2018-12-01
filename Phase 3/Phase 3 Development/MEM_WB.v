module MEM_WB(clk, rst_n, MEM_ALUval, MEM_RegWrite, MEM_DstReg, MEM_ReadData, MEM_MemtoReg, MEM_halt, 
			  WB_RegWrite, WB_DstReg, WB_ReadData, WB_MemtoReg, WB_halt, WB_ALUval, wen);

input clk, rst_n, wen; 

input MEM_halt;
output WB_halt;

input MEM_RegWrite;
output WB_RegWrite;

input[3:0] MEM_DstReg;
output[3:0] WB_DstReg;

input[15:0] MEM_ALUval, MEM_ReadData;
output[15:0] WB_ALUval, WB_ReadData; 

input MEM_MemtoReg;
output WB_MemtoReg;

dff reg_halt(.q(WB_halt), .d(MEM_halt), .wen(wen), .clk(clk), .rst(~rst_n));
dff reg_write(.q(WB_RegWrite), .d(MEM_RegWrite), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit alu_val(.q(WB_ALUval), .d(MEM_ALUval), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit read_data(.q(WB_ReadData), .d(MEM_ReadData), .wen(wen), .clk(clk), .rst(~rst_n));
dff_4bit dst_reg(.q(WB_DstReg), .d(MEM_DstReg), .wen(wen), .clk(clk), .rst(~rst_n));
dff MemtoReg(.q(WB_MemtoReg), .d(MEM_MemtoReg), .wen(wen), .clk(clk), .rst(~rst_n));

endmodule

