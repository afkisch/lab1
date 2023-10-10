module uart(
	input clk, rst,
	input [3:0] bcd0, bcd1,
	output tx_out
);

// BCD-ASCII atvaltas
wire [6:0] ascii0 = bcd0 + 7'b0110000;
wire [6:0] ascii1 = bcd1 + 7'b0110000;

// Paritasbit + kocsi vissza
wire [7:0] eol = 8'b10001101;

// Paritasbitek szamitasa
wire par0 = bcd0[0] + bcd0[1] + bcd0[2] + bcd0[3];
wire par1 = bcd1[0] + bcd1[1] + bcd1[2] + bcd1[3];

// Start- es stopbit
wire start = 1'b0;
wire stop = 1'b1;


/* --- Shiftregiszter es szamlalo (tx_cntr) --- */

reg [4:0] tx_cntr;
reg [29:0] shr;

always @ (posedge clk)
	if(rst || (tx_en && tx_cntr == 5'b11101))
		begin
			shr <= {stop, eol, start, stop, par0, ascii0, start, stop, par1, ascii1, start}; // Adatsor betoltese a regiszterbe
			tx_cntr <= 5'b0;
		end
	else if(tx_en)
		begin
			shr <= {1'b0, shr[29:1]}; // Jobbra shifteles 1 Bittel
			tx_cntr <= tx_cntr + 1'b1;
		end

assign tx_out = shr[0];


/* --- Baud Rate generator (tx_en) --- */

reg [9:0] tcy;

always @ (posedge clk)
	if(rst || tx_en)
		tcy <= 9'b0;
	else
		tcy <= tcy + 1'b1;

assign tx_en = (tcy == 9'b000000100); // Teszteleshez; egyebkent b110100000

endmodule
