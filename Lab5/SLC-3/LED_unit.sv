module LED_Unit	( 	input LD_LED,
							input [15:0] IR,
							output logic [9:0] LED);
	
	always_comb begin
		if (LD_LED)
			LED = IR[9:0];
		else
			LED = 10'h000;
	end
endmodule
