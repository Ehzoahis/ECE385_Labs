// Code from Lab3 by Haozhe Si

module FullAdder (
	input 			A, B,
	input 			cin,
	output logic 	S,
	output logic 	cout
);

	assign S = A ^ B ^ cin;
	assign cout = (A & B) | (B & cin) | (cin & A);

endmodule 



module ripple_adder
(
	input  [8:0] A, B,
	input         cin,
	output logic [8:0] S,
	output logic        cout
);

	logic [7:0] carriers;
	
	FullAdder RA_9b [8:0] (
		.A(A), .B(B), .cin({carriers, cin}), 
		.S(S), .cout({cout, carriers})
	);
		
		
endmodule


module PMAdder
(
	input  [8:0] A, B,
	input        add, sub,
	output logic [8:0] S,
	output logic  		cout
);
	
	logic cin;
	logic [8:0] A_tmp, B_tmp;
	assign A_tmp = A;
	
	ripple_adder pmadder(.A(A_tmp), .B(B_tmp), .*);
	
	always_comb begin
		if (sub) 
			begin
				cin = 1'b1;
				B_tmp = ~B;
			end
		else if (add)
			begin
					cin = 1'b0;
					B_tmp = B;
			end
		else
			begin
				cin = 1'b0;
				B_tmp = 9'h0;
			end
	end
	
endmodule
