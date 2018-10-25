module EX_MEM(ex_mem_in_mem_write, ex_mem_in_mem_read, ex_mem_in_mem_to_reg, ex_mem_in_reg_write, ex_mem_in_alu_val, rst_n, write_en, clk,
			  ex_mem_out_mem_write, ex_mem_out_mem_read, ex_mem_out_mem_to_reg, ex_mem_out_reg_write, ex_mem_out_alu_val);

input ex_mem_in_mem_write;
input ex_mem_in_mem_read;
input ex_mem_in_mem_to_reg;
input ex_mem_in_reg_write;
input [15:0] ex_mem_in_alu_val;

input rst_n;
input write_en;
input clk;

output ex_mem_out_mem_write;
output ex_mem_out_mem_read;
output ex_mem_out_mem_to_reg;
output ex_mem_out_reg_write;
output [15:0] ex_mem_out_alu_val;

dff mem_write(.q(ex_mem_out_mem_write), .d(ex_mem_in_mem_write), .we(write_en), .clk(clk), .rst(rst_n));
dff mem_read(.q(ex_mem_out_mem_read), .d(ex_mem_in_mem_read), .we(write_en), .clk(clk), .rst(rst_n));
dff mem_to_reg(.q(ex_mem_out_mem_to_reg), .d(ex_mem_in_mem_to_reg), .we(write_en), .clk(clk), .rst(rst_n));
dff reg_write(.q(ex_mem_out_reg_write), .d(ex_mem_in_reg_write), .we(write_en), .clk(clk), .rst(rst_n));
dff_16bit alu_val(.q(ex_mem_out_alu_val), .d(ex_mem_in_alu_val), .wen(write_en), .clk(clk), .rst(rst_n));

endmodule
