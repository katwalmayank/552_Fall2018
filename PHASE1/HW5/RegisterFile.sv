module RegisterFile(clk,rst,SrcReg1,SrcReg2,DstReg,WriteReg,DstData,SrcData1,SrcData2);

input clk;
input rst;
input [3:0] SrcReg1,SrcReg2; 
input [3:0] DstReg;
input WriteReg;
input [15:0] DstData;
inout [15:0] SrcData1, SrcData2;

wire[15:0] regout1, regout2,dest_out; 
wire[15:0] bitline1,bitline2; 


//Read srcreg1/srcreg2
ReadDecoder_4_16 reg_read1(.RegId(SrcReg1), .Wordline(regout1));
ReadDecoder_4_16 reg_read2(.RegId(SrcReg2), .Wordline(regout2));

//Write Reg
WriteDecoder_4_16 writeReg(.RegId(DstReg), .WriteReg(WriteReg), .Wordline(dest_out));


//16 REGISTERS 
Register Reg1(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[0]),.Readenable2(regout2[0]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg2(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[1]),.Readenable2(regout2[1]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg3(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[2]),.Readenable2(regout2[2]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg4(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[3]),.Readenable2(regout2[3]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg5(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[4]),.Readenable2(regout2[4]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg6(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[5]),.Readenable2(regout2[5]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg7(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[6]),.Readenable2(regout2[6]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg8(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[7]),.Readenable2(regout2[7]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg9(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[8]),.Readenable2(regout2[8]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg10(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[9]),.Readenable2(regout2[9]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg11(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[10]),.Readenable2(regout2[10]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg12(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[11]),.Readenable2(regout2[11]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg13(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[12]),.Readenable2(regout2[12]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg14(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[13]),.Readenable2(regout2[13]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg15(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[14]),.Readenable2(regout2[14]),.Bitline1(bitline1),.Bitline2(bitline2);
Register Reg16(.clk(clk),.rst(rst),.D(DstData),.WriteReg(WriteReg),.ReadEnable1(regout1[15]),.Readenable2(regout2[15]),.Bitline1(bitline1),.Bitline2(bitline2);

//Need to set Src Data 
assign SrcData1 = 
assign SrcData2 = 

	
endmodule

