module dff_4bit (q, d, wen, clk, rst);

	//TO HOLD THE PC VALUE
	
    output[3:0]    q; //DFF output
    input[3:0]	   d; //DFF input
    input 	   wen; //Write Enable
    input          clk; //Clock
    input          rst; //Reset (used synchronously)

dff dff1(.q(q[0]), .d(d[0]), .wen(wen), .clk(clk), .rst(rst));
dff dff2(.q(q[1]), .d(d[1]), .wen(wen), .clk(clk), .rst(rst));
dff dff3(.q(q[2]), .d(d[2]), .wen(wen), .clk(clk), .rst(rst));
dff dff4(.q(q[3]), .d(d[3]), .wen(wen), .clk(clk), .rst(rst));

endmodule
