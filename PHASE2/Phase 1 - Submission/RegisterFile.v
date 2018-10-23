module RegisterFile(clk, rst, SrcReg1, SrcReg2, DstReg, WriteReg, DstData, SrcData1, SrcData2);

input clk, rst, WriteReg;
input [3:0] SrcReg1, SrcReg2, DstReg;
input [15:0] DstData;
inout [15:0] SrcData1, SrcData2;

// Outputs from Decoders
wire [15:0] read1, read2, write1;

// Decoders
WriteDecoder_4_16 wDecoder(.RegId(DstReg), .WriteReg(WriteReg), .Wordline(write1));

ReadDecoder_4_16 rDecoder1(.RegId(SrcReg1), .Wordline(read1));
ReadDecoder_4_16 rDecoder2(.RegId(SrcReg2), .Wordline(read2));

// Registers
Register reg0(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[0]), .ReadEnable1(read1[0]), .ReadEnable2(read2[0]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg1(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[1]), .ReadEnable1(read1[1]), .ReadEnable2(read2[1]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg2(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[2]), .ReadEnable1(read1[2]), .ReadEnable2(read2[2]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg3(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[3]), .ReadEnable1(read1[3]), .ReadEnable2(read2[3]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg4(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[4]), .ReadEnable1(read1[4]), .ReadEnable2(read2[4]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg5(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[5]), .ReadEnable1(read1[5]), .ReadEnable2(read2[5]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg6(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[6]), .ReadEnable1(read1[6]), .ReadEnable2(read2[6]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg7(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[7]), .ReadEnable1(read1[7]), .ReadEnable2(read2[7]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg8(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[8]), .ReadEnable1(read1[8]), .ReadEnable2(read2[8]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg9(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[9]), .ReadEnable1(read1[9]), .ReadEnable2(read2[9]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg10(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[10]), .ReadEnable1(read1[10]), .ReadEnable2(read2[10]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg11(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[11]), .ReadEnable1(read1[11]), .ReadEnable2(read2[11]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg12(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[12]), .ReadEnable1(read1[12]), .ReadEnable2(read2[12]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg13(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[13]), .ReadEnable1(read1[13]), .ReadEnable2(read2[13]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg14(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[14]), .ReadEnable1(read1[14]), .ReadEnable2(read2[14]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register reg15(.clk(clk), .rst(rst), .D(DstData), .WriteReg(write1[15]), .ReadEnable1(read1[15]), .ReadEnable2(read2[15]), .Bitline1(SrcData1), .Bitline2(SrcData2));

endmodule