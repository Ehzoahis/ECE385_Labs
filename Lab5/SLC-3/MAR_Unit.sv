module MAR_Unit (	input Clk, LD_MAR, Reset,
					input [15:0] MAR_In,
					output [15:0] MAR_Out);
	
	Reg_16 MAR_reg	(.*, .Load(LD_MAR), .Data_in(MAR_In), .Data_out(MAR_Out));
	
endmodule
