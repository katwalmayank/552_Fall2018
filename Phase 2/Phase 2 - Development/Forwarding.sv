module Forwarding(MEM_RegWrite, MEM_RegRd, EX_RegRs, EX_RegRt, WB_RegWrite, WB_RegRd, MEM_MemWrite, MEM_RegRt,Forward_A, Forward_B);

input MEM_RegWrite,WB_RegWrite,MEM_MemWrite;
input[3:0] MEM_RegRd, EX_RegRs, EX_RegRt, WB_RegRd,MEM_RegRt; 
output[1:0] Forward_A, Forward_B;

wire EX_forward_A, EX_forward_B, MEM_EX_forward_A, MEM_EX_forward_B, MEM_MEM_forward_B; 

assign EX_forward_A =  (MEM_RegWrite & (MEM_RegRd != 0) & (MEM_RegRd == EX_RegRs));
assign EX_forward_B =  (MEM_RegWrite & (MEM_RegRd != 0) & (MEM_RegRd == EX_RegRt));
assign MEM_EX_forward_A = (WB_RegWrite & (WB_RegRd != 0) & (WB_RegRd == EX_RegRs));
assign MEM_EX_forward_B = (WB_RegWrite & (WB_RegRd != 0) & (WB_RegRd == EX_RegRt));

assign MEM_MEM_forward_B = (MEM_MemWrite & WB_RegWrite & (WB_RegRd != 0) & (WB_RegRd == MEM_RegRt));


assign Forward_A =  (EX_forward_A) ? 2'b10:
				    (MEM_EX_forward_A) ? 2'b01:
					2'b00; 							//no forwarding 



assign Forward_B =  (MEM_MEM_forward_B) ? 2'b11:	//only RD reg forwarded
		    (EX_forward_B)      ? 2'b10:
		    (MEM_EX_forward_B)  ? 2'b01:
					  2'b00; 							//no forwarding  


					
endmodule 