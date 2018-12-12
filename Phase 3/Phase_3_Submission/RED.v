module RED_16bit (
    input [15:0]a,
    input [15:0]b,
    output [15:0]sum
    );
    

    wire [8:0]suma;
    wire ca;
    wire ca1;

    wire [8:0]sumb;
    wire cb;
    wire cb1;

    wire cab30;
    wire cab74;

    wire [3:0]temp;

    // sum a
    CLA_4bit U_CLA4_00(.Sum(suma[3:0]), .Cout(ca), .Prop_Val(), .Gen_Val(), .A(a[3:0]), .B(a[11:8]), .Cin(1'b0)); 

    CLA_4bit U_CLA4_01(.Sum(suma[7:4]), .Cout(ca1), .Prop_Val(), .Gen_Val(), .A(a[7:4]), .B(a[15:12]), .Cin(ca)); 

    assign suma[8] = a[7] ^ a[15] ^ ca1;

    // sum b
	CLA_4bit U_CLA4_02(.Sum(sumb[3:0]), .Cout(cb), .Prop_Val(), .Gen_Val(), .A(b[3:0]), .B(b[11:8]), .Cin(ca)); 
	
	CLA_4bit U_CLA4_03(.Sum(sumb[7:4]), .Cout(cb1), .Prop_Val(), .Gen_Val(), .A(b[7:4]), .B(b[15:12]), .Cin(cb)); 

    assign sumb[8] = b[7] ^ b[15] ^ cb1;

    // suma + sumb
	CLA_4bit U_CLA4_10(.Sum(sum[3:0]), .Cout(cab30), .Prop_Val(), .Gen_Val(), .A(suma[3:0]), .B(sumb[3:0]), .Cin(1'b0)); 
	
	CLA_4bit U_CLA4_11(.Sum(sum[7:4]), .Cout(cab74), .Prop_Val(), .Gen_Val(), .A(suma[7:4]), .B(sumb[7:4]), .Cin(cab30)); 

	CLA_4bit U_CLA4_12(.Sum(temp), .Cout(), .Prop_Val(), .Gen_Val(), .A({4{suma[8]}}), .B({4{sumb[8]}}), .Cin(cab74)); 

    assign sum[8] = temp[0];
    assign sum[15:9] = {7{temp[1]}};

endmodule
