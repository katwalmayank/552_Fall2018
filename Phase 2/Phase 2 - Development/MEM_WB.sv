module MEM_WB(clk,rst_n,MEM_Reg_Write, WB_Reg_Write, MEM_Write_data,WB_Write_data,MEM_dst_reg, WB_dst_reg,MEM_Read_data, WB_Read_data, wen);

input clk, rst_n,wen; 

input MEM_Reg_Write;
output WB_Reg_Write;


input[3:0] MEM_dst_reg;
output[3:0] WB_dst_reg;


input[15:0] MEM_Write_data, MEM_Read_data;
output[15:0] WB_Write_data, WB_Read_data; 


dff reg_write(.q(WB_Reg_Write), .d(MEM_Reg_Write), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit write_data(.q(WB_Write_data), .d(MEM_Write_data), .wen(wen), .clk(clk), .rst(~rst_n));
dff_16bit read_data(.q(WB_Read_data), .d(MEM_Read_data), .wen(wen), .clk(clk), .rst(~rst_n));
dff_4bit dst_reg(.q(WB_dst_reg), .d(MEM_dst_reg), .wen(wen), .clk(clk), .rst(~rst_n));


endmodule

