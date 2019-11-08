`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:42:45 11/08/2019 
// Design Name: 
// Module Name:    core 
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
`define OP_ITYPE 7'b0000000
`define OP_RTYPE 7'b0000001
`define OP_LUI   7'b0000010
`define OP_AUIPC 7'b0000011

`define ADDI 3'b000
`define SLTI 3'b001
`define ANDI 3'b010
`define ORI  3'b011
`define XORI 3`b100
`define SLLI 3'b101
`define SRLI 3`b110
`define SRAI 3'b111

`define ADD  3'b000
`define SLT  3'b001
`define SLTU 3'b010
`define AND  3'b011
`define OR   3'b100
`define XOR  3'b101
`define SLL  3'b110
`define SRL  3'b111


module core(clk,result);
	// input and output
	input clk;
	output [31:0] result;
	
	// wire
	// program decode
	wire [31:0] program;
	wire ALUSrc = (program[6:0] == `OP_ITYPE);
	wire [4:0] rd = program[11:7];
	wire [2:0] funct3 = program[14:12];
	wire [4:0] rs1 = program[19:15];
	wire [4:0] rs2 = program[24:20];
	wire [11:0] immidiate = program[31:20];
	
	wire writeEnable=1;
	wire [31:0] readData1,readData2;
	wire [4:0] ALUOp = 0;
	wire zero,carry;
	wire [31:0] writeData = result;
	wire [31:0] ALUinput2 = ALUSrc? immidiate : readData2;
	
	reg [31:0] pc;
	
	// initialize
	initial begin
		pc <= 0;
	end
	
	/// always
	always @(posedge clk) begin
		if(pc==32'd20)
			pc <= 0;
		else
			pc <= pc + 4;
	end
	
	// ROM for program
	BRAM programMemory (
		.clka(clk), // input clka
		.addra(pc), // input [31 : 0] addra
		.douta(program) // output [31 : 0] douta
	);
	
	Register registers (
    .readRegister1(rs1), 
    .readRegister2(rs2), 
    .writeRegister(rd), 
    .writeData(writeData), 
    .readData1(readData1), 
    .readData2(readData2), 
    .clk(clk), 
    .writeEnable(writeEnable)
    );

	ALU alu (
    .data1(readData1), 
    .data2(ALUinput2), 
    .ALUOp(ALUOp), 
    .result(result), 
    .zero(zero), 
    .carry(carry)
    );


endmodule
