module testbench_fetch();

timeunit 10ns;	

timeprecision 1ns;

logic [9:0] SW;
logic Clk, Run, Continue;
logic [9:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;

slc3_testtop test (.*);

always begin : CLOCK_GENERATION
	#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_FETCH
	Run = 0;
	Continue = 0;
	SW = 16'h00F0;
	#2 Continue = 1;
	#2 Run = 1;
	
	#10 Continue = 0;
	#2 Continue = 1;
	
end
endmodule
	