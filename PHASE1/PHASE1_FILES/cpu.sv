module cpu(clk,rst_n,hlt,pc);

input clk;
input rst_n; 
output hlt;
output [15:0] pc;

// PC Control
PC_control PC(.opcode(), .data_in(), .C(), .I(), .F(), .PC_in(), .PC_out());

// Instruction Memory
memory1c InstMem(.data_out(), .data_in(), .addr(), .enable(), .wr(), .clk(), .rst());

// Data Memory
memory1c DataMem(.data_out(), .data_in(), .addr(), .enable(), .wr(), .clk(), .rst());

// Registers
RegisterFile Registers(.clk(clk), .rst(~rst_n), .SrcReg1(), .SrcReg2(), .DstReg(), .WriteReg(), .DstData(), .SrcData1(), .SrcData2());

endmodule
