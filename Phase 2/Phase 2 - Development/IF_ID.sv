module IF_ID(clk, rst_n, instruction_in, pc_in, instruction_out, pc_out,wen);

input clk, rst_n,wen;
input [15:0] instruction_in, pc_in;
output [15:0] instruction_out, pc_out;

dff_16bit instruction(.D(instruction_in), .clk(clk), .rst(~rst_n), .Q(instruction_out), .wen(wen));
dff_16bit pc_val(.D(pc_in), .clk(clk), .rst(~rst_n), .Q(pc_out), .wen(wen));

endmodule
