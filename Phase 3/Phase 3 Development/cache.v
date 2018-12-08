module cache(clk, rst_n, cache_write, mem_address, cache_data_out, cache_data_in, stall, mem_data_valid, missed_mem_address, user_data_in, mem_instruction);

input clk, rst_n, cache_write, mem_data_valid, mem_instruction;
input [15:0] mem_address, cache_data_in, user_data_in;

output stall; // TODO Let FSM handle the stall?
output [15:0] cache_data_out, missed_mem_address; // data that cache has stored in both misses and hits, mem address to read data from

wire way_bit, data_is_valid_on_way_1, data_is_valid_on_way_2, data_is_valid_to_write_to_cache, all_data_is_written_to_cache, cache_hit, way_to_write,
	 way_1_was_written_before, way_2_was_written_before;
wire [2:0] byte_offset;
wire [5:0] set;
wire [6:0] decoder_1_set, decoder_2_set;
wire [5:0] tag;
wire [7:0] meta_data_1_read, meta_data_2_read, meta_data_1_write, meta_data_2_write, missed_word_block, 
		   missed_word_block_4, missed_word_block_3, missed_word_block_2, missed_word_block_1;

wire [7:0] word_number, cache_word_block_num;

wire [15:0] cache_data_to_write;
wire [127:0] cache_data_set, meta_data_1_block, meta_data_2_block, cache_miss_data_set, cache_hit_data_set, written_blocks, update_blocks;

DataArray cache_data(.clk(clk), 
					 .rst(~rst_n), 
					 .DataIn(cache_data_to_write), // Data to write to cache
					 .Write(data_is_valid_to_write_to_cache | cache_write), // We write 2 byte for 8 times coming from FSM
					 .BlockEnable(cache_data_set), // Which block number we are reading
					 .WordEnable(cache_word_block_num), // which word in the block we are reading
					 .DataOut(cache_data_out) // data read from the cache
);

MetaDataArray cache_meta_data_1(.clk(clk), 
							  .rst(~rst_n), 
							  .DataIn(meta_data_1_write), 
							  .Write(all_data_is_written_to_cache | cache_write & stall), //| cache_hit), // we only write to meta data after cache data is written
							  .BlockEnable(meta_data_1_block), // the blocks meta data
							  .DataOut(meta_data_1_read) // meta data read from the block
);

MetaDataArray cache_meta_data_2(.clk(clk), 
							  .rst(~rst_n), 
							  .DataIn(meta_data_2_write | cache_write & stall), 
							  .Write(all_data_is_written_to_cache), // | cache_hit), 
							  .BlockEnable(meta_data_2_block), 
							  .DataOut(meta_data_2_read)
);

cache_fill_FSM cache_FSM(.clk(clk), 
						 .rst_n(rst_n), 
						 .miss_detected(~cache_hit & rst_n & mem_instruction), // if cache misses then we start getting data from memory
						 .miss_address(mem_address), // address that missed the cache
						 .fsm_busy(stall), // stall signal coming from the FSM for the whole CPU
						 .write_data_array(data_is_valid_to_write_to_cache), // indicates if the data is valid to write to the cache
						 .write_tag_array(all_data_is_written_to_cache), // all the data is written to the cache
						 .memory_address(missed_mem_address), // mem address to read to get the data from the memory
						 .memory_data(), 
						 .memory_data_valid(mem_data_valid) // coming from the memory
);

cache_access_decoder cache_decoder_1(.byteoffset(byte_offset), 
								   .set(decoder_1_set), 
								   .blocknumber(meta_data_1_block), 
								   .wordnumber(word_number)
);

cache_access_decoder cache_decoder_2(.byteoffset(missed_mem_address[3:1]), 
								   .set(decoder_2_set), 
								   .blocknumber(meta_data_2_block), 
								   .wordnumber(missed_word_block_4) // unassigned because decoder 1 already gets the word number
);

//assign way_bit = ~{set[0]}; // which way in the set we want to read or write

// if set number is even then get meta data from left column else flip the bit to get data from left column
// accessing 2 adjacent columns
//assign decoder_1_set = (set[0]) ? {set[6:1],way_bit} : set; 
//assign decoder_2_set = (set[0]) ? set : {set[6:1],way_bit};

assign decoder_1_set = {set, 1'b0}; 
assign decoder_2_set = {set, 1'b1};

assign data_is_valid_on_way_1 = ((meta_data_1_read[5:0] == tag) & meta_data_1_read[7]) & way_1_was_written_before; // check if data we are reading is valid
assign data_is_valid_on_way_2 = ((meta_data_2_read[5:0] == tag) & meta_data_2_read[7]) & way_2_was_written_before;

assign cache_hit = (data_is_valid_on_way_1 | data_is_valid_on_way_2); // check if we have a cache hit

assign cache_miss_data_set = (way_to_write) ? meta_data_2_block : meta_data_1_block;

assign cache_hit_data_set = (data_is_valid_on_way_1) ? meta_data_1_block : meta_data_2_block;

assign cache_data_set = (cache_hit) ? cache_hit_data_set : cache_miss_data_set;

//assign missed_word_block_4 = {missed_mem_address[3:1]}; // block numbers to write to the cache in case of a miss

dff miss_mem_delay_4[7:0](.q(missed_word_block_3), .d(missed_word_block_4), .wen(1'b1), .clk(clk), .rst(~rst_n));
dff miss_mem_delay_3[7:0](.q(missed_word_block_2), .d(missed_word_block_3), .wen(1'b1), .clk(clk), .rst(~rst_n));
dff miss_mem_delay_2[7:0](.q(missed_word_block_1), .d(missed_word_block_2), .wen(1'b1), .clk(clk), .rst(~rst_n));
dff miss_mem_delay_1[7:0](.q(missed_word_block), .d(missed_word_block_1), .wen(1'b1), .clk(clk), .rst(~rst_n));

assign cache_word_block_num = (cache_hit) ? word_number : missed_word_block; // if cache is a hit then get that word number else write to the cache with word starting from 0 to 7

assign meta_data_1_write = (~way_1_was_written_before) ? {1'b1,1'b0,tag} :
						   data_is_valid_on_way_1 ? {meta_data_1_read[7], 1'b0, meta_data_1_read[5:0]} : // Meta data updates to write
						   data_is_valid_on_way_2 ? {meta_data_1_read[7], 1'b1, meta_data_1_read[5:0]} :
						   way_to_write ? {meta_data_1_read[7], 1'b1, meta_data_1_read[5:0]} : {1'b1,1'b0,tag} ; // MSB is the valid bit, the other one is the LRU bit if 0 means that we just used it if 1 means that its least recently used data

assign meta_data_2_write = (~way_2_was_written_before) ? 0 :
						   data_is_valid_on_way_1 ? {meta_data_2_read[7], 1'b1, meta_data_2_read[5:0]} :
						   data_is_valid_on_way_2 ? {meta_data_2_read[7], 1'b0, meta_data_2_read[5:0]} :
						   way_to_write ? {1'b1,1'b0,tag} : {meta_data_2_read[7], 1'b1, meta_data_2_read[5:0]};

// prioritize valid over the LRU						   
assign way_to_write = (~way_1_was_written_before) ? 0 :
					  (meta_data_1_read[7] & ~meta_data_2_read[7]) ? 1'b1 :
					  (~meta_data_1_read[7] & meta_data_1_read[7]) ? 0 :
					  (meta_data_1_read[6]) ? 0: 1'b1; // 0 = way_1 , 1 = way_2|| its the way to determine the LRU used block
					  
dff which_blocks_are_written[127:0](.q(written_blocks), .d(update_blocks), .wen(all_data_is_written_to_cache), .clk(clk), .rst(~rst_n));

assign way_1_was_written_before = (written_blocks & meta_data_1_block) != 0;

assign way_2_was_written_before = (written_blocks & meta_data_2_block) != 0;

assign update_blocks = (written_blocks | meta_data_1_block | meta_data_2_block);

assign byte_offset = {mem_address[3:1]};
assign set = {mem_address[9:4]};
assign tag = {mem_address[15:10]};

assign cache_data_to_write = (cache_write & (missed_word_block == word_number) | cache_hit) ? user_data_in : cache_data_in; // set cache write to zero at instruction memory



endmodule
