module cache(clk, rst, cache_write, mem_address, cache_data_out, cache_data_in, stall, mem_data_valid);

input clk, rst, cache_write, mem_data_valid;
input [15:0] mem_address, cache_data_in;

output stall;
output [15:0] cache_data_out;

wire [3:0] byte_offset;
wire [7:0] meta_data_read;

wire [7:0] word_number;
wire [127:0] block_number;

DataArray cache_data(.clk(clk), 
					 .rst(rst), 
					 .DataIn(cache_data_in), 
					 .Write(cache_write), 
					 .BlockEnable(block_number), 
					 .WordEnable(word_number), 
					 .DataOut(cache_data_out)
);

MetaDataArray cache_meta_data(.clk(clk), 
							  .rst(rst), 
							  .DataIn({1'b1,1'b0,tag}), 
							  .Write(cache_write), 
							  .BlockEnable(block_number), 
							  .DataOut(meta_data_read)
);

cache_fill_FSM cache_FSM(.clk(clk), 
						 .rst_n(rst), 
						 .miss_detected({[7]meta_data_read}), 
						 .miss_address(mem_address), 
						 .fsm_busy(stall), 
						 .write_data_array(), 
						 .write_tag_array(), 
						 .memory_address(), 
						 .memory_data(), 
						 .memory_data_valid(mem_data_valid)
);

cache_access_decoder cache_decoder(.byte_offset(byte_offset), 
								   .set(set), 
								   .block_number(block_number), 
								   .word_number(word_number)
);

assign byte_offset = {mem_address[3:0]};
assign set = {mem_address[9:4]};
assign tag = {mem_address[15:10]};



endmodule
