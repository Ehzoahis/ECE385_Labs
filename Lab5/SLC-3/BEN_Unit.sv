module BEN_Unit	(	input [15:0] Bus_In, IR,
							input Clk, Reset, LD_CC, LD_BEN,
							output logic BEN_Out);
	
	logic [2:0] nzp, nzp_out;
	logic	BEN;
	
	Flipflop	NZP_ff[2:0] (.*, .Load(LD_CC), .Data_in(nzp), .Data_out(nzp_out));
	Flipflop BEN_ff (.*, .Load(LD_BEN), .Data_in(BEN), .Data_out(BEN_Out));
	
	always_comb begin
		if (Bus_In[15] == 1'b1)
			nzp = 3'b100;
		else if (Bus_In == 16'h0000)
			nzp = 3'b010;
		else
			nzp = 3'b001;
			
		BEN = (nzp_out[0]&IR[9])|(nzp_out[1]&IR[10])|(nzp_out[2]&IR[11]);
		
	end
endmodule
