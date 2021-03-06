onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider IF
add wave -noupdate /cpu_ptb/DUT/clk
add wave -noupdate /cpu_ptb/DUT/pc
add wave -noupdate /cpu_ptb/DUT/rst_n
add wave -noupdate /cpu_ptb/DUT/hlt
add wave -noupdate /cpu_ptb/DUT/inst_addr
add wave -noupdate /cpu_ptb/DUT/pc_in
add wave -noupdate /cpu_ptb/DUT/IF_pc
add wave -noupdate /cpu_ptb/DUT/IF_inst
add wave -noupdate -divider ID
add wave -noupdate /cpu_ptb/DUT/ID_halt
add wave -noupdate /cpu_ptb/DUT/ID_pc
add wave -noupdate /cpu_ptb/DUT/ID_pc_inc_out
add wave -noupdate /cpu_ptb/DUT/ID_inst
add wave -noupdate /cpu_ptb/DUT/branch_taken
add wave -noupdate /cpu_ptb/DUT/branch_control
add wave -noupdate /cpu_ptb/DUT/reg_w
add wave -noupdate /cpu_ptb/DUT/MemtoReg
add wave -noupdate /cpu_ptb/DUT/opcode
add wave -noupdate /cpu_ptb/DUT/rt
add wave -noupdate /cpu_ptb/DUT/rs
add wave -noupdate /cpu_ptb/DUT/rd
add wave -noupdate /cpu_ptb/DUT/imm
add wave -noupdate /cpu_ptb/DUT/branch_imm
add wave -noupdate /cpu_ptb/DUT/reg1
add wave -noupdate /cpu_ptb/DUT/reg2
add wave -noupdate /cpu_ptb/DUT/mem_offset
add wave -noupdate /cpu_ptb/DUT/ALUOp
add wave -noupdate /cpu_ptb/DUT/alu_in1
add wave -noupdate /cpu_ptb/DUT/alu_out
add wave -noupdate /cpu_ptb/DUT/MemWrite
add wave -noupdate /cpu_ptb/DUT/ALUSrc
add wave -noupdate /cpu_ptb/DUT/RegWrite
add wave -noupdate /cpu_ptb/DUT/Mem
add wave -noupdate /cpu_ptb/DUT/Modify
add wave -noupdate /cpu_ptb/DUT/pcs
add wave -noupdate /cpu_ptb/DUT/data_w
add wave -noupdate /cpu_ptb/DUT/Shift
add wave -noupdate -divider EX
add wave -noupdate /cpu_ptb/DUT/EX_pc_inc_out
add wave -noupdate /cpu_ptb/DUT/EX_Imm
add wave -noupdate /cpu_ptb/DUT/reg1_out
add wave -noupdate /cpu_ptb/DUT/EX_ReadData1
add wave -noupdate /cpu_ptb/DUT/reg2_out
add wave -noupdate /cpu_ptb/DUT/EX_ReadData2
add wave -noupdate /cpu_ptb/DUT/EX_Operand1
add wave -noupdate /cpu_ptb/DUT/EX_Operand2
add wave -noupdate /cpu_ptb/DUT/EX_MemtoReg
add wave -noupdate /cpu_ptb/DUT/EX_MemWrite
add wave -noupdate /cpu_ptb/DUT/EX_ALUval
add wave -noupdate /cpu_ptb/DUT/EX_MemOffset
add wave -noupdate /cpu_ptb/DUT/EX_opcode
add wave -noupdate /cpu_ptb/DUT/EX_Rt
add wave -noupdate /cpu_ptb/DUT/EX_Rd
add wave -noupdate /cpu_ptb/DUT/EX_DstReg
add wave -noupdate /cpu_ptb/DUT/EX_ALUOp
add wave -noupdate /cpu_ptb/DUT/alu_op
add wave -noupdate /cpu_ptb/DUT/EX_ALUSrc
add wave -noupdate /cpu_ptb/DUT/EX_RegWrite
add wave -noupdate /cpu_ptb/DUT/EX_Mem
add wave -noupdate /cpu_ptb/DUT/EX_Modify
add wave -noupdate /cpu_ptb/DUT/EX_Shift
add wave -noupdate /cpu_ptb/DUT/EX_PCS
add wave -noupdate /cpu_ptb/DUT/flags_set
add wave -noupdate /cpu_ptb/DUT/alu_in2
add wave -noupdate /cpu_ptb/DUT/alu_flags
add wave -noupdate /cpu_ptb/DUT/pc_flags
add wave -noupdate -divider MEM
add wave -noupdate /cpu_ptb/DUT/data_addr
add wave -noupdate /cpu_ptb/DUT/MEM_ALUval
add wave -noupdate /cpu_ptb/DUT/data_out
add wave -noupdate /cpu_ptb/DUT/data_in
add wave -noupdate /cpu_ptb/DUT/MEM_ReadData2
add wave -noupdate /cpu_ptb/DUT/MEM_DstReg
add wave -noupdate /cpu_ptb/DUT/MEM_MemWrite
add wave -noupdate /cpu_ptb/DUT/MEM_MemRead
add wave -noupdate /cpu_ptb/DUT/MEM_MemtoReg
add wave -noupdate /cpu_ptb/DUT/MEM_RegWrite
add wave -noupdate -divider WB
add wave -noupdate /cpu_ptb/DUT/WB_halt
add wave -noupdate /cpu_ptb/DUT/WB_MemtoReg
add wave -noupdate /cpu_ptb/DUT/WB_RegWrite
add wave -noupdate /cpu_ptb/DUT/dst_reg
add wave -noupdate /cpu_ptb/DUT/WB_DstReg
add wave -noupdate /cpu_ptb/DUT/WB_ALUval
add wave -noupdate /cpu_ptb/DUT/dst_data
add wave -noupdate /cpu_ptb/DUT/WB_DstData
add wave -noupdate /cpu_ptb/DUT/WB_ReadData
add wave -noupdate -divider FORWARDING
add wave -noupdate /cpu_ptb/DUT/forwarding_Unit/Forward_A
add wave -noupdate /cpu_ptb/DUT/forwarding_Unit/Forward_B
add wave -noupdate /cpu_ptb/DUT/forwarding_Unit/EX_forward_A
add wave -noupdate /cpu_ptb/DUT/forwarding_Unit/EX_forward_B
add wave -noupdate /cpu_ptb/DUT/forwarding_Unit/MEM_EX_forward_A
add wave -noupdate /cpu_ptb/DUT/forwarding_Unit/MEM_EX_forward_B
add wave -noupdate /cpu_ptb/DUT/forwarding_Unit/MEM_MEM_forward_B
add wave -noupdate -divider HAZARD
add wave -noupdate /cpu_ptb/DUT/stall
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {583 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1413 ns}
