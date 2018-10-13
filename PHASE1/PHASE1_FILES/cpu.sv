module cpu(clk, rst_n, hlt, pc);

input clk;
input rst_n; 
output hlt;
output [15:0] pc;

wire [15:0] instruction, pc_in, pc_out, alu_out, alu_in1, alu_in2, inst_addr, data_addr, data_out, data_in, data_w;
wire [3:0] opcode, rt, rs, mem_offset, reg1, reg2, reg1_out, reg2_out, dst_reg, dst_data;
wire [2:0] alu_op, ALUOp;
wire reg_w, RegDst, Branch, MemtoReg, MemWrite, ALUSrc, RegWrite, Mem, Modify;

// ********** INSTRUCTIONS CURRENTLY WIRED UP **********
// Opcode	Instr
// 0000		ADD
// 0001		SUB
// 0010		XOR
// 0011		RED
// 0100		SLL
// 0101		SRA
// 0110		ROR
// 0111		PADDSB
// 1000		LW
// 1001		SW
// 1010		LLB
// 1011		LHB

// PC Control
PC_control PC(.opcode(), .data_in(), .C(), .I(), .F(), .PC_in(pc_in), .PC_out(pc_out));

//dff to hold pc value 
dff_16bit pc_dff (.q(PC_in), .d(PC_out), .wen(), .clk(clk), .rst(rst));

// Report current pc value
assign pc = pc_out;

// Instruction Memory
memory1c InstMem(.data_out(instruction), .data_in(16'bx), .addr(inst_addr), .enable(1'b1), .wr(1'bx), .clk(clk), .rst(~rst_n));

assign inst_addr = pc_out;
assign opcode = instruction[15:12];
assign rd = instruction[11:8];
assign rs = instruction[7:4];
assign rt = (Mem) ? instruction[11:8] : instruction[3:0];
assign mem_offset = instruction[3:0];
assign imm = instruction[7:0];

// Control Unit
Control Contr(.Opcode(opcode), .RegDst(RegDst), .Branch(Branch), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite),
		.ALUSrc(ALUSrc), .RegWrite(RegWrite), .Mem(Mem), .Modyify(Modify));

// Data Memory
memory1c DataMem(.data_out(data_out), .data_in(data_in), .addr(data_addr), .enable(1'b1), .wr(data_w), .clk(clk), .rst(~rst_n)); 

assign data_addr = alu_out;
assign data_in = reg2_out;
assign data_w = MemWrite;

// Registers
RegisterFile Registers(.clk(clk), .rst(~rst_n), .SrcReg1(reg1), .SrcReg2(reg2), .DstReg(dst_reg), .WriteReg(reg_w), .DstData(dst_data), .SrcData1(reg1_out), .SrcData2(reg2_out));

assign reg1 = rs;
assign reg2 = (Modify) ? rd : rt;
assign dst_reg = (Mem) ? rt : rd;
assign dst_data = (MemtoReg) ? data_out :
		  (~Modify) ? alu_out :
		  (opcode == 4'b1010) ? ((reg2_out & 16'hFF00) | {8'b0, imm}) : 
		  ((reg2_out & 16'h00FF) | {imm, 8'b0});
assign reg_w = RegWrite;

// ALU
ALU Alu(.ALU_Out(alu_out), .Error(), .ALU_In1(alu_in1), .ALU_In2(alu_in2), .Opcode(alu_op), .Flags());

assign alu_op = ALUOp;
assign alu_in1 = reg1_out;
assign alu_in2 = ~ALUSrc ? reg2_out : {{12{mem_offset[3]}},  mem_offset} << 1;

endmodule
