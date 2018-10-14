module ALU_tb();

logic signed [15:0] ALU_Out, ALU_In1, ALU_In2, test_sub, test_sum;
logic [2:0] Opcode, Flags;
logic Error;

logic [16:0] count;

logic signed[15:0] sum_check, sub_check, red_final;

logic [8:0] red1, red2;
logic [9:0] red_sum;

logic [4:0] shift_val;
logic signed [15:0] check_shift_val, check_right_shift_val;

logic signed[3:0] t1, t2, t3, t4, final1, final2, final3, final4;
logic [15:0] final_padd_sb_val;


assign test_sum = ALU_In1 + ALU_In2;
assign test_sub = ALU_In1 - ALU_In2;

assign sum_check = (ALU_In1 > 0 && ALU_In2 > 0 && test_sum < 0) ? 16'h7FFF :
				   (ALU_In1 < 0 && ALU_In2 < 0 && test_sum > 0) ? 16'h8000 :
																   test_sum;
							
assign sub_check = (ALU_In1 < 0 && ALU_In2 > 0 && test_sub > 0) ? 16'h8000 :
				   (ALU_In1 > 0 && ALU_In2 < 0 && test_sub < 0) ? 16'h7FFF :
																   test_sub;
														 
assign red1 = ALU_In1[7:0] + ALU_In2[7:0];
assign red2 = ALU_In1[15:8] + ALU_In2[15:8];
assign red_sum = red1 + red2;
assign red_final = {{8{red_sum[8]}}, red_sum[7:0]};

assign check_shift_val = ALU_In1 << shift_val;

assign check_right_shift_val = ALU_In1 >>> shift_val;

assign t1 = ALU_In1[3:0] + ALU_In2[3:0];
assign t2 = ALU_In1[7:4] + ALU_In2[7:4];
assign t3 = ALU_In1[11:8] + ALU_In2[11:8];
assign t4 = ALU_In1[15:12] + ALU_In2[15:12];

assign final1 = ((~ALU_In1[3] && ~ALU_In2[3] && t1 <= 0) && (ALU_In1 [3:0] != 0 && ALU_In2 [3:0] != 0)) ? 4'b0111 :
				((ALU_In1[3] && ALU_In2[3] && t1 >= 0) && (ALU_In1 [3:0] != 0 && ALU_In2 [3:0] != 0)) ?   4'b1000 :
												    t1;
assign final2 = ((~ALU_In1[7] && ~ALU_In2[7] && t2 <= 0) && (ALU_In1 [7:4] != 0 && ALU_In2 [7:4] != 0)) ? 4'b0111 :
				((ALU_In1[7] && ALU_In2[7] && t2 >= 0) && (ALU_In1 [7:4] != 0 && ALU_In2 [7:4] != 0)) ?   4'b1000 :
												    t2;
assign final3 = ((~ALU_In1[11] && ~ALU_In2[11] && t3 <= 0) && (ALU_In1 [11:8] != 0 && ALU_In2 [11:8] != 0)) ? 4'b0111 :
				((ALU_In1[11] && ALU_In2[11] && t3 >= 0) && (ALU_In1 [11:8] != 0 && ALU_In2 [11:8] != 0)) ?   4'b1000 :
												    t3;
assign final4 = ((~ALU_In1[15] && ~ALU_In2[15] && t4 <= 0) && (ALU_In1 [15:12] != 0 && ALU_In2 [15:12] != 0)) ? 4'b0111 :
				((ALU_In1[15] && ALU_In2[15] && t4 >= 0) && (ALU_In1 [15:12] != 0 && ALU_In2 [15:12] != 0)) ?   4'b1000 :
												    t4;
assign final_padd_sb_val = {final4, final3, final2, final1};


ALU iDUT(.ALU_Out(ALU_Out), .Error(Error), .ALU_In1(ALU_In1), .ALU_In2(ALU_In2), .Opcode(Opcode), .Flags(Flags));

initial begin

	ALU_In1 = 0;
	ALU_In2 = 0;
	Opcode = 0;
	#50;
	
///////////////////////////////////////////////////////////////////////////////////////////
//
//							Opcode = 0 Test ADDD
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 0;
	for(count = 0; count < 17'h10000; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#10;
		if(ALU_Out != sum_check)begin
			$display("ALU_In1 0x%h ALU_In2 0x%h ALU_Out 0x%h", ALU_In1, ALU_In2, ALU_Out);
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
//					Opcode = 1 Test For Subbing ALU_In1 and ALU_In2
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 1;
	for(count = 0; count < 17'h10000; count = count + 1)begin
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
		
		//if(ALU_Out == 16'h8000 || ALU_Out == 16'h7FFF)
			//$display("ALU_In1 0x%h ALU_In2 0x%h ALU_Out 0x%h", ALU_In1, ALU_In2, ALU_Out);
	end
	
	ALU_In1 = 16'h80C2;
	ALU_In2 = 16'h7cff;
	#10;
	//$display("Edge case ALU_In1 0x%h ALU_In2 0x%h ALU_Out 0x%h", ALU_In1, ALU_In2, ALU_Out);
	$display("Passed Opcode 1 for the subber");
	
///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 2 Test For XOR ALU_In1 and ALU_In2
//
///////////////////////////////////////////////////////////////////////////////////////////

	Opcode = 2;
	for(count = 0; count < 17'h10000; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#10;
		if(ALU_Out != (ALU_In1 ^ ALU_In2))begin
			$display("For XOR was as expecting 0x%h got 0x%h", (ALU_In1 ^ ALU_In2), ALU_Out);
			$stop;
		end
		
	end
	
	$display("Passed Opcode 2 for the XOR");

///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 3 Test For RED ALU_In1 and ALU_In2
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 3;
	for(count = 0; count < 17'h10000; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#10;
		//$display("ALU_In1 0x%h ALU_In2 0x%h", ALU_In1, ALU_In2);
		//$display("RED was expecting 0x%h got 0x%h", red_final, ALU_Out);
		if(red_final != ALU_Out)begin
			$display("ALU_In1 0x%h ALU_In2 0x%h", ALU_In1, ALU_In2);
			$display("RED was expecting 0x%h got 0x%h", red_final, ALU_Out);
			$stop;
		end
		
	end
	
	$display("Passed Opcode 3 for the RED");
	
///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 4 Test For SHIFT LEFT_In1 and IMM
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 4;
	for(count = 0; count < 12'hfff; count = count + 1)begin
		ALU_In1 = $random;
		
		for(shift_val = 0; shift_val < 5'h10; shift_val = shift_val + 1) begin
			ALU_In2 = shift_val;
			#5;
			//$display("ALU_In1 0x%h shift_val %b ALU_Out 0x%h", ALU_In1, shift_val, ALU_Out);
			if(check_shift_val != ALU_Out)begin
				$display("Unexpected value was expecting 0x%h got 0x%h", check_shift_val, ALU_Out);
				$stop;
			end
			
		end
		
	end
	
	$display("Passed Opcode 4 for the shift left");
	

///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 5 Test For SHIFT Right ALU_In1 and IMM
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 5;
	for(count = 0; count < 12'hfff; count = count + 1)begin
		ALU_In1 = $random;
		
		for(shift_val = 0; shift_val < 5'h10; shift_val = shift_val + 1) begin
			ALU_In2 = shift_val;
			#5;
			//$display("ALU_In1 0x%h shift_val %b ALU_Out 0x%h", ALU_In1, shift_val, ALU_Out);
			if(check_right_shift_val != ALU_Out)begin
				$display("Unexpected value was expecting 0x%h got 0x%h", check_right_shift_val, ALU_Out);
				$stop;
			end
			
		end
		
	end
	
	$display("Passed Opcode 5 for the shift right");
	
	
///////////////////////////////////////////////////////////////////////////////////////////
//
//					Opcode = 7 Test For PADDSUB
//
///////////////////////////////////////////////////////////////////////////////////////////
	Opcode = 7;
	for(count = 0; count < 17'h10000; count = count + 1)begin
		ALU_In1 = $random;
		ALU_In2 = $random;
		
		#5;
		if(ALU_Out != final_padd_sb_val)begin
			$display("Unexpected value was expecting 0x%h got 0x%h", final_padd_sb_val, ALU_Out);
			$stop;
		end
	end
	
	$display("Passed Opcode 7 for the paddsb");

end
endmodule
