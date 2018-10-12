module Shifter_tb();

reg [15:0] counter3;
reg signed [15:0] out, in, check1, check2;
reg [4:0] counter;
reg [3:0] val;
reg [1:0] counter2;
reg mode;


Shifter S1(.Shift_Out(out), .Shift_In(in), .Shift_Val(val), .Mode(mode));

initial begin

	// exhaustively test all posibilities of val and mode
	in = 16'b0;
	val = 4'b0;
	mode = 1'b0;
	
	for(counter3 = 0; counter3 < 65536; counter3 = counter3 + 1) begin

		for(counter = 0; counter < 16; counter = counter + 1) begin

			for(counter2 = 0; counter2 < 1; counter2 = counter2 + 1) begin
		
				#10 mode = mode + 1;
			end

			#10 val = val + 1;
		end

		#10 in = in + 1;
	end
end

// Save expected value
assign check1 = in >>> val;
assign check2 = in << val; 

// Check to make sure each addition matches what is expected
assign fail = mode ? (out != check2) : (out != check1); 

endmodule