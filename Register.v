`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:28 11/08/2019 
// Design Name: 
// Module Name:    Register 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Register(readRegister1,readRegister2,writeRegister,writeData,readData1,readData2,clk,writeEnable);
	// input and output
	input [4:0] readRegister1,readRegister2,writeRegister;
	input [31:0] writeData;
	input writeEnable,clk;
	output [31:0] readData1,readData2;

	// 32 set of 32-bit registers
	reg [31:0] registers [31:0];
	
	// initialize memory to zero
	integer i;
	initial begin
		for(i=0;i<32;i=i+1)
			registers[i] = 0;
	end
	
	assign readData1 = registers[readRegister1];
	assign readData2 = registers[readRegister2];
	
	// write data to register on clk
	always @(posedge clk) begin
		if(writeEnable==1'b1 && writeRegister != 0)
			registers[writeRegister] = writeData;
	end

endmodule
