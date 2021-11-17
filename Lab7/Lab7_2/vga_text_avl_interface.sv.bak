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
`define NUM_REGS 601 //80*30 characters / 4 characters per register
`define CTRL_REG 600 //index of control register

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
	input  logic [9:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

logic [31:0] LOCAL_REG       [`NUM_REGS]; // Registers
//put other local variables here
logic [9:0] DrawX, DrawY;
logic pixel_clk, blank, sync;
logic [10:0] font_addr; // font_addr = code * [0-15]
logic [7:0] data;


//Declare submodules..e.g. VGA controller, ROMS, etc
vga_controller vga0 (.Clk(CLK), .Reset(RESET), .pixel_clk(pixel_clk), .blank(blank), .sync(sync), .hs(hs), .vs(vs), .DrawX(DrawX), .DrawY(DrawY)); 
font_rom fonts (.addr(font_addr), .data(data));
   
// Read and write from AVL interface to register block, note that READ waitstate = 1, so this should be in always_ff
always_ff @ (posedge CLK) begin
	if (RESET)
		LOCAL_REG <= '{default:32'b0};

	else if (AVL_CS) begin
		if (AVL_READ) AVL_READDATA <= LOCAL_REG[AVL_ADDR];
		
		else if (AVL_WRITE) begin
			unique case (AVL_BYTE_EN)
				4'b1111	:	LOCAL_REG[AVL_ADDR] <= AVL_WRITEDATA;
				4'b1100	:	LOCAL_REG[AVL_ADDR][31:16] <= AVL_WRITEDATA[31:16];
				4'b0011	:	LOCAL_REG[AVL_ADDR][15:0] <= AVL_WRITEDATA[15:0];
				4'b1000	:	LOCAL_REG[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
				4'b0100	:	LOCAL_REG[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
				4'b0010	:	LOCAL_REG[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];
				4'b0001	:	LOCAL_REG[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];
				default	: ;
			endcase 
		end
	end
end

logic [9:0] xchunk, ychunk;
logic [2:0] xoffset;
logic [3:0] yoffset;
logic [11:0] chunkidx;
logic [9:0] vramidx;
logic [1:0] vramoffset;
logic [7:0] fontcode;

logic pixel, inv;
//handle drawing (may either be combinational or sequential - or both).
always_comb begin
	xoffset = DrawX[2:0];
	yoffset = DrawY[3:0];
	xchunk = DrawX >> 3;
	ychunk = DrawY >> 4;
	chunkidx = ychunk * 80 + xchunk;

	vramoffset = chunkidx[1:0];
	vramidx = chunkidx >> 2;
	unique case (vramoffset)
		2'b00	: fontcode = LOCAL_REG[vramidx][7:0];
		2'b01	: fontcode = LOCAL_REG[vramidx][15:8];
		2'b10	: fontcode = LOCAL_REG[vramidx][23:16];
		2'b11	: fontcode = LOCAL_REG[vramidx][31:24];
	endcase
	font_addr = fontcode[6:0] * 16 + yoffset;

	pixel = data[3'b111-xoffset];
	inv = fontcode[7];
end

always_ff @ (posedge pixel_clk) begin
	if (~blank) begin
		red <= 4'h0;
		green <= 4'h0;
		blue <= 4'h0;
	end
	else begin
		if (pixel ^ inv)	begin
			red <= LOCAL_REG[`CTRL_REG][24:21];
			green <= LOCAL_REG[`CTRL_REG][20:17];
			blue <= LOCAL_REG[`CTRL_REG][16:13];
		end
		else begin
			red <= LOCAL_REG[`CTRL_REG][12:9];
			green <= LOCAL_REG[`CTRL_REG][8:5];
			blue <= LOCAL_REG[`CTRL_REG][4:1];
		end
	end
end

endmodule
