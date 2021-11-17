module testbench();

timeunit 10ns;
			
timeprecision 1ns;

logic Clk = 0;
logic Reset_Clear, Run_Accumulate;
logic [9:0] SW;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

adder2 adder0(.*);

always begin : CLOCK_GENERATION
	#1 Clk = ~Clk;
end


initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_ADDERS
	Reset_Clear = 0;
	Run_Accumulate = 1;
	
	#2 Reset_Clear = 1;
	Run_Accumulate = 0;
	SW = 10'h9;

	#8 Run_Accumulate = 1;
	SW = 10'h1;
	#2 Run_Accumulate = 0;

	#8 Run_Accumulate = 1;
	SW = 10'h3FF;
	#2 Run_Accumulate = 0;
	
	#8 Run_Accumulate = 1;
	SW = 10'h3FF;
	#2 Run_Accumulate = 0;
	
	#8 Run_Accumulate = 1;
	SW = 10'h3FF;
	#2 Run_Accumulate = 0;
	
	#8 Run_Accumulate = 1;
	SW = 10'h3FF;
	#2 Run_Accumulate = 0;
	
	#8 Run_Accumulate = 1;
	Reset_Clear = 1;
	#2 Reset_Clear = 0;
	
end
endmodule
