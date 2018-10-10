module Shifter_tb();

reg[15:0] Shift_In;
reg[15:0] Shift_Out;
logic Mode; 
reg[3:0] Amount; 
reg [16:0] shift_check; //to check for 16'hF 
reg [4:0] Amount_check; 
reg [1:0] Mode_check; 

Shifter iDUT(.Shift_Out(Shift_Out), .Shift_In(Shift_In), .Shift_Val(Amount), .Mode(Mode));

initial begin 
	Shift_In = 16'b0000000000000000;
	Amount = 4'b0000; 
	Mode = 0; 
	for(shift_check = 0; shift_check < 65536; shift_check++)
	begin 
		Shift_In = Shift_In+1; 	
		for(Amount_check = 0; Amount_check < 16; Amount_check++)
		begin
			Amount = Amount + 1; 
			for(Mode_check = 0; Mode_check < 2; Mode_check++)
			begin
				Mode = Mode+1;
				#5 $display("Shift Value: %b  Shift Amount: %b , Mode: %d, Result: %b", Shift_In,Amount,Mode,Shift_Out);
			end
		end
	end


end 


endmodule

