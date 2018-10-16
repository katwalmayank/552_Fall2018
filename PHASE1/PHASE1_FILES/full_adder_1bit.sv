module full_adder_1bit(c_out, sum, a, b, c_in);

output sum, c_out;
input a, b, c_in;

assign sum = a ^ b ^ c_in;
assign c_out = (a & b) | (a & c_in) | (b & c_in);

endmodule