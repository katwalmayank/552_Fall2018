module IF_ID(clk, rst_n, IF_inst, IF_PC, ID_inst, ID_PC, wen);

input clk, rst_n,wen;
input [15:0] IF_inst, IF_PC;
output [15:0] ID_inst, ID_PC;

dff_16bit instruction(.D(IF_inst), .clk(clk), .rst(~rst_n), .Q(ID_inst), .wen(wen));
dff_16bit pc_val(.D(IF_PC), .clk(clk), .rst(~rst_n), .Q(ID_PC), .wen(wen));

endmodule
