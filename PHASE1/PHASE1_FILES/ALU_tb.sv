module ALU_tb();

logic signed [15:0] ALU_Out, ALU_In1, ALU_In2;
logic [2:0] Opcode, Flags;
logic Error;

logic [16:0] count;

logic signed[15:0] sum_check, sub_check, red_final;

logic [7:0] red1, red2, red_sum;


assign sum_check = (ALU_In1 > 0 && ALU_In2 > 0 && ALU_Out < 0) ? 16'h7FFF :
				   (ALU_In1 < 0 && ALU_In2 < 0 && ALU_Out > 0) ? 16'h8000 :
														 ALU_In1 + ALU_In2;
							
assign sub_check = (ALU_In1 < 0 && ALU_In2 > 0 && ALU_Out > 0) ? 16'h8000 :
				   (ALU_In1 > 0 && ALU_In2 < 0 && ALU_Out < 0) ? 16'h7FFF :
														 ALU_In1 - ALU_In2;
														 
assign red1 = ALU_In1[7:0] + ALU_In2[7:0];
assign red2 = ALU_In1[15:8] + ALU_In2[15:8];
assign red_sum = red1 + red2;
assign red_final = {{8{red_sum[7]}}, red_sum[7:0]};

ALU iDUT(.ALU_Out(ALU_Out), .Error(Error), .ALU_In1(ALU_In1), .ALU_In2(ALU_In2), .Opcode(Opcode), .Flags(Flags));

initial begin

	ALU_In1 = 0;
	ALU_In2 = 0;
	Opcode = 0;
	#50;
	
///////////////////////////////////////////////////////////////////////////////////////////
//
//							Opcode = 0 Test
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 0;
	for(count = 0; count < 17'h1FFFF; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#10;
		if(ALU_Out != sum_check)begin
			$display("For Add was expecting 0x%h got 0x%h", sum_check, ALU_Out);
			$stop;
		end
		
		if(ALU_Out == 0 && ~Flags[2])begin
			$display("Add did not set zero flag ALU_Out = 0x%h", ALU_Out);
			$stop;
		end
		
		if(ALU_Out[15] && ~Flags[0])begin
			$display("Add did not set negative flag ALU_Out = 0x%h", ALU_Out);
			$stop;
		end
		
		if(ALU_Out == 16'h8000 || ALU_Out == 16'h7FFF)
			$display("ALU_In1 0x%h ALU_In2 0x%h ALU_Out 0x%h", ALU_In1, ALU_In2, ALU_Out);
	end
	
	ALU_In1 = 16'h8000;
	ALU_In2 = 16'h8001;
	#10;
	$display("Edge case ALU_In1 0x%h ALU_In2 0x%h ALU_Out 0x%h", ALU_In1, ALU_In2, ALU_Out);
	$display("Passed Opcode 0 for the adder");
	
///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 1 Test For Adding ALU_In1 and ALU_In2
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 1;
	for(count = 0; count < 17'h1FFFF; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#10;
		if(ALU_Out != sub_check)begin
			$display("For Sub was expecting 0x%h got 0x%h", sub_check, ALU_Out);
			$stop;
		end
		
		if(ALU_Out == 0 && ~Flags[2])begin
			$display("Sub did not set zero flag ALU_Out = 0x%h", ALU_Out);
			$stop;
		end
		
		if(ALU_Out[15] && ~Flags[0])begin
			$display("Sub did not set negative flag ALU_Out = 0x%h", ALU_Out);
			$stop;
		end
		
		if(ALU_Out == 16'h8000 || ALU_Out == 16'h7FFF)
			$display("ALU_In1 0x%h ALU_In2 0x%h ALU_Out 0x%h", ALU_In1, ALU_In2, ALU_Out);
	end
	
	ALU_In1 = 16'h80C2;
	ALU_In2 = 16'h7cff;
	#10;
	$display("Edge case ALU_In1 0x%h ALU_In2 0x%h ALU_Out 0x%h", ALU_In1, ALU_In2, ALU_Out);
	$display("Passed Opcode 1 for the subber");
	
///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 2 Test For Subtracting ALU_In1 and ALU_In2
//
///////////////////////////////////////////////////////////////////////////////////////////

	Opcode = 2;
	for(count = 0; count < 17'h1FFFF; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#10;
		if(ALU_Out != (ALU_In1 ^ ALU_In2))begin
			$display("For XOR was as expecting 0x%h got 0x%h", (ALU_In1 ^ ALU_In2), ALU_Out);
			$stop;
		end
		
	end
	
	$display("Passed Opcode 2 for the subber");

///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 3 Test For XOR ALU_In1 and ALU_In2
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 3;
	for(count = 0; count < 17'h1FFFF; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#10;
		if(red_final != ALU_Out)begin
			$display("ALU_In1 0x%h ALU_In2 0x%h", ALU_In1, ALU_In2);
			$display("RED was expecting 0x%h got 0x%h", red_final, ALU_Out);
			$stop;
		end
		
	end
	
	$display("Passed Opcode 3 for the subber");

end
endmodule
