module CLA_16bit_tb();

logic signed [15:0] A, B, Sum;
logic signed [16:0] Check_Sum;
logic Cin, Cout;

logic [16:0] count;


CLA_16bit iDUT(.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));

assign Check_Sum = A + B + Cin;

initial begin
	A = 0;
	B = 0;
	Cin = 0;
	
	for(count = 0; count < 16'hFFFF; count = count + 1)begin
		A = $random;
		B = $random;
		Cin = $random;
		#5;
		if((Check_Sum[15:0] != Sum) || (Cout != Check_Sum[16]))begin
			$display("Unexpected value was expecting 0x%h, got 0x%h", Check_Sum[15:0], Sum);
			$stop;
		end
		
		if(Cout && ~A[15] && ~B[15])begin
			$display("A = %d B = %d Cin = %d Check_Sum = %d Sum = %d", A, B, Cin, Check_Sum, Sum);
		end
		//$display("A = %d B = %d Cin = %d Check_Sum = %d Sum = %d", A, B, Cin, Check_Sum, Sum);
	end
	$display("Past!!!");
	
end

endmodule
