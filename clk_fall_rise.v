`timescale 1ns / 1ps

module clk(
	input clk,
	input rst,
	input [3:0] clksel,
	output reg clk_out,
	output clk_out_f,
	output clk_out_r
);

reg [2:0] cntr;

always @(posedge clk)
	begin
	if(rst)
		begin
			cntr <= 3'b0;
			clk_out <= 1'b0;
		end
	else
		cntr <= cntr + 3'b1;
	if(cntr == clksel-1)
		begin
		clk_out <= ~clk_out;
		cntr <= 3'b0;
		end
	end

assign clk_out_f = (cntr == clksel-1) && (clk_out == 1);
assign clk_out_r = (cntr == clksel-1) && (clk_out == 0);

endmodule
