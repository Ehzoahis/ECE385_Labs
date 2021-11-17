module testbench();

timeunit 10ns;
			
timeprecision 1ns;

logic Clk = 0;
logic Reset_Load_Clear, Run;
logic [7:0] SW;
logic [7:0] Aval, Bval;
logic Xval;
logic [6:0] HEX0, HEX1, HEX2, HEX3;

logic [16:0] ans;

integer ErrorCnt = 0;

Multiplier_8b multiplier(.*);

always begin : CLOCK_GENERATION
	#1 Clk = ~Clk;
end


initial begin: CLOCK_INITIALIZATION
    Clk = 1;
end 

initial begin: TEST
	Run = 1;
	Reset_Load_Clear = 0;
	SW = 8'h1;
	#2 Reset_Load_Clear = 1;
	SW = 8'h1;
	Run = 0;
	#2 Run = 1;
	
	#40 Reset_Load_Clear = 0;
	SW = 8'h1;
	#2 Reset_Load_Clear = 1;
	SW = -8'h1;
	Run = 0;
	#2 Run = 1;

	#40 Reset_Load_Clear = 0;
	SW = -8'h1;
	#2 Reset_Load_Clear = 1;
   SW = -8'h1;
	Run = 0;
	#2 Run = 1;

	#40 Reset_Load_Clear = 0;
	SW = 8'h1;
	#2 Reset_Load_Clear = 1;
   SW = -8'h1;
	Run = 0;
	#2 Run = 1;

end

endmodule
