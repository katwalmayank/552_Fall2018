module cpu(clk, rst_n, hlt, pc);

input clk;
input rst_n; 
output hlt;
output [15:0] pc;

// Data to write back to register
wire [15:0] WB_DstData;

// PC Control Signals
wire ID_halt, EX_halt, MEM_halt, WB_halt, branch_taken;
wire [2:0] branch_control, pc_flags;
wire [3:0] opcode;
wire [8:0] branch_imm;
wire [15:0] pc_in;
		   
// Instruction Memory
wire [15:0] inst_addr;

// IF/ID Pipeline Signals
wire [15:0] IF_inst, IF_pc, IF_pc_inc_out, 
            ID_inst, ID_pc, ID_pc_inc_out;

// Control Unit Signals
wire MemtoReg, MemRead, MemWrite, ALUSrc, RegWrite, Mem, Modify, Shift;
wire [2:0] ALUOp;

// Register File System Signals
wire reg_w;
wire [3:0] reg1, reg2, dst_reg;
wire [15:0] reg1_out, reg2_out, dst_data;

// ID/EX Pipeline Signals
wire pcs, EX_MemtoReg, EX_MemRead, EX_MemWrite, EX_ALUSrc, EX_RegWrite, EX_Mem, EX_Modify, EX_Shift, EX_PCS;
wire [2:0] EX_ALUOp;
wire [3:0] mem_offset, rs, rt, rd, EX_MemOffset, EX_Rs, EX_Rt, EX_Rd, EX_opcode;
wire [7:0] imm, EX_Imm;
wire [15:0] EX_ReadData1, EX_ReadData2, EX_pc_inc_out;

// ALU Signals
wire [2:0] alu_op, alu_flags;
wire [15:0] alu_out, alu_in1, alu_in2;

// Flag Register Flip Flops
wire flags_set;

// EX/MEM Pipeline Signals
wire MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, MEM_RegWrite;
wire [3:0] EX_DstReg,
		   MEM_Rt, MEM_DstReg;
wire [15:0] EX_ALUval, EX_Operand1, EX_Operand2,
		    MEM_ALUval, MEM_ReadData2;

// Data Memory Signals
wire data_w, data_en;
wire [15:0] data_out, data_in, data_addr;
 
// MEM/WB Pipeline Signals
wire WB_RegWrite, WB_MemtoReg;
wire [3:0] WB_DstReg;
wire [15:0] WB_ALUval, WB_ReadData;

// Forwarding Unit Signals
wire [1:0] Forward_A, Forward_B;

// Hazard Unit Signals
wire stall, hazard_stall, branch_stall, flip;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												PC Control
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	          OPCODE FOR Branch	 B or BR addr       Condition to check  Branch Imm Val  Flags set	  PC val         Final PC val
PC_control PC(.opcode(stall ? 4'b0 : opcode), .data_in(reg1_out), .C(branch_control), .I(branch_imm), .F(pc_flags), .PC_in(pc_in), .PC_out(IF_pc), .branch_taken(branch_taken));

//TODO: DO WE NEED TO CHANGE hlt LOGIC??
assign hlt = WB_halt;
assign ID_halt = (opcode == 4'b1111);

// PC Incrementer for PCS
adder_16bit pc_inc(.sum(IF_pc_inc_out), .a(16'h0002), .b(pc_in));

// Report current pc value
assign pc = pc_in;
assign pcs = (opcode == 4'b1110);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												DFF to maintain pc value 
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		PC out        PC IN                 HALT 	        clk        rst_n
dff_16bit pc_dff(.q(pc_in), .d(IF_pc), .wen(~stall & ~(IF_inst[15:12] == 4'b1111 & ~branch_taken)), .clk(clk), .rst(~rst_n));

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Instruction Memory
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//               Instruc to execute   datain           Address of the ID_inst			
memory1c InstMem(.data_out(IF_inst), .data_in(16'bx), .addr(inst_addr), .enable(1'b1), .wr(1'b0), .clk(clk), .rst(~rst_n));

// The address of the instruction to get
assign inst_addr = pc_in;

// IF/ID Pipeline Register   //TODO: We don't want to have the write enable to be always set
IF_ID IF_ID(
	.clk(clk),
	.rst_n(rst_n),
	.IF_inst(branch_taken ? 16'b0 : IF_inst),
	.IF_PC(branch_taken ? 16'b0 : pc_in),
	.IF_PC_INC_OUT(branch_taken ? 16'b0 : IF_pc_inc_out),
	.ID_inst(ID_inst),
	.ID_PC(ID_pc),
	.ID_PC_INC_OUT(ID_pc_inc_out), 
	.wen(~stall & ~ID_halt)
);

// Opcode of instruction to execute
assign opcode = ID_inst[15:12];

// RD register number
assign rd = ID_inst[11:8];

// RS register number
assign rs = ID_inst[7:4];

// RT register number depending on mem or ALU operation 
assign rt = (Mem | Modify) ? ID_inst[11:8] : ID_inst[3:0];

// Offset for mem instruction
assign mem_offset = ID_inst[3:0];

// Immidiate value for mem instruction
assign imm = ID_inst[7:0];
assign branch_control = ID_inst[11:9];

// Immidiate for branch instruction
assign branch_imm = ID_inst[8:0];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Control Unit
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Control Control(.Opcode(opcode), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemRead(MemRead), .MemWrite(MemWrite),
		.ALUSrc(ALUSrc), .RegWrite(RegWrite), .Mem(Mem), .Modify(Modify), .Shift(Shift), .ID_Rd(rd));
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Registers File System
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

RegisterFile Registers(.clk(clk), .rst(~rst_n), .SrcReg1(reg1), .SrcReg2(reg2), .DstReg(dst_reg), 
					   .WriteReg(reg_w), .DstData(dst_data), .SrcData1(reg1_out), .SrcData2(reg2_out));

assign reg1 = rs;

// If instruction is LLB or LHB choose rd else rt
assign reg2 = (Modify) ? rd : rt;

// Register to write data_addr
assign dst_reg = WB_DstReg;

// Data to write
assign dst_data = WB_DstData;

// Was the operation a register write then write it
assign reg_w = WB_RegWrite;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												ID/EX Pipeline Register
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//TODO: We don't want to have the write enable to be always set
ID_EX ID_EX(
	.clk(clk), 
	.rst_n(rst_n), 
	.wen(1'b1),
	.ID_ALUOp(stall ? 3'b0 : ALUOp),
	.ID_MemtoReg(stall ? 1'b0 : MemtoReg), 
	.ID_MemRead(stall ? 1'b0 : MemRead),
	.ID_MemWrite(stall ? 1'b0 : MemWrite), 
	.ID_ALUSrc(stall ? 1'b0 : ALUSrc), 
	.ID_RegWrite(stall ? 1'b0 : RegWrite), 
	.ID_Mem(stall ? 1'b0 : Mem), 
	.ID_Modify(stall ? 1'b0 : Modify), 
	.ID_Shift(stall ? 1'b0 : Shift),
	.ID_ReadData1(stall ? 16'b0 : reg1_out),
	.ID_ReadData2(stall ? 16'b0 : reg2_out),
	.ID_MemOffset(stall ? 4'b0 : mem_offset),
	.ID_PCS(stall ? 1'b0 : pcs),
	.ID_Rs(stall ? 4'b0 : rs),
	.ID_Rt(stall ? 4'b0 : rt),
	.ID_Rd(stall ? 4'b0 : rd),
	.ID_Imm(stall ? 8'b0 : imm),
	.ID_PC_INC_OUT(stall ? 16'b0 : ID_pc_inc_out),
	.ID_opcode(stall ? 4'b0 : opcode),
	.ID_halt(stall ? 1'b0 : ID_halt),
	.EX_ALUOp(EX_ALUOp),
	.EX_MemtoReg(EX_MemtoReg),
	.EX_MemRead(EX_MemRead),
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
	.EX_opcode(EX_opcode),
	.EX_halt(EX_halt)
);

// Forwarding MUXes
assign EX_Operand1 = (Forward_A == 2'b10) ? MEM_ALUval  :	// EX TO EX
		     (Forward_A == 2'b01) ? WB_DstData  :	// MEM TO EX
					    EX_ReadData1;	// Normal
assign EX_Operand2 = (Forward_B == 2'b10) ? MEM_ALUval :	// EX TO EX
		     (Forward_B == 2'b01) ? WB_DstData :	// MEM TO EX
					    EX_ReadData2;	// Normal


// ALU OPcode from EX stage
assign alu_op = EX_ALUOp;
assign alu_in1 = EX_Operand1;

// Is the operation MEM operation then get immidiate extend and shift
// else if an SLL, SRA, ROR instruction then grab the shift ammount
// else an default ALU operation
assign alu_in2 = EX_ALUSrc ? {{12{EX_MemOffset[3]}},  EX_MemOffset} << 1 :
				 EX_Shift ? EX_MemOffset : EX_Operand2;
				 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												ALU
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ALU Alu(.ALU_Out(alu_out), .Error(), .ALU_In1(alu_in1), .ALU_In2(alu_in2), .Opcode(alu_op), .Flags(alu_flags));

// Signal to check if we are setting the flags
assign flags_set = ~EX_opcode[3];

// Flag D-Flip-Flops
dff Z(.q(pc_flags[2]), .d(alu_flags[2]), .wen(flags_set), .clk(clk), .rst(~rst_n));
dff V(.q(pc_flags[1]), .d(alu_flags[1]), .wen(flags_set), .clk(clk), .rst(~rst_n));
dff N(.q(pc_flags[0]), .d(alu_flags[0]), .wen(flags_set), .clk(clk), .rst(~rst_n));

// Choose destination register depending on memory or ALU operation
assign EX_DstReg = (EX_Mem) ? EX_Rt : EX_Rd;

//TODO: HOOK UP THE VALUE WE CHOOSE INSTEAD OF THE READ FROM DATA MEMORY
assign EX_ALUval = (EX_PCS) ? EX_pc_inc_out :
		  (~EX_Modify) ? alu_out :
		  (EX_opcode == 4'b1010) ? ((EX_Operand2 & 16'hFF00) | {8'b0, EX_Imm}) : 
		  ((EX_Operand2 & 16'h00FF) | {EX_Imm, 8'b0});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												EX/MEM Pipeline Register
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//TODO: We don't want to have the write enable to be always set
EX_MEM EX_MEM(
	.EX_MemWrite(EX_MemWrite), 
	.EX_MemRead(EX_MemRead),
	.EX_MemtoReg(EX_MemtoReg),
	.EX_RegWrite(EX_RegWrite),
	.EX_ALUval(EX_ALUval),
	.EX_ReadData2(EX_Operand2),
	.EX_Rt(EX_Rt),
	.EX_DstReg(EX_DstReg),
	.EX_halt(EX_halt),
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
	.MEM_DstReg(MEM_DstReg),
	.MEM_halt(MEM_halt)
);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Data Memory
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

memory1c DataMem(.data_out(data_out), .data_in(data_in), .addr(data_addr), .enable(data_en), .wr(data_w), .clk(clk), .rst(~rst_n)); 

assign data_en = MEM_MemRead | MEM_MemWrite;

// Mem address to write or read from
assign data_addr = MEM_ALUval;

// Data to write to memory
assign data_in = (Forward_B == 2'b11) ? WB_DstData : MEM_ReadData2;

// Is the operation memory write or read
assign data_w = MEM_MemWrite;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												MEM_WB Pipeline Register
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//TODO: We don't want to have the write enable to be always set
MEM_WB MEM_WB(
	.clk(clk),
	.rst_n(rst_n),
	.MEM_ALUval(MEM_ALUval),
	.MEM_RegWrite(MEM_RegWrite), 
	.MEM_DstReg(MEM_DstReg),
	.MEM_ReadData(data_out), 
	.MEM_MemtoReg(MEM_MemtoReg),
	.MEM_halt(MEM_halt),
	.WB_ALUval(WB_ALUval),
	.WB_RegWrite(WB_RegWrite),	
	.WB_DstReg(WB_DstReg),
	.WB_ReadData(WB_ReadData), 
	.WB_MemtoReg(WB_MemtoReg),
	.WB_halt(WB_halt), 
	.wen(1'b1)
);

// Data to write depending on weather the insturction is memory operation or ALU
assign WB_DstData = (WB_MemtoReg) ? WB_ReadData : WB_ALUval;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Forwarding module instantiation
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Forwarding forwarding_Unit(
	.MEM_RegWrite(MEM_RegWrite), 
	.MEM_RegRd(MEM_DstReg), 
	.EX_RegRs(EX_Rs), 
	.EX_RegRt(EX_Rt), 
	.WB_RegWrite(WB_RegWrite), 
	.WB_RegRd(WB_DstReg), 
	.MEM_MemWrite(MEM_MemWrite), 
	.MEM_RegRt(MEM_Rt),
	.Forward_A(Forward_A), 
	.Forward_B(Forward_B)
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// 												Hazard module instantiation
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Set stall if hazard unit detects a hazard, or we have a conditional branch
assign stall = hazard_stall | branch_stall;

// Set branch stall if we are not currently in a branch stall and want to execute a conditional branch
assign branch_stall = ~flip & (opcode == 4'b1100 | opcode == 4'b1101) & branch_control != 3'b111;

// This flip flop makes sure that the branch stall is only enabled for a single cycle
dff flip_dff(.q(flip), .d(branch_stall), .wen(1'b1), .clk(clk), .rst(~rst_n));

Hazard hazard(
	.stall(hazard_stall),
	.ID_RegRs(rs),
	.ID_RegRt(rt),
	.ID_MemWrite(MemWrite),
	.EX_RegRt(EX_Rt),
	.EX_MemRead(EX_MemRead)
);


endmodule