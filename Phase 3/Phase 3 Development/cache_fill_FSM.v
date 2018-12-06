module cache_fill_FSM(clk, rst_n, miss_detected, miss_address, fsm_busy, write_data_array, write_tag_array, memory_address, memory_data, memory_data_valid);

input clk, rst_n;
input miss_detected; // active high when tag match logic detects a miss
input [15:0] miss_address; // address that missed the cache
input [15:0] memory_data; // data returned by memory (afterdelay)
input memory_data_valid; // active high indicates valid data returning on memory bus

output fsm_busy; // asserted while FSM is busy handling the miss (can be used as pipeline stall signal)
output write_data_array; // write enable to cache data array to signal when filling with memory_data
output write_tag_array; // write enable to cachetag array to signal when all words are filled in to data array
output [15:0] memory_address; // address to read from memory

wire curr_state, next_state, delayed_next_state, stop_mem_count, pause4, pause3, pause2, pause, blah;

wire [3:0] chunk_inc, chunk_count, chunk_val;

wire [15:0] mem_inc, mem_count, mem_val;

assign write_data_array = memory_data_valid & miss_detected & pause & next_state;
assign blah = miss_detected;

dff dff_pause1(.q(pause4), .d(blah), .wen(1'b1), .clk(clk), .rst(~rst_n));
dff dff_pause2(.q(pause3), .d(pause4), .wen(1'b1), .clk(clk), .rst(~rst_n));
dff dff_pause3(.q(pause2), .d(pause3), .wen(1'b1), .clk(clk), .rst(~rst_n));
dff dff_pause4(.q(pause), .d(pause2), .wen(1'b1), .clk(clk), .rst(~rst_n));

assign write_tag_array = (chunk_count == 4'b1011) ? 1'b1 : 0;

// Chunk counter and dff
addsub_4bit chunk_incrementer(.Sum(chunk_inc), .Ovfl(), .A(chunk_count), .B(4'b0001 & miss_detected), .sub(1'b0));
dff_4bit chunk_value(.q(chunk_val), .d(chunk_inc), .wen(1'b1), .clk(clk), .rst(~rst_n));

assign chunk_count = (curr_state != 1'b1) ? 0 : chunk_val;

assign stop_mem_count = (chunk_count == 4'b0111 | chunk_count == 4'b1000 | chunk_count == 4'b1001 | chunk_count == 4'b1010 | chunk_count == 4'b1011 | chunk_count == 4'b1100);

// Mem Incrementer and the dff
addsub_16bit mem_address_incrementer(.Sum(mem_inc), .Ovfl(), .A(mem_count), .B(16'h0002 & {16{miss_detected}} & {16{~stop_mem_count}}), .Sub(1'b0));
dff_16bit mem_access_value(.q(mem_val), .d(mem_inc), .wen(1'b1), .clk(clk), .rst(~rst_n));

assign mem_count = (curr_state == 1'b1 & chunk_val != 0) ? memory_address : {miss_address[15:4], 4'h0};

// State dff
dff state_delay(.q(curr_state), .d(next_state), .wen(1'b1), .clk(clk), .rst(~rst_n));
//dff state_of_FSM(.q(curr_state), .d(delayed_next_state), .wen(1'b1), .clk(clk), .rst(~rst_n));

//dff fsm_busy_dff(.q(fsm_busy), .d(stall), .wen(1'b1), .clk(clk), .rst(rst_n));
assign fsm_busy = (miss_detected & (chunk_val != 4'b1100)) ? 1'b1 : 0;

assign next_state = (miss_detected & (chunk_count != 4'b1100)) ? 1'b1 : 0;

assign memory_address = (chunk_count == 0) ? mem_count : mem_val;
//dff_16bit memory_add_delay(.q(memory_address), .d(mem_val), .wen(1'b1), .clk(clk), .rst(~rst_n));


endmodule