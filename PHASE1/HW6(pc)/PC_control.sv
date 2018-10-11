module PC_control(C,I,F,PC_in,PC_out);

input[2:0] C,F; 
input[8:0] I; 
input[15:0] PC_in; 
output[15:0] PC_out;  

wire[15:0] PC, target; 
wire[15:0] extended_i; 
wire ovfl; 

assign extended_i = {{6{0}},I<<1};

//ADD PC +2 
adder_16bit pc_adder(.Sum(PC),.Ovfl(ovfl),.A(PC_in),.B(16'b0000000000000010));

//ADD I 
adder_16bit I_adder(.Sum(target),.Ovfl(ovfl),.A(PC),.B(extended_i));

//F[0] = Zero flag (Z)
//F1[1] = Overflow flag (V)
//F2[2] = Sign Bit (N)

//for any condition on table 1, take target otherwise default to pc+2 

assign PC_out = (~C[0] & ~C[1] & ~C[2] & ~F[0]) ? target: //000
		(C[0] & ~C[1] & ~C[2]  & F[0]) ? target:  //001
		(~C[0] & C[1]  & ~C[2] & (~F[0] & ~F[2])) ? target: //010
 		(C[0] & C[1]  & ~C[2]  & F[2]) ? target: //011
		(~C[0]  & ~C[1] & C[2] & (F[0] | ~F[0] & ~F[2])) ? target: //100
		(C[0]  & ~C[1] & C[2]  & (F[2] | F[0]))? target: //101
		(~C[0]  & C[1]  & C[2] & F[1]) ? target: //110
		(C[0]  & C[1]  & C[2]) ? target: //111
		PC;	//take pc instead
    
endmodule
 
