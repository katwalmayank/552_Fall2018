module cpu(clk, rst_n, hlt, pc);

input clk;
input rst_n; 
output hlt;
output [15:0] pc;

wire [15:0] ID_inst, pc_in, IF_pc, alu_out, alu_in1, alu_in2, inst_addr, data_addr, data_out, data_in, pc_inc_out, reg1_out, reg2_out, dst_data, IF_inst,
 ID_pc, EX_ReadData1, EX_ReadData2, MEM_ReadData2, MEM_ALUval, WB_DstData,ID_pc_inc_out, EX_pc_inc_out, EX_ALUval, WB_ALUval, WB_ReadData;
wire [3:0] opcode, rt, rs, rd, mem_offset, reg1, reg2, dst_reg, EX_MemOffset, WB_DstReg, EX_opcode, EX_Rt, EX_Rd, EX_DstReg, MEM_DstReg, EX_Rs, MEM_Rt;
wire [2:0] alu_op, ALUOp, alu_flags, pc_flags, branch_control, EX_ALUOp;
wire reg_w, MemtoReg, MemWrite, ALUSrc, RegWrite, Mem, Modify, pcs, data_w, Shift, EX_MemtoReg, EX_MemWrite, EX_ALUSrc, EX_RegWrite, EX_Mem, EX_Modify, EX_Shift,
MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, MEM_RegWrite, WB_RegWrite;
wire [8:0] branch_imm;
wire [7:0] imm, EX_Imm;


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
//	OPCODE FOR Branch	   B or BR addr        Condition to check  Branch Imm Val  Flags set	 PC val         Final PC val
PC_control PC(.opcode(opcode), .data_in(reg1_out), .C(branch_control), .I(branch_imm), .F(pc_flags), .PC_in(pc_in), .PC_out(IF_pc));

//TODO: DO WE NEED TO CHANGE hlt LOGIC??
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
dff_16bit pc_dff(.q(pc_in), .d(IF_pc), .wen(~hlt), .clk(clk), .rst(~rst_n));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Instruction Memory
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//               Instruction to execute   datain          Address of the ID_inst			
memory1c InstMem(.data_out(IF_inst), .data_in(16'bx), .addr(inst_addr), .enable(1'b1), .wr(1'b0), .clk(clk), .rst(~rst_n));
assign inst_addr = pc_in;

// IF/ID Pipeline Register   //TODO: We don't want to have the write enable to be always set
IF_ID IF_ID(
	.clk(clk),
	.rst_n(rst_n),
	.IF_inst(IF_inst),
	.IF_PC(IF_pc),
	.IF_PC_INC_OUT(pc_inc_out),
	.ID_inst(ID_inst),
	.ID_PC(ID_pc),
	.ID_PC_INC_OUT(ID_pc_inc_out), 
	.wen(1'b1)
);

assign opcode = ID_inst[15:12];
assign rd = ID_inst[11:8];
assign rs = ID_inst[7:4];
assign rt = (Mem) ? ID_inst[11:8] : ID_inst[3:0];
assign mem_offset = ID_inst[3:0];
assign imm = ID_inst[7:0];
assign branch_control = ID_inst[11:9];
assign branch_imm = ID_inst[8:0];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Control Unit
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Control Contr(.Opcode(opcode), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite),
		.ALUSrc(ALUSrc), .RegWrite(RegWrite), .Mem(Mem), .Modify(Modify), .Shift(Shift));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Registers File System
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

RegisterFile Registers(.clk(clk), .rst(~rst_n), .SrcReg1(reg1), .SrcReg2(reg2), .DstReg(dst_reg), .WriteReg(reg_w), .DstData(dst_data), .SrcData1(reg1_out), .SrcData2(reg2_out));

assign reg1 = rs;
assign reg2 = (Modify) ? rd : rt;
assign dst_reg = WB_DstReg;
assign dst_data = WB_DstData;
assign reg_w = WB_RegWrite;

// ID/EX Pipeline Register   //TODO: We don't want to have the write enable to be always set
ID_EX ID_EX(
	.clk(clk), 
	.rst_n(rst_n), 
	.wen(1'b1),
	.ID_ALUOp(ALUOp),
	.ID_MemtoReg(MemtoReg), 
	.ID_MemWrite(MemWrite), 
	.ID_ALUSrc(ALUSrc), 
	.ID_RegWrite(RegWrite), 
	.ID_Mem(Mem), 
	.ID_Modify(Modify), 
	.ID_Shift(Shift),
	.ID_ReadData1(reg1_out),
	.ID_ReadData2(reg2_out),
	.ID_MemOffset(mem_offset),
	.ID_PCS(pcs),
	.ID_Rs(rs),
	.ID_Rt(rt),
	.ID_Rd(rd),
	.ID_Imm(imm),
	.ID_PC_INC_OUT(ID_pc_inc_out),
	.ID_opcode(opcode),
	.EX_ALUOp(EX_ALUOp),
	.EX_MemtoReg(EX_MemtoReg),
	.EX_MemWrite(EX_MemWrite),
	.EX_ALUSrc(EX_ALUSrc),
	.EX_RegWrite(EX_RegWrite),
	.EX_Mem(EX_Mem),
	.EX_Modify(EX_Modify),
	.EX_Shift(EX_Shift),
	.EX_ReadData1(EX_ReadData1),
	.EX_ReadData2(EX_ReadData2),
	.EX_MemOffset(EX_MemOffset),
	.EX_PCS(EX_PCS),
	.EX_Rs(EX_Rs),
	.EX_Rt(EX_Rt),
	.EX_Rd(EX_Rd),
	.EX_Imm(EX_Imm),
	.EX_PC_INC_OUT(EX_pc_inc_out),
	.EX_opcode(EX_opcode)
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												ALU
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ALU Alu(.ALU_Out(alu_out), .Error(), .ALU_In1(alu_in1), .ALU_In2(alu_in2), .Opcode(alu_op), .Flags(alu_flags));

assign alu_op = EX_ALUOp;
assign alu_in1 = EX_ReadData1;
assign alu_in2 = EX_ALUSrc ? {{12{EX_MemOffset[3]}},  EX_MemOffset} << 1 :
		 EX_Shift ? EX_MemOffset : EX_ReadData2;

// Flag D-Flip-Flops
dff Z(.q(pc_flags[2]), .d(alu_flags[2]), .wen(flags_set), .clk(clk), .rst(~rst_n));
dff V(.q(pc_flags[1]), .d(alu_flags[1]), .wen(flags_set), .clk(clk), .rst(~rst_n));
dff N(.q(pc_flags[0]), .d(alu_flags[0]), .wen(flags_set), .clk(clk), .rst(~rst_n));

assign flags_set = ~EX_opcode[3];

assign EX_DstReg = (EX_Mem) ? EX_Rt : EX_Rd;

//TODO: HOOK UP THE VALUE WE CHOOSE INSTEAD OF THE READ FROM DATA MEMORY
assign EX_ALUval = (EX_PCS) ? EX_pc_inc_out :
		  (~EX_Modify) ? EX_ALUOp :
		  (EX_opcode == 4'b1010) ? ((EX_ReadData2 & 16'hFF00) | {8'b0, EX_Imm}) : 
		  ((EX_ReadData2 & 16'h00FF) | {EX_Imm, 8'b0});

// EX/MEM Pipeline Register   //TODO: We don't want to have the write enable to be always set
EX_MEM EX_MEM(
	.EX_MemWrite(EX_MemWrite), 
	.EX_MemRead(1'b0),
	.EX_MemtoReg(EX_MemtoReg),
	.EX_RegWrite(EX_RegWrite),
	.EX_ALUval(EX_ALUval),
	.EX_ReadData2(EX_ReadData2),
	.EX_Rt(EX_Rt),
	.EX_DstReg(EX_DstReg),
	.rst_n(rst_n),
	.write_en(1'b1), 
	.clk(clk),
	.MEM_MemWrite(MEM_MemWrite), 
	.MEM_MemRead(MEM_MemRead), 
	.MEM_MemtoReg(MEM_MemtoReg), 
	.MEM_RegWrite(MEM_RegWrite), 
	.MEM_ALUval(MEM_ALUval),
	.MEM_ReadData2(MEM_ReadData2),
	.MEM_Rt(MEM_Rt),
	.MEM_DstReg(MEM_DstReg)
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Data Memory
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

memory1c DataMem(.data_out(data_out), .data_in(data_in), .addr(data_addr), .enable(1'b1), .wr(data_w), .clk(clk), .rst(~rst_n)); 

assign data_addr = MEM_ALUval;
assign data_in = MEM_ReadData2;
assign data_w = MEM_MemWrite;

// MEM_WB Pipeline Register   //TODO: We don't want to have the write enable to be always set
MEM_WB MEM_WB(
	.clk(clk),
	.rst_n(rst_n),
	.MEM_ALUval(MEM_ALUval),
	.MEM_RegWrite(MEM_RegWrite), 
	.MEM_DstReg(MEM_DstReg),
	.MEM_ReadData(data_out), 
	.MEM_MemtoReg(MEM_MemtoReg),
	.WB_ALUval(WB_ALUval),
	.WB_RegWrite(WB_RegWrite),	
	.WB_DstReg(WB_DstReg),
	.WB_ReadData(WB_ReadData), 
	.WB_MemtoReg(WB_MemtoReg),
	.wen(1'b1)
);

assign WB_DstData = (WB_MemtoReg) ? WB_ReadData : WB_ALUval;

// Forwarding Module
Forwarding F_module(
	.ID_EX_RegRs(EX_Rs),
	.ID_EX_RegRt(EX_Rt),
	.EX_MEM_RegWrite(MEM_RegWrite),
	.EX_MEM_RegRd(MEM_DstReg),
	.EX_MEM_MemWrite(MEM_RegWrite),
	.EX_MEM_RegRt(MEM_Rt), //TODO: FILL IN EMPTY CONNECTIONS
	.MEM_WB_RegWrite(WB_RegWrite), 
	.MEM_WB_RegRd(WB_DstReg),
	.Forward_A(),
	.Forward_B()
);

endmodule
