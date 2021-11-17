module Multiplier_8b ( 	input Clk, Reset_Load_Clear, Run,
							input [7:0] SW,
							output logic [6:0] 	HEX0,
														HEX1,
														HEX2,
														HEX3,
							output logic [7:0]	Aval, Bval,
							output logic Xval	);
	logic RLC, run;
	assign RLC = ~Reset_Load_Clear;
	assign run = ~Run;
	
	logic shift, add, sub, M, clrA, X;
	logic load, Aout;
	logic [7:0] partial_sum;
	
	assign load = add | sub;

	assign M = Bval[0];


	reg_8 RegA (.Clk(Clk), .Reset(clrA), .Shift_In(Xval), .Load(load), .Shift_En(shift), 
					.D(partial_sum), .Shift_Out(Aout), .Data_Out(Aval));
	reg_8 RegB (.Clk(Clk), .Reset(), .Shift_In(Aout), .Load(RLC), .Shift_En(shift), 
					.D(SW), .Shift_Out(), .Data_Out(Bval));
	reg_1 RegX (.Clk(Clk), .Reset(clrA), .Shift_In(X), .Load(load), 
					.Shift_Out(Xval));
					
	control Control (.Reset(RLC), .Run(run), .*);
	
	PMAdder adder (.A({Aval[7], Aval}), .B({SW[7], SW}), .add(add), .sub(sub), .S({X, partial_sum}), .cout());
	
	HexDriver        HexAL(
                        .In0(Aval[3:0]),
                        .Out0(HEX2) );
	HexDriver        HexBL (
                        .In0(Bval[3:0]),
                        .Out0(HEX0) );
								
	HexDriver        HexAU (
                        .In0(Aval[7:4]),
                        .Out0(HEX3) );	
	HexDriver        HexBU (
                       .In0(Bval[7:4]),
                       .Out0(HEX1) );
endmodule
