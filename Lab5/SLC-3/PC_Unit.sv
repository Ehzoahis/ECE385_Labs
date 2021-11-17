module PC_Unit (	input Clk, LD_PC, Reset,
						input [1:0] Sel_PC,
						input [15:0] Bus_In, Addr_In,
						output logic [15:0] PC_Out);
						
	logic [15:0] PC_In;
						
	Reg_16 PC_Reg (.*, .Load(LD_PC), .Data_in(PC_In), .Data_out(PC_Out));
	
	always_comb begin
		unique case (Sel_PC)
			2'b00		:	PC_In = PC_Out + 1;
			2'b01		:	PC_In = Addr_In;
			2'b10		:	PC_In = Bus_In;
			default	:	PC_In = PC_Out;
		endcase
	end
endmodule
			