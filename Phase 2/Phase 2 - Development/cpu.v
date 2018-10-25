module cpu(clk, rst_n, hlt, pc);

input clk;
input rst_n; 
output hlt;
output [15:0] pc;

wire [15:0] instruction, pc_in, pc_out, alu_out, alu_in1, alu_in2, inst_addr, data_addr, data_out, data_in, pc_inc_out, reg1_out, reg2_out, dst_data;
wire [3:0] opcode, rt, rs, rd, mem_offset, reg1, reg2, dst_reg;
wire [2:0] alu_op, ALUOp, alu_flags, pc_flags, branch_control;
wire reg_w, MemtoReg, MemWrite, ALUSrc, RegWrite, Mem, Modify, pcs, data_w, Shift;
wire [8:0] branch_imm;
wire [7:0] imm;


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
// 1100		B
// 1101		BR
// 1110		PCS
// 1111		HLT


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												PC Control
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			OPCODE FOR Branch	   B or BR addr        Condition to check  Branch Imm Val  Flags set	 PC val         Final PC val
PC_control PC(.opcode(opcode), .data_in(reg1_out), .C(branch_control), .I(branch_imm), .F(pc_flags), .PC_in(pc_in), .PC_out(pc_out));

assign hlt = (opcode == 4'b1111);

// PC Incrementer for PCS
adder_16bit pc_inc(.sum(pc_inc_out), .a(16'h0002), .b(pc_in));

// Report current pc value
assign pc = pc_in;
assign pcs = (opcode == 4'b1110);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												DFF to maintain pc value 
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//				  PC out     PC IN       HALT?       clk        rst_n
dff_16bit pc_dff(.q(pc_in), .d(pc_out), .wen(~hlt), .clk(clk), .rst(~rst_n));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Instruction Memory
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//               Instruction to execute   datain          Address of the insturction			
memory1c InstMem(.data_out(instruction), .data_in(16'bx), .addr(inst_addr), .enable(1'b1), .wr(1'b0), .clk(clk), .rst(~rst_n));

assign inst_addr = pc_in;
assign opcode = instruction[15:12];
assign rd = instruction[11:8];
assign rs = instruction[7:4];
assign rt = (Mem) ? instruction[11:8] : instruction[3:0];
assign mem_offset = instruction[3:0];
assign imm = instruction[7:0];
assign branch_control = instruction[11:9];
assign branch_imm = instruction[8:0];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Control Unit
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Control Contr(.Opcode(opcode), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite),
		.ALUSrc(ALUSrc), .RegWrite(RegWrite), .Mem(Mem), .Modify(Modify), .Shift(Shift));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Data Memory
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

memory1c DataMem(.data_out(data_out), .data_in(data_in), .addr(data_addr), .enable(1'b1), .wr(data_w), .clk(clk), .rst(~rst_n)); 

assign data_addr = alu_out;
assign data_in = reg2_out;
assign data_w = MemWrite;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Registers File System
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

RegisterFile Registers(.clk(clk), .rst(~rst_n), .SrcReg1(reg1), .SrcReg2(reg2), .DstReg(dst_reg), .WriteReg(reg_w), .DstData(dst_data), .SrcData1(reg1_out), .SrcData2(reg2_out));

assign reg1 = rs;
assign reg2 = (Modify) ? rd : rt;
assign dst_reg = (Mem) ? rt : rd;
assign dst_data = (MemtoReg) ? data_out :
		  (pcs) ? pc_inc_out :
		  (~Modify) ? alu_out :
		  (opcode == 4'b1010) ? ((reg2_out & 16'hFF00) | {8'b0, imm}) : 
		  ((reg2_out & 16'h00FF) | {imm, 8'b0});
assign reg_w = RegWrite;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												ALU
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ALU Alu(.ALU_Out(alu_out), .Error(), .ALU_In1(alu_in1), .ALU_In2(alu_in2), .Opcode(alu_op), .Flags(alu_flags));

assign alu_op = ALUOp;
assign alu_in1 = reg1_out;
assign alu_in2 = ALUSrc ? {{12{mem_offset[3]}},  mem_offset} << 1 :
		 Shift ? mem_offset : reg2_out;

// Flag D-Flip-Flops
dff Z(.q(pc_flags[2]), .d(alu_flags[2]), .wen(flags_set), .clk(clk), .rst(~rst_n));
dff V(.q(pc_flags[1]), .d(alu_flags[1]), .wen(flags_set), .clk(clk), .rst(~rst_n));
dff N(.q(pc_flags[0]), .d(alu_flags[0]), .wen(flags_set), .clk(clk), .rst(~rst_n));

assign flags_set = ~opcode[3];

endmodule
