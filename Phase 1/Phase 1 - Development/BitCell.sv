module BitCell(clk, rst, D, WriteEnable, ReadEnable1, ReadEnable2, Bitline1, Bitline2);

input clk, rst, D, WriteEnable, ReadEnable1, ReadEnable2;
inout Bitline1, Bitline2;

wire Q; 

// D flip-flop
dff Dff(.q(Q), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));

// Tri-state buffers
assign Bitline1 = ReadEnable1 ? Q : 1'bz;
assign Bitline2 = ReadEnable2 ? Q : 1'bz;

endmodule
