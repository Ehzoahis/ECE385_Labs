module control (	input Clk, Reset, Run,
						input M,
						output logic shift, add, sub, clrA);
						
	enum logic [4:0] {A, B, C, D, E, F, G, H, I, J, K, L, MM, N, O, P, Q, R} curr_state, next_state;
	
	always_ff @ (posedge Clk) begin
		if (Reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	always_comb begin
		next_state = curr_state;
		
		unique case (curr_state)
			A: 	if (Run) 
						next_state = B;
			B:		next_state = C;
			C:		next_state = D;
			D:		next_state = E;
			E:		next_state = F;
			F:		next_state = G;
			G:		next_state = H;
			H:		next_state = I;
			I:		next_state = J;
			J:		next_state = K;
			K:		next_state = L;
			L:		next_state = MM;
			MM:	next_state = N;
			N:		next_state = O;
			O:		next_state = P;
			P:		next_state = Q;
			Q:		next_state = R;
			R:		if (~Run)
						next_state = A;
		endcase
	end

	always_comb begin
		case (curr_state)
			B:		
					begin
						shift = 1'b0;
						if (M)
							add = 1'b1;
						else
							add = 1'b0;
						sub = 1'b0;
					end
			C:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			D:		
					begin
						shift = 1'b0;
						if (M)
							add = 1'b1;
						else
							add = 1'b0;
						sub = 1'b0;
					end
			E:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			F:		
					begin
						shift = 1'b0;
						if (M)
							add = 1'b1;
						else
							add = 1'b0;
						sub = 1'b0;
					end
			G:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			H:		
					begin
						shift = 1'b0;
						if (M)
							add = 1'b1;
						else
							add = 1'b0;
						sub = 1'b0;
					end
			I:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			J:		
					begin
						shift = 1'b0;
						if (M)
							add = 1'b1;
						else
							add = 1'b0;
						sub = 1'b0;
					end
			K:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			L:		
					begin
						shift = 1'b0;
						if (M)
							add = 1'b1;
						else
							add = 1'b0;
						sub = 1'b0;
					end
			MM:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			N:		
					begin
						shift = 1'b0;
						if (M)
							add = 1'b1;
						else
							add = 1'b0;
						sub = 1'b0;
					end
			O:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			P:		
					begin
						shift = 1'b0;
						add = 1'b0;
						if (M)
							sub = 1'b1;
						else
							sub = 1'b0;
					end
			Q:
					begin
						shift = 1'b1;
						add = 1'b0;
						sub = 1'b0;
					end
			default:
					begin
						shift = 1'b0;
						add = 1'b0;
						sub = 1'b0;
					end
		endcase
		
		if (curr_state==A & (Reset | Run))
			clrA = 1'b1;
		else
			clrA = 1'b0;
		
	end
	
endmodule
