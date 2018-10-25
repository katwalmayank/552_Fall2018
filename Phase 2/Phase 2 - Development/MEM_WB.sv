module MEM_WB(clk, rst_n, MEM_RegWrite, WB_RegWrite, MEM_WriteData, WB_WriteData, MEM_DstReg, WB_DstReg, MEM_ReadData, WB_ReadData, wen);

input clk, rst_n, wen; 

input MEM_RegWrite;
output WB_RegWrite;


input[3:0] MEM_DstReg;
output[3:0] WB_DstReg;


input[15:0] MEM_WriteData, MEM_ReadData;
output[15:0] WB_WriteData, WB_ReadData; 


dff reg_write(.q(WB_RegWrite), .d(MEM_RegWrite), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit write_data(.q(WB_WriteData), .d(MEM_WriteData), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit read_data(.q(WB_ReadData), .d(MEM_ReadData), .wen(wen), .clk(clk), .rst(~rst_n));
dff_4bit dst_reg(.q(WB_DstReg), .d(MEM_DstReg), .wen(wen), .clk(clk), .rst(~rst_n));


endmodule

