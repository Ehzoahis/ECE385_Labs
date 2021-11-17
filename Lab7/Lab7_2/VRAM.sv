module VRAM ( 	input clock,
					input pixel_clk,
					input	[10:0] readout_addr,
					input [10:0] AVL_ADDR,
					input	[31:0] DATAWRITE,
					input	AVL_WREN,
					input AVL_REN,
					input [3:0] AVL_BYTE_EN,
					output [31:0] DATAREAD,
					output [31:0] readout_data
);

mem2 mem0 (.clock_a(pixel_clk), .address_a(readout_addr), .data_a(), .q_a(readout_data), .wren_a(1'b0), .rden_a(1'b1),
			 .clock_b(clock), .address_b(AVL_ADDR), .byteena_b(AVL_BYTE_EN), .data_b(DATAWRITE), .q_b(DATAREAD), .wren_b(AVL_WREN), .rden_b(AVL_REN));
				
endmodule
