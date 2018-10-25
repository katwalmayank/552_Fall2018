module Forwarding(EX_MEM_RegWrite, EX_MEM_RegRd, ID_EX_RegRs, ID_EX_RegRt, MEM_WB_RegWrite, MEM_WB_RegRd, Forward_A, Forward_B);

input EX_MEM_RegWrite,MEM_WB_RegWrite;
input[3:0] EX_MEM_RegRd, ID_EX_RegRs, ID_EX_RegRt, MEM_WB_RegRd; 
output[1:0] Forward_A, Forward_B;






endmodule 