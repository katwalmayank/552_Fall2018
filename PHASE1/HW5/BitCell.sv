module BitCell(clk, rst,D, WriteEnable,ReadEnable1,ReadEnable2,Bitline1,Bitline2);

input clk;
input rst; 
input D;
input WriteEnable;
input ReadEnable1;
input ReadEnable2; 

inout Bitline1;
inout Bitline2;

wire Q_dff; 

dff Dff(.q(Q_dff), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));

assign Bitline1 = (ReadEnable1) ? Q_dff: 1'bx;
assign Bitline2 = (ReadEnable2) ? Q_dff: 1'bx;


endmodule
