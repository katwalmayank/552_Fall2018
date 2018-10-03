
module Shifter (Shift_Out, Shift_In, Shift_Val, Mode);
input [15:0] Shift_In; // This is the input data to perform shift operation on
input [3:0] Shift_Val; // Shift amount (used to shift the input data)
input Mode; // To indicate 0=SLL or 1=SRA
output [15:0] Shift_Out; // Shifted output data

reg[15:0] right,left; 
			
assign right = 			(Shift_Val==1) ? {Shift_In[15],Shift_In[15:1]}:
			  	(Shift_Val==2) ? {{2{Shift_In[15]}},Shift_In[15:2]}:
			 	(Shift_Val==3) ? {{3{Shift_In[15]}},Shift_In[15:3]}:
			  	(Shift_Val==4) ? {{4{Shift_In[15]}},Shift_In[15:4]}:
                		(Shift_Val==5) ? {{5{Shift_In[15]}},Shift_In[15:5]}:
			  	(Shift_Val==6) ? {{6{Shift_In[15]}},Shift_In[15:6]}:
			  	(Shift_Val==7) ? {{7{Shift_In[15]}},Shift_In[15:7]}:
				(Shift_Val==8) ? {{8{Shift_In[15]}},Shift_In[15:8]}:
				(Shift_Val==9) ? {{9{Shift_In[15]}},Shift_In[15:9]}:
				(Shift_Val==10) ? {{10{Shift_In[15]}},Shift_In[15:10]}:
				(Shift_Val==11) ? {{11{Shift_In[15]}},Shift_In[15:11]}:
				(Shift_Val==12) ? {{12{Shift_In[15]}},Shift_In[15:12]}:
				(Shift_Val==13) ? {{13{Shift_In[15]}},Shift_In[15:13]}:
				(Shift_Val==14) ? {{14{Shift_In[15]}},Shift_In[15:14]}:
				(Shift_Val==15) ? {{15{Shift_In[15]}},Shift_In[15]}:
				Shift_In;

assign left = 			(Shift_Val==1) ? {Shift_In[14:0],1'b0}:
			  	(Shift_Val==2) ? {Shift_In[13:0],2'b0}:
			 	(Shift_Val==3) ? {Shift_In[12:0],3'b0}:
			  	(Shift_Val==4) ? {Shift_In[11:0],4'b0}:
                		(Shift_Val==5) ? {Shift_In[10:0],5'b0}:
			  	(Shift_Val==6) ? {Shift_In[9:0],6'b0}:
			  	(Shift_Val==7) ? {Shift_In[8:0],7'b0}:
				(Shift_Val==8) ? {Shift_In[7:0],8'b0}:
				(Shift_Val==9) ? {Shift_In[6:0],9'b0}:
				(Shift_Val==10) ? {Shift_In[5:0],10'b0}:
				(Shift_Val==11) ? {Shift_In[4:0],11'b0}:
				(Shift_Val==12) ? {Shift_In[3:0],12'b0}:
				(Shift_Val==13) ? {Shift_In[2:0],13'b0}:
				(Shift_Val==14) ? {Shift_In[1:0],14'b0}:
				(Shift_Val==15) ? {Shift_In[0],15'b0}:
				Shift_In;


assign Shift_Out = (Mode) ? right : left; 

endmodule