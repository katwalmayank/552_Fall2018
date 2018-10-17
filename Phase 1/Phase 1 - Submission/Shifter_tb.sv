module Shifter_tb();

logic [16:0] counter3;
logic [15:0] out, in, check1, check2, check3;
logic [4:0] counter;
logic [3:0] val, top;
logic [1:0] counter2;
logic [1:0] mode;

Shifter S1(.Shift_Out(out), .Shift_In(in), .Shift_Val(val), .Mode(mode));

assign check1 = in << val;
assign check2 = in >> val;


initial begin

	// exhaustively test all posibilities of val and mode
	in = 0;
	val = 0;
	mode = 0;
	
	for(counter3 = 0; counter3 < 17'h1FFFF; counter3 = counter3 + 1) begin

		for(counter = 0; counter < 16; counter = counter + 1) begin
			
			mode = 0;
			#5;
			if(out != check1)begin
				$display("Unexpected value was expecting 0x%h got 0x%h", check1, out);
				$stop;
			end
			
			mode = 1;
			#5;
			if(out != check2)begin
				$display("Unexpected value was expecting 0x%h got 0x%h", check2, out);
				$stop;
			end

			mode = 2;
			#5
			$display("Rotate right in (%b)0x%h || shift val %d || out(%b)0x%h", in, in, val, out, out);
			val = val + 1;
		end
		val = 0;
		#5 in = in + 1;
	end
end

endmodule