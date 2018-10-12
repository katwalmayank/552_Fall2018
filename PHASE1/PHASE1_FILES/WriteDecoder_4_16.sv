module WriteDecoder_4_16(RegId, WriteReg, Wordline);

input [3:0] RegId; 
input WriteReg;
output [15:0] Wordline;
reg [15:0] temp1, temp2, temp3, temp4;

assign temp1 = RegId[0] ? 16'h2 : 16'h1;
assign temp2 = RegId[1] ? temp1 << 2 : temp1;
assign temp3 = RegId[2] ? temp2 << 4 : temp2;
assign temp4 = RegId[3] ? temp3 << 8 : temp3;
assign Wordline = WriteReg ? temp4 : 16'b0;

endmodule
