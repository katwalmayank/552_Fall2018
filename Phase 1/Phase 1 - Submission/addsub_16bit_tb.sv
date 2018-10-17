module addsub_16bit_tb();

logic signed [15:0] A, B, Sum, test_sum, test_sub, computed_val, final_val;
logic Sub, case1, case2, case3 ,case4, chosen_a_case;
logic [16:0] count;
logic [3:0] test_edge_case;


addsub_16bit iDUT(Sum, A, B, Sub);

assign test_sum = A + B;
assign test_sub = A - B;

assign computed_val = (Sub) ? test_sub : test_sum;

assign test_edge_case = {case4, case3, case2, case1};

task Check_Over_Under_Flow;

	#5;
	if(A > 0 && B > 0 && ~Sub && computed_val < 0)begin
		chosen_a_case = 1;
		case1 = 1;
		final_val = 16'h7FFF;
	end else if(~chosen_a_case) begin
		final_val = computed_val;
	end
	
	#5;
	if(A < 0 && B < 0 && ~Sub && computed_val > 0)begin
		chosen_a_case = 1;
		case2 = 1;
		final_val = 16'h8000;
	end else if(~chosen_a_case) begin
		final_val = computed_val;
	end
	
	#5;
	if(A < 0 && B > 0 && Sub && computed_val > 0)begin
		chosen_a_case = 1;
		case3 = 1;
		final_val = 16'h8000;
	end else if(~chosen_a_case) begin
		final_val = computed_val;
	end
	
	#5;
	if(A > 0 && B < 0 && Sub && computed_val < 0)begin
		chosen_a_case = 1;
		case4 = 1;
		final_val = 16'h7FFF;
	end else if(~chosen_a_case) begin
		final_val = computed_val;
	end
	
	#5;

endtask;

initial begin
	A = 0;
	B = 0;
	Sub = 0;
	case1 = 0;
	case2 = 0;
	case3 = 0;
	case4 = 0;
	
	for(count = 0; count < 16'hFFFF; count = count + 1)begin
		A = $random;
		B = $random;
		Sub = $random;
		#5;
		
		Check_Over_Under_Flow;
		chosen_a_case = 0;
		#5;
		if(Sum != final_val)begin
			$display("Unexpected value was expecting 0x%h, got 0x%h", final_val, Sum);
			$stop;
		end
		
	end
	
	if(~(&test_edge_case))begin
		$display("Not all edge cases were tested");
		$stop;
	end
	
	$display("Past!!!");
	$stop;
	
end
endmodule
