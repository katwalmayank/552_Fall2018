module ALU(ALU_Out, Error, ALU_In1, ALU_In2, Opcode, Flags);

input[15:0] ALU_In1, ALU_In2;
input[2:0] Opcode; 

//F[2] = Z	 F[1] = V	F[0] = N
output reg [2:0] Flags;
output reg [15:0] ALU_Out;
output reg Error; // Just to show overflow.......

reg [1:0] shift_mode;
wire [15:0] sum, diff, red_out, padsub_out, shift_out;
wire overflow, overflow2;

//ADD 
//addsub_16bit adder(.Ovfl(overflow), .Sum(sum), .A(ALU_In1), .B(ALU_In2), .Sub(1'b0));
CLA_16bit adder(.A(ALU_In1), .B(ALU_In2), .Cin(1'b0), .Sum(sum), .overflow(overflow)); 

//SUB
addsub_16bit subber(.Ovfl(overflow2), .Sum(diff), .A(ALU_In1), .B(ALU_In2), .Sub(1'b1));

//RED
RED_16bit redder(.A(ALU_In1), .B(ALU_In2), .Sum(red_out));

//PADSUB
PSA_16bit PSA(.Sum(padsub_out), .A(ALU_In1), .B(ALU_In2));

//SHIFTER
Shifter shifter(.Shift_Out(shift_out), .Shift_In(ALU_In1), .Shift_Val(ALU_In2[3:0]), .Mode(shift_mode));

always@(*) begin 
// default values (why dont we put these in the default case below?) 
ALU_Out = 16'b0;
Error = 1'b0;
Flags = 3'b0;

	case(Opcode)
		
		//ADDER
		3'b000: begin
			ALU_Out = sum;
			Error = overflow;
			
			//SET Z FLAG
			Flags[2] = (ALU_Out == 16'b0); 
			
			//SET V FLAG
			Flags[1] = Error; 
			
			//SET N FLAG 
			Flags[0] = ALU_Out[15]; 
			
		end
		
		//SUBTRACTOR
		3'b001: begin
			ALU_Out = diff;
			Error = overflow2;
			
			//SET Z FLAG
			Flags[2] = (ALU_Out == 16'b0); 
			
			//SET V FLAG
			Flags[1] = Error; 
			
			//SET N FLAG 
			Flags[0] = ALU_Out[15];
			
		end
		
		//XOR
		3'b010: begin
			ALU_Out = ALU_In1 ^ ALU_In2;
			
			//SET Z FLAG
			Flags[2] = (ALU_Out == 16'b0);
		end
		
		//RED
		3'b011: begin
			ALU_Out = red_out;
		end
		
		//SHIFT LOGICAL LEFT 
		3'b100: begin
			shift_mode = 2'b00; 
			ALU_Out = shift_out ;
			
			//SET Z FLAG
			Flags[2] = (ALU_Out == 16'b0); 
		end
		
		//SHIFT RIGHT ARITHMETIC 
		3'b101: begin
			shift_mode = 2'b01; 
			ALU_Out = shift_out ;
			
			//SET Z FLAG
			Flags[2] = (ALU_Out == 16'b0); 
		end
		
		//ROTATE RIGHT
		3'b110: begin
			shift_mode = 2'b10; 
			ALU_Out = shift_out;
			
			//SET Z FLAG
			Flags[2] = (ALU_Out == 16'b0); 
		end
		
		//PADSUB
		3'b111: begin
			ALU_Out = padsub_out;
		end
		
		default: begin
			Error = 1'b1;
			ALU_Out = 16'b1;
		end
	endcase
end

endmodule
