`timescale 1ns / 1ps

module tb_uart;

	// Inputs
	reg clk;
	reg rst;
	reg [3:0] bcd0;
	reg [3:0] bcd1;

	// Outputs
	wire tx_out;

	// Instantiate the Unit Under Test (UUT)
	uart uut (
		.clk(clk), 
		.rst(rst), 
		.bcd0(bcd0), 
		.bcd1(bcd1), 
		.tx_out(tx_out)
	);

	initial begin
		// Initialize Inputs
		clk <= 0;
		rst <= 0;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst <= 0;
		#1;
		rst <= 1;
		bcd0 <= 7;
		bcd1 <= 0;
		#1;
		rst <= 0;
		#290;
		bcd0 <= 5;
		bcd1 <= 1;
		
		
	end
	
	always #1 clk <= ~clk;
      
endmodule
