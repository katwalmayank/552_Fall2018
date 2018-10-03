module WriteDecoder_4_16(RegId, WriteReg, Wordline);

input[3:0] RegId; 
input WriteReg;
output[15:0] Wordline;

reg[15:0] regToWrite; 

ReadDecoder_4_16 ReadReg(.RegId(RegId),.Wordline(regToWrite)); 
assign Wordline = (WriteReg)? regToWrite : 16'b0000000000000000;

endmodule
