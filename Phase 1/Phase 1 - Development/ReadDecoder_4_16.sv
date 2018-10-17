module ReadDecoder_4_16(RegId, Wordline);

input [3:0] RegId;
output [15:0] Wordline;
reg [15:0] temp1, temp2, temp3;

assign temp1 = RegId[0] ? 16'h2 : 16'h1;
assign temp2 = RegId[1] ? temp1 << 2 : temp1;
assign temp3 = RegId[2] ? temp2 << 4 : temp2;
assign Wordline = RegId[3] ? temp3 << 8 : temp3;

endmodule

