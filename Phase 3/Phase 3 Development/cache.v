module cache(clk, rst, cache_write, mem_address, cache_data_out, cache_data_in, stall, mem_data_valid, missed_mem_address);

input clk, rst, cache_write, mem_data_valid, cache_meta_data1_write, cache_meta_data2_write;
input [15:0] mem_address, cache_data_in;

output stall; // TODO Let FSM handle the stall?
output [15:0] cache_data_out, missed_mem_address; // data that cache has stored in both misses and hits, mem address to read data from

wire way_bit, data_is_valid_on_way_1, data_is_valid_on_way_2, data_is_valid_to_write_to_cache, all_data_is_written_to_cache, cache_hit, way_to_write;
wire [2:0] byte_offset, missed_word_block;
wire [6:0] set, decoder_1_set, decoder_2_set;
wire [5:0] tag;
wire [7:0] meta_data_1_read, meta_data_2_read, meta_data_1_write, meta_data_2_write;

wire [7:0] word_number;
wire [127:0] cache_data_set, meta_data_1_block, meta_data_2_block, cache_miss_data_set, cache_hit_data_set;

DataArray cache_data(.clk(clk), 
					 .rst(rst), 
					 .DataIn(cache_data_in), // Data to write to cache
					 .Write(data_is_valid_to_write_to_cache), // We write 2 byte for 8 times coming from FSM
					 .BlockEnable(cache_data_set), // Which block number we are reading
					 .WordEnable(cache_word_block_num), // which word in the block we are reading
					 .DataOut(cache_data_out) // data read from the cache
);

MetaDataArray cache_meta_data_1(.clk(clk), 
							  .rst(rst), 
							  .DataIn(meta_data_1_write), 
							  .Write(all_data_is_written_to_cache), // we only write to meta data after cache data is written
							  .BlockEnable(meta_data_1_block), // the blocks meta data
							  .DataOut(meta_data_1_read) // meta data read from the block
);

MetaDataArray cache_meta_data_2(.clk(clk), 
							  .rst(rst), 
							  .DataIn(meta_data_2_write), 
							  .Write(all_data_is_written_to_cache), 
							  .BlockEnable(meta_data_2_block), 
							  .DataOut(meta_data_2_read)
);

cache_fill_FSM cache_FSM(.clk(clk), 
						 .rst_n(rst), 
						 .miss_detected(~cache_hit), // if cache misses then we start getting data from memory
						 .miss_address(mem_address), // address that missed the cache
						 .fsm_busy(stall), // stall signal coming from the FSM for the whole CPU
						 .write_data_array(data_is_valid_to_write_to_cache), // indicates if the data is valid to write to the cache
						 .write_tag_array(all_data_is_written_to_cache), // all the data is written to the cache
						 .memory_address(missed_mem_address), // mem address to read to get the data from the memory
						 .memory_data(), 
						 .memory_data_valid(mem_data_valid) // coming from the memory
);

cache_access_decoder cache_decoder_1(.byte_offset(byte_offset), 
								   .set(decoder_1_set), 
								   .block_number(meta_data_1_block), 
								   .word_number(word_number)
);

cache_access_decoder cache_decoder_2(.byte_offset(byte_offset), 
								   .set(decoder_2_set), 
								   .block_number(meta_data_2_block), 
								   .word_number() // unassigned because decoder 1 already gets the word number
);

assign way_bit = ~{set[0]}; // which way in the set we want to read or write

assign decoder_1_set = (set[0]) ? {set[6:1],way_bit} : set; // if set number is even then get meta data from left column else flip the bit to get data from left column
assign decoder_2_set = (set[0]) ? set : {set[6:1],way_bit};

assign data_is_valid_on_way_1 = ((meta_data_1_read[5:0] == tag) & meta_data_1_read[7]); // check if data we are reading is valid
assign data_is_valid_on_way_2 = ((meta_data_2_read[5:0] == tag) & meta_data_2_read[7]);

assign cache_hit = (data_is_valid_on_way_1 | data_is_valid_on_way_2); // check if we have a cache hit

assign cache_miss_data_set = (way_to_write) ? decoder_2_set : decoder_1_set;

assign cache_hit_data_set = (data_is_valid_on_way_1) ? decoder_1_set : decoder_2_set;

assign cache_data_set = (cache_hit) ? cache_hit_data_set : cache_miss_data_set;

assign missed_word_block = {missed_mem_address[3:1]}; // block numbers to write to the cache in case of a miss

assign cache_word_block_num = (cache_hit) ? word_number : missed_word_block; // if cache is a hit then get that word number else write to the cache with word starting from 0 to 7

assign meta_data_1_write = data_is_valid_on_way_1 ? {meta_data_1_read[7], 1'b0, meta_data_1_read[5:0]} : // Meta data updates to write
						   data_is_valid_on_way_2 ? {meta_data_1_read[7], 1'b1, meta_data_1_read[5:0]} :
						   way_to_write ? {1'b1,1'b0,tag} : {meta_data_1_read[7], 1'b1, meta_data_1_read[5:0]}; // MSB is the valid bit, the other one is the LRU bit if 0 means that we just used it if 1 means that its least recently used data

assign meta_data_2_write = data_is_valid_on_way_1 ? {meta_data_2_read[7], 1'b1, meta_data_2_read[5:0]} :
						   data_is_valid_on_way_2 ? {meta_data_2_read[7], 1'b0, meta_data_2_read[5:0]} :
						   way_to_write ? {meta_data_2_read[7], 1'b1, meta_data_2_read[5:0]} : {1'b1,1'b0,tag};
						   
assign way_to_write = (meta_data_1_read[6]) ? 0 : 1'b1; // 0 = way_1 , 1 = way_2;

assign byte_offset = {mem_address[2:0]};
assign set = {mem_address[9:3]};
assign tag = {mem_address[15:10]};



endmodule
