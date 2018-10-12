module cpu(clk, rst_n, hlt, pc);

input clk;
input rst_n; 
output hlt;
output [15:0] pc;

wire [15:0] instruction, pc_in, pc_out, alu_out, alu_in1, alu_in2, inst_addr, data_addr, data_out, data_in, data_w;
wire [3:0] opcode, rt, rs, mem_offset, reg1, reg2, reg1_out, reg2_out, dst_reg, dst_data;
wire [2:0] alu_op;
wire reg_w;

// ********** INSTRUCTIONS CURRENTLY WIRED UP **********
// Opcode	Instr
// 1000		LW
// 1001		SW

// PC Control
PC_control PC(.opcode(), .data_in(), .C(), .I(), .F(), .PC_in(pc_in), .PC_out(pc_out));

// Report current pc value
assign pc = pc_out;

// Instruction Memory
memory1c InstMem(.data_out(instruction), .data_in(16'bx), .addr(inst_addr), .enable(1'b1), .wr(1'bx), .clk(clk), .rst(~rst_n));

assign inst_addr = pc_out;
assign opcode = instruction[15:12];
assign rt = instruction[11:8];
assign rs = instruction[7:4];
assign mem_offset = instruction[3:0];

// Data Memory
memory1c DataMem(.data_out(data_out), .data_in(data_in), .addr(data_addr), .enable(1'b1), .wr(data_w), .clk(clk), .rst(~rst_n)); 

assign data_addr = (opcode == 4'b1000 | opcode == 4'b1001) ? alu_out : 16'bx;
assign data_in = (opcode == 4'b1001) ? reg2_out : 16'bx;
assign data_w = (opcode == 4'b1001);

// Registers
RegisterFile Registers(.clk(clk), .rst(~rst_n), .SrcReg1(reg1), .SrcReg2(reg2), .DstReg(dst_reg), .WriteReg(reg_w), .DstData(dst_data), .SrcData1(reg1_out), .SrcData2(reg2_out));

assign reg1 = (opcode == 4'b1000 | opcode == 4'b1001) ? rs : 4'bx;
assign reg2 = (opcode == 4'b1001) ? rt : 4'bx;
assign dst_reg = (opcode == 4'b1000) ? rt : 4'bx;
assign dst_data = (opcode == 4'b1000) ? data_out : 16'bx;
assign reg_w = (opcode == 4'b1000);

// ALU
ALU Alu(.ALU_Out(alu_out), .Error(), .ALU_In1(alu_in1), .ALU_In2(alu_in2), .Opcode(alu_op), .Flags());

assign alu_op = (opcode == 4'b1000 | opcode == 4'b1001) ? 3'b000 : 4'bx;
assign alu_in1 = (opcode == 4'b1000 | opcode == 4'b1001) ? reg1_out : 16'bx;
assign alu_in2 = (opcode == 4'b1000 | opcode == 4'b1001) ? mem_offset : 16'bx;





endmodule
