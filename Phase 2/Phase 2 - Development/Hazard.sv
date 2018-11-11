module Hazard(stall, ID_RegRs, ID_RegRt, ID_MemWrite, EX_RegRt, EX_MemRead);

input ID_MemWrite, EX_MemRead; 
input[3:0] ID_RegRs, ID_RegRt, EX_RegRt;
output stall; 

assign stall = (EX_MemRead & ((EX_RegRt == ID_RegRs) | ((EX_RegRt == ID_RegRt) & ~ID_MemWrite))) ? 1 : 0; 

endmodule 
