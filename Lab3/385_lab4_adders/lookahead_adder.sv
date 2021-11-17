module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output logic [15:0] S,
	output logic        cout
);
    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	logic [3:0] PG, GG;
	logic [3:0] carriers;
	  
	CLUnit_4b clu_4b (.P(PG), .G(GG), .carriers(carriers), .PG(), .GG());

	CLAdder_4b CLAdder0 (.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(S[3:0]), .PG(PG[0]), .GG(GG[0]));
	CLAdder_4b CLAdder1 (.A(A[7:4]), .B(B[7:4]), .cin(carriers[0]), .S(S[7:4]), .PG(PG[1]), .GG(GG[1]));
	CLAdder_4b CLAdder2 (.A(A[11:8]), .B(B[11:8]), .cin(carriers[1]), .S(S[11:8]), .PG(PG[2]), .GG(GG[2]));
	CLAdder_4b CLAdder3 (.A(A[15:12]), .B(B[15:12]), .cin(carriers[2]), .S(S[15:12]), .PG(PG[3]), .GG(GG[3]));
	
	assign cout = carriers[3];

endmodule
