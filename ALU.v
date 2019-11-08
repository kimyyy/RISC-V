`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:36 11/08/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU(data1,data2,ALUOp,result,zero,carry);
	// input and output
	input [31:0] data1,data2;
	input [4:0] ALUOp;
	output [31:0] result;
	output zero,carry;
	
	assign {carry, result} = data1 + data2;
	assign zero = (result==0);


endmodule
