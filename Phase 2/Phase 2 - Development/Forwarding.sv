module Forwarding(EX_MEM_RegWrite, EX_MEM_RegRd, ID_EX_RegRs, ID_EX_RegRt, MEM_WB_RegWrite, MEM_WB_RegRd, Forward_A, Forward_B, EX_MEM_MemWrite, EX_MEM_RegRt);

input EX_MEM_RegWrite,MEM_WB_RegWrite,EX_MEM_MemWrite;
input[3:0] EX_MEM_RegRd, ID_EX_RegRs, ID_EX_RegRt, MEM_WB_RegRd,EX_MEM_RegRt; 
output[1:0] Forward_A, Forward_B;

wire EX_forward_A, EX_forward_B, MEM_EX_forward_A, MEM_EX_forward_B, MEM_MEM_forward_B; 

assign EX_forward_A =  (EX_MEM_RegWrite & (EX_MEM_RegRd != 0) & (EX_MEM_RegRd == ID_EX_RegRs));
assign EX_forward_B =  (EX_MEM_RegWrite & (EX_MEM_RegRd != 0) & (EX_MEM_RegRd == ID_EX_RegRt));
assign MEM_EX_forward_A = (MEM_WB_RegWrite & (MEM_WB_RegRd != 0) & (MEM_WB_RegRd == ID_EX_RegRs));
assign MEM_EX_forward_B = (MEM_WB_RegWrite & (MEM_WB_RegRd != 0) & (MEM_WB_RegRd == ID_EX_RegRt));

assign MEM_MEM_forward_B = (EX_MEM_MemWrite & MEM_WB_RegWrite & (MEM_WB_RegRd != 0) & (MEM_WB_RegRd == EX_MEM_RegRt));


<<<<<<< HEAD


assign Forward_A =  (EX_forward_A)     ? 2'b10:
		    (MEM_EX_forward_A) ? 2'b01:
					 2'b00; 							//no forwarding 
=======
assign Forward_A =  (EX_forward_A) ? 2'b10:
				    (MEM_EX_forward_A) ? 2'b01:
					2'b00; 							//no forwarding 
>>>>>>> 316a96bba51e36910da33a03c4390c24b1b31279


assign Forward_B =  (MEM_MEM_forward_B) ? 2'b11:	//only RD reg forwarded
		    (EX_forward_B)      ? 2'b10:
		    (MEM_EX_forward_B)  ? 2'b01:
					  2'b00; 							//no forwarding  


					
endmodule 