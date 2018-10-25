module Hazard(stall,IF_ID_RegRS, IF_ID_RegRT,ID_EX_RegRT,ID_EX_MemRead);

input ID_EX_MemRead; 
input[3:0] IF_ID_RegRS, IF_ID_RegRT,ID_EX_RegRT;
output stall; 

assign stall = (ID_EX_MemRead & ((ID_EX_RegRT == IF_ID_RegRS) | (ID_EX_RegRT == IF_ID_RegRT))) ? 1:0; 

endmodule 
