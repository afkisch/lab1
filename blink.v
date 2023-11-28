`timescale 1ns / 1ps

/*A hálózat adott ütemben villogó 8 darab LED-t valósít meg, amelynek az ütemezését a SW1 és
SW0 kapcsoló állása határozza meg. A LED-ek {SW1, SW0}==0 esetben 0,25 mp-enként, {SW1, SW0}==1
esetben 0,5 mp-enként, {SW1, SW0}==2 esetben 1 mp-enként, {SW1, SW0}==3 esetben pedig 2 mp-enként
váltanak állapotot (mind a 8 LED egyszerre). A hálózat órajele az FPGA panel 16 MHz-es órajele.*/

module blink(
	input clk,
	input rst,
	input [1:0] sw,
	output reg [7:0] led
);
  
reg [13:0] cntr;
reg [13:0] cmp;

always @(posedge clk)
	if(rst)
		begin
			cntr <= 14'b0;
			led <= 8'b1;
		end
	else if(en)
		begin
			cntr <= 13'b0;
			led <= {led[6:0], led[7]};
		end
	else
		cntr <= cntr + 13'b1;

always @(posedge clk)
	case (sw)
		2'b0: cmp <= 3999999;
		2'b1: cmp <= 7999999;
		2'b10: cmp <= 15999999;
		2'b11: cmp <= 31999999;
	endcase
	
assign en = (cntr == cmp);

endmodule
