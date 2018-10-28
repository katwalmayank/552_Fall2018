onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider IF
add wave -noupdate /cpu_tb/DUT/clk
add wave -noupdate /cpu_tb/DUT/pc
add wave -noupdate /cpu_tb/DUT/rst_n
add wave -noupdate /cpu_tb/DUT/hlt
add wave -noupdate /cpu_tb/DUT/inst_addr
add wave -noupdate /cpu_tb/DUT/IF_pc
add wave -noupdate /cpu_tb/DUT/pc_inc_out
add wave -noupdate /cpu_tb/DUT/IF_inst
add wave -noupdate -divider ID
add wave -noupdate /cpu_tb/DUT/ID_pc
add wave -noupdate /cpu_tb/DUT/ID_pc_inc_out
add wave -noupdate /cpu_tb/DUT/ID_inst
add wave -noupdate /cpu_tb/DUT/branch_control
add wave -noupdate /cpu_tb/DUT/reg_w
add wave -noupdate /cpu_tb/DUT/MemtoReg
add wave -noupdate /cpu_tb/DUT/opcode
add wave -noupdate /cpu_tb/DUT/rt
add wave -noupdate /cpu_tb/DUT/rs
add wave -noupdate /cpu_tb/DUT/rd
add wave -noupdate /cpu_tb/DUT/imm
add wave -noupdate /cpu_tb/DUT/branch_imm
add wave -noupdate /cpu_tb/DUT/reg1
add wave -noupdate /cpu_tb/DUT/reg2
add wave -noupdate /cpu_tb/DUT/mem_offset
add wave -noupdate /cpu_tb/DUT/ALUOp
add wave -noupdate /cpu_tb/DUT/alu_in1
add wave -noupdate /cpu_tb/DUT/alu_out
add wave -noupdate /cpu_tb/DUT/MemWrite
add wave -noupdate /cpu_tb/DUT/ALUSrc
add wave -noupdate /cpu_tb/DUT/RegWrite
add wave -noupdate /cpu_tb/DUT/Mem
add wave -noupdate /cpu_tb/DUT/Modify
add wave -noupdate /cpu_tb/DUT/pcs
add wave -noupdate /cpu_tb/DUT/data_w
add wave -noupdate /cpu_tb/DUT/Shift
add wave -noupdate /cpu_tb/DUT/pc_in
add wave -noupdate -divider EX
add wave -noupdate /cpu_tb/DUT/EX_pc_inc_out
add wave -noupdate /cpu_tb/DUT/EX_Imm
add wave -noupdate /cpu_tb/DUT/reg1_out
add wave -noupdate /cpu_tb/DUT/EX_ReadData1
add wave -noupdate /cpu_tb/DUT/reg2_out
add wave -noupdate /cpu_tb/DUT/EX_ReadData2
add wave -noupdate /cpu_tb/DUT/EX_MemtoReg
add wave -noupdate /cpu_tb/DUT/EX_MemWrite
add wave -noupdate /cpu_tb/DUT/EX_ALUval
add wave -noupdate /cpu_tb/DUT/EX_MemOffset
add wave -noupdate /cpu_tb/DUT/EX_opcode
add wave -noupdate /cpu_tb/DUT/EX_Rt
add wave -noupdate /cpu_tb/DUT/EX_Rd
add wave -noupdate /cpu_tb/DUT/EX_DstReg
add wave -noupdate /cpu_tb/DUT/EX_ALUOp
add wave -noupdate /cpu_tb/DUT/alu_op
add wave -noupdate /cpu_tb/DUT/EX_ALUSrc
add wave -noupdate /cpu_tb/DUT/EX_RegWrite
add wave -noupdate /cpu_tb/DUT/EX_Mem
add wave -noupdate /cpu_tb/DUT/EX_Modify
add wave -noupdate /cpu_tb/DUT/EX_Shift
add wave -noupdate /cpu_tb/DUT/EX_PCS
add wave -noupdate /cpu_tb/DUT/flags_set
add wave -noupdate /cpu_tb/DUT/alu_in2
add wave -noupdate /cpu_tb/DUT/alu_flags
add wave -noupdate /cpu_tb/DUT/pc_flags
add wave -noupdate -divider MEM
add wave -noupdate /cpu_tb/DUT/data_addr
add wave -noupdate /cpu_tb/DUT/MEM_ALUval
add wave -noupdate /cpu_tb/DUT/data_out
add wave -noupdate /cpu_tb/DUT/data_in
add wave -noupdate /cpu_tb/DUT/MEM_ReadData2
add wave -noupdate /cpu_tb/DUT/MEM_DstReg
add wave -noupdate /cpu_tb/DUT/MEM_MemWrite
add wave -noupdate /cpu_tb/DUT/MEM_MemRead
add wave -noupdate /cpu_tb/DUT/MEM_MemtoReg
add wave -noupdate /cpu_tb/DUT/MEM_RegWrite
add wave -noupdate -divider WB
add wave -noupdate /cpu_tb/DUT/WB_MemtoReg
add wave -noupdate /cpu_tb/DUT/WB_RegWrite
add wave -noupdate /cpu_tb/DUT/dst_reg
add wave -noupdate /cpu_tb/DUT/WB_DstReg
add wave -noupdate /cpu_tb/DUT/WB_ALUval
add wave -noupdate /cpu_tb/DUT/dst_data
add wave -noupdate /cpu_tb/DUT/WB_DstData
add wave -noupdate /cpu_tb/DUT/WB_ReadData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {450 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {1 us}
