`timescale 1ns / 1ps

module knight(
	input clk,
	input rst,
	output reg [7:0] led
);


reg [12:0] cntr;
reg dir;

always @(posedge clk)
	if(rst)
		begin
			led <= 8'b1;
			cntr <= 13'b0;
			dir <= 1'b1;
		end
	else if(en)
		begin
			cntr <= 13'b0;
			if(dir && led == 8'b01000000)
				dir <= 1'b0;
			else if(!dir && led == 8'b00000010)
				dir <= 1'b1;
			if(dir)
				led <= {led[6:0], led[7]};
			else
				led <= {led[0], led[7:1]};
		end
	else
		cntr <= cntr + 13'b1;

assign en = (cntr == 15);

endmodule
