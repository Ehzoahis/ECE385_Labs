module MDR_Unit (	input Clk, LD_MDR, Reset,
					input MIO_EN,
					input [15:0] Bus_In, MEM_In,
					output logic [15:0] MDR_Out);
					
	logic [15:0] MDR_In;
	
	Reg_16 MDR_reg (.*, .Load(LD_MDR), .Data_in(MDR_In), .Data_out(MDR_Out));
	
	always_comb begin
		if (MIO_EN)
			MDR_In = MEM_In;
		else
			MDR_In = Bus_In;
	end
endmodule
