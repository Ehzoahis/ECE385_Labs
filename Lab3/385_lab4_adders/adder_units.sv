module FullAdder (
	input 			A, B,
	input 			cin,
	output logic 	S,
	output logic 	cout
);

	assign S = A ^ B ^ cin;
	assign cout = (A & B) | (B & cin) | (cin & A);

endmodule 



module CLAdder (
	input 			A, B,
	input 			cin,
	output logic 	S,
	output logic	G, P
);

	assign S = A ^ B ^ cin;
	assign G = A & B;
	assign P = A ^ B;

endmodule 



module CLUnit_4b (
	input	[3:0] P, G,
	input 		cin,
	output logic [3:0] carriers,
	output PG, GG
);

	assign carriers[0] = cin & P[0] | G[0];
	assign carriers[1] = cin & P[0] & P[1] | G[0] & P[1] | G[1];
	assign carriers[2] = cin & P[0] & P[1] & P[2] | G[0] & P[1] & P[2] | G[1] & P[2] | G[2];
	assign carriers[3] = cin & P[0] & P[1] & P[2] & P[3] | G[0] & P[1] & P[2] & P[3] | G[1] & P[2] & P[3] | G[2] & P[3] | G[3];
	
	assign PG = P[0] & P[1] & P[2] & P[3];
	assign GG = G[0] & P[1] & P[2] & P[3] | G[1] & P[2] & P[3] | G[2] & P[3] | G[3];

endmodule
	


module CLAdder_4b (
	input  [3:0] A, B,
	input        cin,
	output logic [3:0] 	S,
	output logic 			PG, GG
);

	logic [3:0] P, G;
	logic [3:0] carriers;

	CLUnit_4b clu_4b (.*);

	CLAdder adder_4b [3:0] (
		.A(A), .B(B), .cin({carriers[2:0], cin}), 
		.S(S), .P(P), .G(G)
	);

endmodule



module RAdder_4b (
	input  [3:0] A, B,
	input         cin,
	output logic [3:0] S,
	output logic       cout
);
	logic [2:0] carriers;
	
	FullAdder RA_4b [3:0] (
		.A(A), .B(B), .cin({carriers, cin}), 
		.S(S), .cout({cout, carriers})
	);
	
		
endmodule



module CSAdder_4b (
	input  [3:0] A, B,
	input         cin,
	output logic [3:0] S,
	output logic       cout
);

	logic [3:0] S0, S1;
	logic			cout0, cout1;
	
	RAdder_4b Radder0 (.*, .cin(1'b0), .S(S0), .cout(cout0));
	RAdder_4b Radder1 (.*, .cin(1'b1), .S(S1), .cout(cout1));
	
	assign cout = (cin & cout1) | cout0;
	always_comb 
	begin
		case (cin)
			1'b0: S = S0;
			1'b1: S = S1;
		endcase
	end
endmodule
	
	
	
	
	

