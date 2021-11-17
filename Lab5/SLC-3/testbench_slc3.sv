module testbench_slc3();

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
//	Run = 0;
//	Continue = 0;
//	SW = 16'h0003;
//	#2 Continue = 1;
//	#2 Run = 1;
//	#50 SW = 16'h000f;	
//	#50 SW = 16'h00f0;
//	
//	Run = 0;
//	Continue = 0;
//	SW = 16'h0006;
//	#2 Continue = 1;
//	#2 Run = 1;
//	#60 SW = 16'h00f0;
//	#2 Continue = 0;
//	#2 Continue = 1;
//	#60 SW = 16'h000f;
//	#2 Continue = 0;
//	#2 Continue = 1;
//	
//	Run = 0;
//	Continue = 0;
//	SW = 16'h000b;
//	#2 Continue = 1;
//	#2 Run = 1;
//	#80 SW = 16'h000f;
//	#2 Continue = 0;
//	#2 Continue = 1;
//	#80 SW = 16'h00f0;
//	#2 Continue = 0;
//	#2 Continue = 1;
//	
//	Run = 0;
//	Continue = 0;
//	SW = 16'h0014;
//	#2 Continue = 1;
//	#2 Run = 1;
//	#100 SW = 16'h000c;
//	#2 Continue = 0;
//	#2 Continue = 1;
//	#100 SW = 16'h000a;
//	#2 Continue = 0;
//	#2 Continue = 1;

//	Run = 0;
//	Continue = 0;
//	SW = 16'h0031;
//	#2 Continue = 1;
//	#2 Run = 1;
//	#200 SW = 16'h0003;
//	#2 Continue = 0;
//	#2 Continue = 1;
//	#200 SW = 16'h0002;
//	#2 Continue = 0;
//	#2 Continue = 1;
	
	Run = 0;
	Continue = 0;
	SW = 16'h005a;
	#2 Continue = 1;
	#2 Run = 1;
	#200 SW = 16'h0003;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 SW = 16'h0002;
	#1000 SW = 16'h0003;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
	#100 Continue = 0;
	#100 Continue = 1;
end
endmodule
	