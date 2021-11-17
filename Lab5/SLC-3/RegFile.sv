module RegFile (	input Clk, Reset, LD_REG,
						input DRMUX, SR1MUX,
						input [15:0] IR_in, Data_in,
						output logic [15:0] SR1_out, SR2_out);
	logic [7:0] Load;
	logic [15:0] Reg_Out [7:0];
	
	Reg_16 Reg[7:0] (.*, .Data_out(Reg_Out));
	
	logic [2:0] SR1, SR2, DR;
	assign SR2 = IR_in[2:0];
	
	always_comb begin
		if (SR1MUX)
			SR1 = IR_in[8:6];
		else
			SR1 = IR_in[11:9];
		
		if (DRMUX)
			DR = 3'b111;
		else
			DR = IR_in[11:9];
			
		unique case (SR1)
			3'b000	: 	SR1_out = Reg_Out[0];
			3'b001	: 	SR1_out = Reg_Out[1];
			3'b010	: 	SR1_out = Reg_Out[2];
			3'b011	: 	SR1_out = Reg_Out[3];
			3'b100	: 	SR1_out = Reg_Out[4];
			3'b101	: 	SR1_out = Reg_Out[5];
			3'b110	: 	SR1_out = Reg_Out[6];
			3'b111	: 	SR1_out = Reg_Out[7];
		endcase
		
		unique case (SR2)
			3'b000	: 	SR2_out = Reg_Out[0];
			3'b001	: 	SR2_out = Reg_Out[1];
			3'b010	: 	SR2_out = Reg_Out[2];
			3'b011	: 	SR2_out = Reg_Out[3];
			3'b100	: 	SR2_out = Reg_Out[4];
			3'b101	: 	SR2_out = Reg_Out[5];
			3'b110	: 	SR2_out = Reg_Out[6];
			3'b111	: 	SR2_out = Reg_Out[7];
		endcase
		
		if (LD_REG) 
			begin
				unique case (DR)
					3'b000	: 	Load = 8'h01;
					3'b001	: 	Load = 8'h02;
					3'b010	: 	Load = 8'h04;
					3'b011	: 	Load = 8'h08;
					3'b100	: 	Load = 8'h10;
					3'b101	: 	Load = 8'h20;
					3'b110	: 	Load = 8'h40;
					3'b111	: 	Load = 8'h80;		
				endcase
			end
		else	
			Load = 8'h00;
	end
endmodule
			