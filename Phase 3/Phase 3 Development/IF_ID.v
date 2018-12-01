module IF_ID(clk, rst_n, IF_inst, IF_PC, IF_PC_INC_OUT, ID_inst, ID_PC, ID_PC_INC_OUT, wen);

input clk, rst_n,wen;
input [15:0] IF_inst, IF_PC, IF_PC_INC_OUT;
output [15:0] ID_inst, ID_PC, ID_PC_INC_OUT;

dff_16bit instruction(.d(IF_inst), .clk(clk), .rst(~rst_n), .q(ID_inst), .wen(wen));
dff_16bit pc_val(.d(IF_PC), .clk(clk), .rst(~rst_n), .q(ID_PC), .wen(wen));
dff_16bit pc_inc_out(.d(IF_PC_INC_OUT), .clk(clk), .rst(~rst_n), .q(ID_PC_INC_OUT), .wen(wen));
endmodule
