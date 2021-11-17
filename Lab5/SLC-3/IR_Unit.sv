module IR_Unit (	input Clk, LD_IR, Reset,
				input [15:0] IR_In,
				output [15:0] IR_Out);
	
	Reg_16 IR_reg	(.*, .Load(LD_IR), .Data_in(IR_In), .Data_out(IR_Out));
	
endmodule
