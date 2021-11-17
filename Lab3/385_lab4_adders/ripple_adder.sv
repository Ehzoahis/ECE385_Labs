module ripple_adder
(
	input  [15:0] A, B,
	input         cin,
	output logic [15:0] S,
	output logic        cout
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
		logic [14:0] carriers;
		
		FullAdder RA_16b [15:0] (
			.A(A), .B(B), .cin({carriers, cin}), 
			.S(S), .cout({cout, carriers})
		);
		
		
endmodule
