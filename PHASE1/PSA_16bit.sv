module PSA_16bit (Sum, Error, A, B);
input [15:0] A, B; // Input data values
output [15:0] Sum; // Sum output
output Error; // To indicate overflows

wire Ovfl1, Ovfl2, Ovfl3, Ovfl4; 
reg[3:0] h_byte1, h_byte2, h_byte3, h_byte4; 

addsub_4bit ADDER1(.Sum(h_byte1), .A(A[3:0]),.B(B[3:0]),.sub(0),.Ovfl(Ovfl1)); 
addsub_4bit ADDER2(.Sum(h_byte2), .A(A[7:4]),.B(B[7:4]),.sub(0),.Ovfl(Ovfl2)); 
addsub_4bit ADDER3(.Sum(h_byte3), .A(A[11:8]),.B(B[11:8]),.sub(0),.Ovfl(Ovfl3)); 
addsub_4bit ADDER4(.Sum(h_byte4), .A(A[15:12]),.B(B[15:12]),.sub(0),.Ovfl(Ovfl4)); 

assign Error = (Ovfl1 | Ovfl2 | Ovfl3 | Ovfl4);  
assign Sum = {h_byte4,h_byte3,h_byte2,h_byte1};

endmodule