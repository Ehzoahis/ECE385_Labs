module Reg_16 (	input Clk, Reset, Load,
						input [15:0] Data_in,
						output logic [15:0] Data_out	);
	
	always_ff @ (posedge Clk) begin
		if (Reset)
			Data_out <= 16'b0;
		else if (Load)
			Data_out <= Data_in;
	end

endmodule

module Flipflop (	input Clk, Reset, Load,
						input Data_in,
						output logic Data_out	);
	
	always_ff @ (posedge Clk) begin
		if (Reset)
			Data_out <= 1'b0;
		else if (Load)
			Data_out <= Data_in;
	end

endmodule
