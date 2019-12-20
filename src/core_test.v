`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:48:03 11/08/2019
// Design Name:   core
// Module Name:   /home/kazumasita/fpga/risc-v/risc-v/core_test.v
// Project Name:  risc-v
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: core
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module core_test;

	// Inputs
	reg clk;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	core uut (
		.clk(clk), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	always #50 clk = ~clk;
endmodule

