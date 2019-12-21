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



module core(clk,result);
   `include "macro.v"
	// input and output
	input clk;
	output [31:0] result;
	
	// wire
	// program decode
	wire [31:0] program;
    wire [6:0] optype = program[6:0];
	wire ALUSrc = (optype == `OP_ITYPE);
	wire [4:0] rd = program[11:7];
	wire [2:0] funct3 = program[14:12];
	wire [4:0] rs1 = program[19:15];
	wire [4:0] rs2 = program[24:20];
	wire [11:0] immidiate = program[31:20];
    wire [6:0] funct7 = program[31:25];
    wire [19:0] jal_offset = program[31:12];
	
	wire writeEnable=(optype==`OP_ITYPE || optype==`OP_RTYPE || optype==`OP_JAL);
	wire [31:0] readData1,readData2;
	wire [2:0] ALUOp = funct3;
	wire zero,carry;
	wire [31:0] writeData = result;
    wire [31:0] ALUinput1 = readData1;
    // immidiate is sign extention
	wire [31:0] ALUinput2 = ALUSrc? {{20{immidiate[11]}},immidiate} : readData2;
	
	reg [31:0] pc;
	
	// pc is 0 at start
	initial begin
		pc <= 32'd0;
	end
	
	/// always
	always @(posedge clk) begin
		if(pc==`PC_LIMIT)
			pc <= 32'd0;
		else if(optype==`OP_JAL)
            pc <= pc + jal_offset <<2;
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
    .data1(ALUinput1), 
    .data2(ALUinput2), 
    .optype(optype),
    .ALUOp(ALUOp), 
    .funct7(funct7),
    .result(result), 
    .zero(zero), 
    .carry(carry)
    );


endmodule
