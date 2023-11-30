`timescale 1ns / 1ps

module clk(
	input clk,
	input rst,
	output reg clk4,
	output reg clk8
);

reg [1:0] cntr4;
reg [3:0] cntr8;

always @(posedge clk)
	begin
	if(rst)
		begin
		cntr4 <= 2'b0;
		clk4 <= 1'b0;
		cntr8 <= 4'b0;
		clk8 <= 1'b0;
		end
	else
		begin
		cntr4 <= cntr4 + 2'b1;
		cntr8 <= cntr8 + 4'b1;
		end
		if(cntr8 == 7)
			clk8 <= ~clk8;
		if(cntr4 == 3)
			clk4 <= ~clk4;
	end
endmodule
