module MEM_WB(clk, rst_n, MEM_ALUval, WB_ALUval, MEM_RegWrite, WB_RegWrite, MEM_DstReg, WB_DstReg, MEM_ReadData, WB_ReadData, MEM_MemtoReg, WB_MemtoReg, wen);

input clk, rst_n, wen; 

input MEM_RegWrite;
output WB_RegWrite;

input[3:0] MEM_DstReg;
output[3:0] WB_DstReg;

input[15:0] MEM_ALUval, MEM_ReadData;
output[15:0] WB_ALUval, WB_ReadData; 

input MEM_MemtoReg;
output WB_MemtoReg;

dff reg_write(.q(WB_RegWrite), .d(MEM_RegWrite), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit alu_val(.q(WB_ALUval), .d(MEM_ALUval), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit read_data(.q(WB_ReadData), .d(MEM_ReadData), .wen(wen), .clk(clk), .rst(~rst_n));
dff_4bit dst_reg(.q(WB_DstReg), .d(MEM_DstReg), .wen(wen), .clk(clk), .rst(~rst_n));
dff MemtoReg(.q(WB_MemtoReg), .d(MEM_MemtoReg), .wen(wen), .clk(clk), .rst(~rst_n));

endmodule

