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
add wave -noupdate -divider {Instruction Cache}
add wave -noupdate /cpu_ptb/DUT/InstCache/all_data_is_written_to_cache
add wave -noupdate /cpu_ptb/DUT/InstCache/byte_offset
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_data_in
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_data_out
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_data_set
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_hit
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_hit_data_set
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_miss_data_set
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_word_block_num
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_write
add wave -noupdate /cpu_ptb/DUT/InstCache/data_is_valid_on_way_1
add wave -noupdate /cpu_ptb/DUT/InstCache/data_is_valid_on_way_2
add wave -noupdate /cpu_ptb/DUT/InstCache/data_is_valid_to_write_to_cache
add wave -noupdate /cpu_ptb/DUT/InstCache/decoder_1_set
add wave -noupdate /cpu_ptb/DUT/InstCache/decoder_2_set
add wave -noupdate /cpu_ptb/DUT/InstCache/mem_address
add wave -noupdate /cpu_ptb/DUT/InstCache/mem_data_valid
add wave -noupdate /cpu_ptb/DUT/InstCache/meta_data_1_block
add wave -noupdate /cpu_ptb/DUT/InstCache/meta_data_1_read
add wave -noupdate /cpu_ptb/DUT/InstCache/meta_data_1_write
add wave -noupdate /cpu_ptb/DUT/InstCache/meta_data_2_block
add wave -noupdate /cpu_ptb/DUT/InstCache/meta_data_2_read
add wave -noupdate /cpu_ptb/DUT/InstCache/meta_data_2_write
add wave -noupdate /cpu_ptb/DUT/InstCache/missed_mem_address
add wave -noupdate /cpu_ptb/DUT/InstCache/missed_word_block
add wave -noupdate /cpu_ptb/DUT/InstCache/set
add wave -noupdate /cpu_ptb/DUT/InstCache/stall
add wave -noupdate /cpu_ptb/DUT/InstCache/tag
add wave -noupdate /cpu_ptb/DUT/InstCache/way_bit
add wave -noupdate /cpu_ptb/DUT/InstCache/way_to_write
add wave -noupdate /cpu_ptb/DUT/InstCache/word_number
add wave -noupdate /cpu_ptb/DUT/InstCache/way_1_was_lru
add wave -noupdate /cpu_ptb/DUT/InstCache/way_2_was_lru
add wave -noupdate /cpu_ptb/DUT/InstCache/lru_for_way_1
add wave -noupdate /cpu_ptb/DUT/InstCache/lru_for_way_2
add wave -noupdate /cpu_ptb/DUT/InstCache/update_lru_way_1
add wave -noupdate /cpu_ptb/DUT/InstCache/update_lru_way_2
add wave -noupdate -divider {Cache FSM}
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/clk
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/rst_n
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/miss_detected
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/chunk_count
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/chunk_inc
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/chunk_val
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/curr_state
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/fsm_busy
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/mem_count
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/mem_inc
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/mem_val
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/memory_address
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/memory_data
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/memory_data_valid
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/miss_address
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/next_state
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/write_data_array
add wave -noupdate /cpu_ptb/DUT/InstCache/cache_FSM/write_tag_array
add wave -noupdate /cpu_ptb/DUT/InstCache/update_blocks
add wave -noupdate /cpu_ptb/DUT/InstCache/written_blocks
add wave -noupdate /cpu_ptb/DUT/InstCache/way_1_was_written_before
add wave -noupdate /cpu_ptb/DUT/InstCache/way_2_was_written_before
add wave -noupdate -divider {PC Branch Counter}
add wave -noupdate /cpu_ptb/DUT/PC/C
add wave -noupdate /cpu_ptb/DUT/PC/F
add wave -noupdate /cpu_ptb/DUT/PC/I
add wave -noupdate /cpu_ptb/DUT/PC/I_shift
add wave -noupdate /cpu_ptb/DUT/PC/PC_in
add wave -noupdate /cpu_ptb/DUT/PC/PC_out
add wave -noupdate /cpu_ptb/DUT/PC/brach_reg_out
add wave -noupdate /cpu_ptb/DUT/PC/branch_out
add wave -noupdate /cpu_ptb/DUT/PC/branch_taken
add wave -noupdate /cpu_ptb/DUT/branch_stall
add wave -noupdate /cpu_ptb/DUT/PC/data_in
add wave -noupdate /cpu_ptb/DUT/PC/imm
add wave -noupdate /cpu_ptb/DUT/PC/opcode
add wave -noupdate /cpu_ptb/DUT/PC/pc_next
add wave -noupdate /cpu_ptb/DUT/PC/target
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
add wave -noupdate /cpu_ptb/DUT/missed_data_mem
add wave -noupdate /cpu_ptb/DUT/data_out
add wave -noupdate /cpu_ptb/DUT/data_in
add wave -noupdate /cpu_ptb/DUT/MEM_ReadData2
add wave -noupdate /cpu_ptb/DUT/MEM_DstReg
add wave -noupdate /cpu_ptb/DUT/MEM_MemWrite
add wave -noupdate /cpu_ptb/DUT/MEM_MemRead
add wave -noupdate /cpu_ptb/DUT/MEM_MemtoReg
add wave -noupdate /cpu_ptb/DUT/data_w
add wave -noupdate /cpu_ptb/DUT/MEM_RegWrite
add wave -noupdate /cpu_ptb/DUT/data_en
add wave -noupdate /cpu_ptb/DUT/data_addr
add wave -noupdate /cpu_ptb/DUT/MEM_ALUval
add wave -noupdate /cpu_ptb/DUT/mem_data
add wave -noupdate -divider {Data Cache}
add wave -noupdate /cpu_ptb/DUT/DataCache/clk
add wave -noupdate /cpu_ptb/DUT/DataCache/rst_n
add wave -noupdate /cpu_ptb/DUT/DataCache/all_data_is_written_to_cache
add wave -noupdate /cpu_ptb/DUT/DataCache/byte_offset
add wave -noupdate /cpu_ptb/DUT/DataCache/user_data_in
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_data_in
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_data_to_write
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_data_out
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_data_set
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_hit
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_hit_data_set
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_miss_data_set
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_word_block_num
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_write
add wave -noupdate /cpu_ptb/DUT/DataCache/data_is_valid_on_way_1
add wave -noupdate /cpu_ptb/DUT/DataCache/data_is_valid_on_way_2
add wave -noupdate /cpu_ptb/DUT/DataCache/data_is_valid_to_write_to_cache
add wave -noupdate /cpu_ptb/DUT/DataCache/decoder_1_set
add wave -noupdate /cpu_ptb/DUT/DataCache/decoder_2_set
add wave -noupdate /cpu_ptb/DUT/DataCache/mem_address
add wave -noupdate /cpu_ptb/DUT/DataCache/mem_data_valid
add wave -noupdate /cpu_ptb/DUT/DataCache/meta_data_1_block
add wave -noupdate /cpu_ptb/DUT/DataCache/meta_data_2_block
add wave -noupdate /cpu_ptb/DUT/DataCache/meta_data_1_read
add wave -noupdate /cpu_ptb/DUT/DataCache/meta_data_2_read
add wave -noupdate /cpu_ptb/DUT/DataCache/meta_data_1_write
add wave -noupdate /cpu_ptb/DUT/DataCache/meta_data_2_write
add wave -noupdate /cpu_ptb/DUT/DataCache/missed_mem_address
add wave -noupdate /cpu_ptb/DUT/DataCache/missed_word_block
add wave -noupdate /cpu_ptb/DUT/DataCache/missed_word_block_1
add wave -noupdate /cpu_ptb/DUT/DataCache/missed_word_block_2
add wave -noupdate /cpu_ptb/DUT/DataCache/missed_word_block_3
add wave -noupdate /cpu_ptb/DUT/DataCache/missed_word_block_4
add wave -noupdate /cpu_ptb/DUT/DataCache/set
add wave -noupdate /cpu_ptb/DUT/DataCache/stall
add wave -noupdate /cpu_ptb/DUT/DataCache/tag
add wave -noupdate /cpu_ptb/DUT/DataCache/update_blocks
add wave -noupdate /cpu_ptb/DUT/DataCache/user_data_in
add wave -noupdate /cpu_ptb/DUT/DataCache/way_1_was_written_before
add wave -noupdate /cpu_ptb/DUT/DataCache/way_2_was_written_before
add wave -noupdate /cpu_ptb/DUT/DataCache/way_bit
add wave -noupdate /cpu_ptb/DUT/DataCache/way_to_write
add wave -noupdate /cpu_ptb/DUT/DataCache/word_number
add wave -noupdate /cpu_ptb/DUT/DataCache/written_blocks
add wave -noupdate /cpu_ptb/DUT/DataCache/update_lru_way_1
add wave -noupdate /cpu_ptb/DUT/DataCache/update_lru_way_2
add wave -noupdate /cpu_ptb/DUT/DataCache/lru_for_way_1
add wave -noupdate /cpu_ptb/DUT/DataCache/lru_for_way_2
add wave -noupdate /cpu_ptb/DUT/DataCache/way_1_was_lru
add wave -noupdate /cpu_ptb/DUT/DataCache/way_2_was_lru
add wave -noupdate -divider {Data Cache FSM}
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/clk
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/rst_n
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/chunk_count
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/chunk_inc
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/chunk_val
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/curr_state
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/next_state
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/delayed_next_state
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/fsm_busy
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/mem_count
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/mem_inc
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/mem_val
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/memory_address
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/memory_data
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/memory_data_valid
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/miss_address
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/miss_detected
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/stop_mem_count
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/write_data_array
add wave -noupdate /cpu_ptb/DUT/DataCache/cache_FSM/write_tag_array
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
add wave -noupdate /cpu_ptb/DUT/hazard_stall
add wave -noupdate /cpu_ptb/DUT/stall
add wave -noupdate -divider {Block Data}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/clk}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/rst}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/Din}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/WriteEnable}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/Enable}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/WordEnable}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/Dout}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[0]/WordEnable_real}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/clk}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/rst}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/Din}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/WriteEnable}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/Enable}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/WordEnable}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/Dout}
add wave -noupdate {/cpu_ptb/DUT/InstCache/cache_data/blk[2]/WordEnable_real}
add wave -noupdate -divider {Metadata Array}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_1/Mblk[30]/Din}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_1/Mblk[30]/Dout}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_1/Mblk[30]/Enable}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_1/Mblk[30]/WriteEnable}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_1/Mblk[30]/clk}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_1/Mblk[30]/rst}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_2/Mblk[31]/Din}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_2/Mblk[31]/Dout}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_2/Mblk[31]/Enable}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_2/Mblk[31]/WriteEnable}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_2/Mblk[31]/clk}
add wave -noupdate {/cpu_ptb/DUT/DataCache/cache_meta_data_2/Mblk[31]/rst}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23732 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
configure wave -valuecolwidth 289
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
WaveRestoreZoom {23133 ns} {24331 ns}
