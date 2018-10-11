module CLA_4bit(Sum, Prop_Val, Gen_Val, A, B, Cin); 
    
input [3:0] A, B;
input Cin;
output [3:0] Sum;
output Prop_Val, Gen_Val;
    
wire [3:0] Generate, Propagate, Carry;
 
//Carry propagate and generate wire 
assign Generate = A & B;
assign Propagate = A ^ B; 
	


//CarryWire
assign Carry[0] = Cin;
assign Carry[1] = Generate[0] | (Propagate[0] & Carry[0]);
assign Carry[2] = Generate[1] | (Propagate[1] & Generate[0]) | (Propagate[1] & Propagate[0] & Carry[0]);
assign Carry[3] = Generate[2] | (Propagate[2] & Generate[1]) | (Propagate[2] & Propagate[1] & Generate[0]) | (Propagate[2] & Propagate[1] & Propagate[0] & Carry[0]);
    
//CarryOut
assign Cout = Generate[3] | (Propagate[3] & Generate[2]) | (Propagate[3] & Propagate[2] & Generate[1]) | (Propagate[3] & Propagate[2] & Propagate[1] & Generate[0]) |(Propagate[3] & Propagate[2] & Propagate[1] & Propagate[0] & Carry[0]);
    
//SumValue  
assign Sum = Propagate ^ Carry;
    
//Single propagate and generate value
assign Prop_Val = Propagate[3] & Propagate[2] & Propagate[1] & Propagate[0];
assign Gen_Val = Generate[3] | (Propagate[3] & Generate[2]) | (Propagate[3] & Propagate[2] & Generate[1]) | (Propagate[3] & Propagate[2] & Propagate[1] & Generate[0]);

endmodule
