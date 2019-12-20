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
module ALU(data1,data2,optype,ALUOp,funct7,result,zero,carry);
	`include "macro.v"
	// input and output
	input [31:0] data1,data2;
    input [6:0] optype;
	input [2:0] ALUOp;
    input [6:0] funct7;
	output [31:0] result;
	output zero,carry;
    wire [4:0] shamt = data2[4:0];
	
	assign {carry, result} = aluOperation(data1,data2,ALUOp);
	assign zero = (result==0);

	function [32:0] aluOperation(input [31:0] data1, input [31:0] data2,input [2:0] ALUOp);
	begin
		case(ALUOp)
            `ADD_SUB: begin
                if(optype==`OP_ITYPE)
                    aluOperation=data1+data2;
                else if(optype==`OP_RTYPE) begin
                    if(funct7==`FUNCT_R_DEFAULT)
                        aluOperation=data1+data2;
                    else if(funct7==`FUNCT_R_SUBSRA)
                        aluOperation=data1-data2;
                    else
                        aluOperation=`ZERO;
                end
                else
                    aluOperation=`ZERO;
                end
			`SLT: aluOperation={{(`XLEN-1){0}},((data1-data2)<0)};
			`AND: aluOperation=data1 & data2;
			`OR:  aluOperation=data1 | data2;
			`XOR: aluOperation=data1 ^ data2;
			`SLL: aluOperation=data1 << data2;
            `SRL_SRA: begin
                if(optype==`OP_ITYPE) begin
                    if(funct7==`FUNCT_I_DEFAULT)
                        aluOperation=data1 >> shamt;
                    else if(funct7==`FUNCT_I_SRAI)
                        aluOperation=data1 >>> shamt;
                    else
                        aluOperation=`ZERO;
                end
                else if(optype==`OP_RTYPE) begin
                    if(funct7==`FUNCT_R_DEFAULT)
                        aluOperation=data1 >> data2;
                    else if(funct7==`FUNCT_R_SUBSRA)
                        aluOperation=data1 >>> data2;
                    else
                        aluOperation=`ZERO;
                end
                else
                    aluOperation=`ZERO;
            end
			default: aluOperation = `ZERO;
		endcase
	end
	endfunction

endmodule
