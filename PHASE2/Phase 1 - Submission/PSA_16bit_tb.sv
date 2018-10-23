module PSA_16bit_tb;

logic [15:0] A, B, Sum;

logic signed[3:0] t1, t2, t3, t4, final1, final2, final3, final4;
logic [15:0] t_sum;

logic [16:0] count;

PSA_16bit iDUT(.Sum(Sum), .A(A), .B(B));

assign t1 = A[3:0] + B[3:0];
assign t2 = A[7:4] + B[7:4];
assign t3 = A[11:8] + B[11:8];
assign t4 = A[15:12] + B[15:12];

assign t_sum = {final4,final3,final2,final1};

task Check_Sign;

	#5;
	if((~A[3] && ~B[3] && t1 <= 0) && (A[3:0] != 0 && B[3:0] != 0))begin
		final1 = 4'b0111;
	end else if ((A[3] && B[3] && t1 >= 0) && (A[3:0] != 0 && B[3:0] != 0)) begin
		final1 = 4'b1000;
	end else begin
		final1 = t1;
	end
	
	#5;
	if((~A[7] && ~B[7] && t2 <= 0) && (A[7:4] != 0 && B[7:4] != 0))begin
		final2 = 4'b0111;
	end else if ((A[7] && B[7] && t2 >= 0) && (A[7:4] != 0 && B[7:4] != 0))begin
		final2 = 4'b1000;
	end else begin
		final2 = t2;
	end
	
	#5;
	if((~A[11] && ~B[11] && t3 <= 0) && (A[11:8] != 0 && B[11:8] != 0))begin
		final3 = 4'b0111;
	end else if ((A[11] && B[11] && t3 >= 0) && (A[11:8] != 0 && B[11:8] != 0))begin
		final3 = 4'b1000;
	end else begin
		final3 = t3;
	end
	
	#5;
	if((~A[15] && ~B[15] && t4 <= 0) && (A[15:12] != 0 && B[15:12] != 0))begin
		final4 = 4'b0111;
	end else if ((A[15] && B[15] && t4 >= 0) && (A[15:12] != 0 && B[15:12] != 0))begin
		final4 = 4'b1000;
	end else begin
		final4 = t4;
	end

	#5;
endtask;

initial begin
	A = 0;
	B = 0;
	final1 = 0;
	final2 = 0;
	final3 = 0;
	final4 = 0;
	#5;
	
	for(count = 0; count < 16'hFFFF; count = count + 1)begin
		#5;
		A = $random;
		B = $random;

		Check_Sign;
		
		if(t_sum != Sum)begin
			$display("Unexpected value was expecting 0x%h got 0x%h", t_sum, Sum);
			$stop;
		end
	end
	$display("Past!!!");
	$stop;
	
end

endmodule
