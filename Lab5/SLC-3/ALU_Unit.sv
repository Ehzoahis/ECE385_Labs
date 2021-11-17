module ALU_Unit	(	input [15:0] IR_In, SR2_In, SR1_In,
							input [1:0]	ALUK,
							input SR2MUX,
							output logic [15:0] ALU_Out);
			
	logic [15:0] B_In;
	
	always_comb begin
		if (SR2MUX)
			B_In = {{11{IR_In[4]}}, IR_In[4:0]};
		else
			B_In = SR2_In;
		
		unique case	(ALUK)
			2'b00		:	ALU_Out = SR1_In + B_In;
			2'b01		:	ALU_Out = SR1_In & B_In;
			2'b10		:	ALU_Out = ~SR1_In;
			2'b11		:	ALU_Out = SR1_In;
		endcase
	end
	
endmodule
