module select_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);

    /* TODO
     *
     * Insert code here to implement a CSA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  logic [2:0] carriers;
	  
	  RAdder_4b CSAdder0 (.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(S[3:0]), .cout(carriers[0]));
	  
	  CSAdder_4b CSAdder1 (.A(A[7:4]), .B(B[7:4]), .cin(carriers[0]), .S(S[7:4]), .cout(carriers[1]));
	  CSAdder_4b CSAdder2 (.A(A[11:8]), .B(B[11:8]), .cin(carriers[1]), .S(S[11:8]), .cout(carriers[2]));
	  CSAdder_4b CSAdder3 (.A(A[15:12]), .B(B[15:12]), .cin(carriers[2]), .S(S[15:12]), .cout(cout));

endmodule
