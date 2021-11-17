/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

logic [31:0] Palette       [8]; // Palelttes
logic [10:0] vram_addr;
logic	[31:0] readout_buffer;
logic [31:0] mem_readout, buffer_readout;
logic mem_write, mem_read;
assign mem_write = AVL_WRITE & ~AVL_ADDR[11] & AVL_CS;
assign mem_read = AVL_READ & AVL_CS & ~AVL_ADDR[11];

VRAM vram (.clock(CLK), .pixel_clk(pixel_clk), .readout_addr(vram_addr), .AVL_ADDR(AVL_ADDR[10:0]), 
				.DATAWRITE(AVL_WRITEDATA), .AVL_WREN(mem_write), .AVL_REN(mem_read), .AVL_BYTE_EN(AVL_BYTE_EN), 
				 .DATAREAD(mem_readout), .readout_data(readout_buffer));

always_ff @ (posedge CLK) begin
	if (RESET)
		Palette <= '{default:32'b0};

	else if (AVL_CS) begin
		if (AVL_READ & AVL_ADDR[11])
			buffer_readout <= Palette[AVL_ADDR[2:0]];
	
		else if (AVL_WRITE & AVL_ADDR[11]) begin
			unique case (AVL_BYTE_EN)
				4'b1111	:	Palette[AVL_ADDR[2:0]] <= AVL_WRITEDATA;
				4'b1100	:	Palette[AVL_ADDR[2:0]][31:16] <= AVL_WRITEDATA[31:16];
				4'b0011	:	Palette[AVL_ADDR[2:0]][15:0] <= AVL_WRITEDATA[15:0];
				4'b1000	:	Palette[AVL_ADDR[2:0]][31:24] <= AVL_WRITEDATA[31:24];
				4'b0100	:	Palette[AVL_ADDR[2:0]][23:16] <= AVL_WRITEDATA[23:16];
				4'b0010	:	Palette[AVL_ADDR[2:0]][15:8] <= AVL_WRITEDATA[15:8];
				4'b0001	:	Palette[AVL_ADDR[2:0]][7:0] <= AVL_WRITEDATA[7:0];
				default	: ;
			endcase 
		end
	end
end
				 
always_comb begin
	if (AVL_CS & AVL_READ) begin
		if (mem_read)
			AVL_READDATA = mem_readout;
		else
			AVL_READDATA = buffer_readout;
	end
	else 
		AVL_READDATA = 32'hX;
end				 

//put other local variables here
logic [9:0] DrawX, DrawY;
logic pixel_clk, blank, sync;
logic [10:0] font_addr; // font_addr = code * [0-15]
logic [7:0] data;

//Declare submodules..e.g. VGA controller, ROMS, etc
vga_controller vga0 (.Clk(CLK), .Reset(RESET), .pixel_clk(pixel_clk), .blank(blank), .sync(sync), .hs(hs), .vs(vs), .DrawX(DrawX), .DrawY(DrawY)); 
font_rom fonts (.addr(font_addr), .data(data));

// Read and write from AVL interface to register block, note that READ waitstate = 1, so this should be in always_ff

logic [9:0] xchunk, ychunk;
logic [2:0] xoffset;
logic [3:0] yoffset;
logic [11:0] chunkidx;
//logic [9:0] vramidx;
logic [1:0] vramoffset;
logic [7:0] fontcode, fontcolor;

logic pixel, inv;
logic [9:0] delayed_offset1, delayed_xoffset1, delayed_yoffset1;
//logic [9:0] delayed_offset2, delayed_xoffset2, delayed_yoffset2;
logic [3:0] front_R, front_G, front_B;
logic [3:0] back_R, back_G, back_B;
//enum logic [1:0] {setaddr, waitclock, read}
//handle drawing (may either be combinational or sequential - or both).
always_comb begin
	xchunk = DrawX >> 3;
	ychunk = DrawY >> 4;
	chunkidx = ychunk * 80 + xchunk;
end

always_ff @ (posedge pixel_clk) begin
	vram_addr <= chunkidx >> 1;
	
	delayed_offset1 <= chunkidx[0];
//	delayed_offset2 <= delayed_offset1;
	vramoffset <= delayed_offset1;
	
	delayed_xoffset1 <= DrawX[2:0];
	delayed_yoffset1 <= DrawY[3:0];
	
	xoffset <= delayed_xoffset1;
//	delayed_xoffset2 <= delayed_xoffset1;
	yoffset <= delayed_yoffset1;
//	delayed_yoffset2 <= delayed_yoffset1;
end

always_comb begin
	unique case (vramoffset)
		1'b0	: 
			begin
				fontcolor = readout_buffer[7:0];
				fontcode = readout_buffer[15:8];
			end
		1'b1	: 
			begin
				fontcolor = readout_buffer[23:16];
				fontcode = readout_buffer[31:24];
			end
	endcase
	font_addr = fontcode[6:0] * 16 + yoffset;

	pixel = data[3'b111 - xoffset];
	inv = fontcode[7];
	if (fontcolor[4]) begin
		front_R = Palette[fontcolor[7:5]][24:21];
		front_G = Palette[fontcolor[7:5]][20:17];
		front_B = Palette[fontcolor[7:5]][16:13];
	end
	else begin
		front_R = Palette[fontcolor[7:5]][12:9];
		front_G = Palette[fontcolor[7:5]][8:5];
		front_B = Palette[fontcolor[7:5]][4:1];
	end
	
	if (fontcolor[0]) begin
		back_R = Palette[fontcolor[3:1]][24:21];
		back_G = Palette[fontcolor[3:1]][20:17];
		back_B = Palette[fontcolor[3:1]][16:13];
	end
	else begin
		back_R = Palette[fontcolor[3:1]][12:9];
		back_G = Palette[fontcolor[3:1]][8:5];
		back_B = Palette[fontcolor[3:1]][4:1];
	end
end

always_ff @ (posedge pixel_clk) begin
	if (~blank) begin
		red <= 4'h0;
		green <= 4'h0;
		blue <= 4'h0;
	end
	else if (DrawX <= 1) begin
		red <= 4'h0;
		green <= 4'h0;
		blue <= 4'h0;
	end
	else begin
		if (pixel ^ inv)	begin
			red <= front_R;
			green <= front_G;
			blue <= front_B;
		end
		else begin
			red <= back_R;
			green <= back_G;
			blue <= back_B;
		end
	end
end

endmodule
