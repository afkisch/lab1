/* Orajelosztas es a leoszott orajel felfuto, lefuto elenek jelzese*/
`timescale 1ns / 1ps

module clk_div(
	input clk, rst, freq,
	output reg clk_out,
	output clk_out_r,
	output clk_out_f
);

reg [2:0] cntr;
wire [1:0] cmp;

always @(posedge clk)
	if(rst)
		begin
			cntr <= 3'b0;
			clk_out <= 1'b0;
		end
	else if(cntr == cmp)
		begin
			clk_out <= ~clk_out;
			cntr <= 3'b0;
		end
	else
		cntr <= cntr + 1'b1;

assign cmp = (freq == 0) ? 2'b01 : 2'b11;
assign clk_out_r = (cntr == cmp) && (clk_out == 0);
assign clk_out_f = (cntr == cmp) && (clk_out == 1);

endmodule
