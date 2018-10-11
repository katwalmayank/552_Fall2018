module ALU(ALU_Out, Error, ALU_In1, ALU_In2, Opcode);

input[3:0] ALU_In1, ALU_In2;
input[1:0] Opcode; 
output reg [3:0] ALU_Out;
output reg Error; // Just to show overflow.......

reg signed [3:0] sum, diff;
reg overflow, overflow2;

addsub_4bit iDUT(.Ovfl(overflow), .Sum(sum), .A(ALU_In1), .B(ALU_In2), .sub(1'b0));
addsub_4bit iDUT2(.Ovfl(overflow2), .Sum(diff), .A(ALU_In1), .B(ALU_In2), .sub(1'b1));

always@(*) begin 

// default values
ALU_Out = 4'b0;
Error = 1'b0;

	case(Opcode)
		2'b00: begin
			ALU_Out = sum;
			Error = overflow;
		end

		2'b01: begin
			ALU_Out = diff;
			Error = overflow2;
		end
	
		2'b10: begin
			ALU_Out = ~(ALU_In1 & ALU_In2);
		end

		2'b11: begin
			ALU_Out = ALU_In1 ^ ALU_In2;
		end

		default: begin
			Error = 1'b1;
		end
	endcase
end

endmodule
