module cache_access_decoder(byte_offset, set, block_number, word_number);

input [3:0] byte_offset;
input [5:0] set;

output [7:0] word_number;
output [127:0] block_number;

endmodule