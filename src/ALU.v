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
        case(optype)
            // immidiate operation
            `OP_ITYPE: begin
                case(ALUOp)
                    `ADD: aluOperation = data1 + data2;
                    `SLT: aluOperation = {{(`XLEN-1){0}}, ((data1 - data2) <0)};
                    `SLTU: aluOperation = {{(`XLEN-1){0}}, ((data1 - $unsigned(data2)) < 0)};
                    `AND: aluOperation = data1 & data2;
                    `OR : aluOperation = data1 | data2;
                    `XOR: aluOperation = data1 ^ data2;
                    `SLL: aluOperation = data1 << shamt;
                    `SRL: aluOperation = data1 >> shamt;
                    `SRL_SRA: 
                    begin
                        case(funct7)
                            `FUNCT_I_DEFAULT: aluOperation = data1 >> shamt;
                            `FUNCT_I_SRAI: aluOperation = data1 >>> shamt;
                            // undefined funct
                            default: begin
                                $display("undefined funct: %x", funct7);
                                aluOperation = `ZERO;
                            end
                        endcase
                    end
                    // undefined operation
                    default: aluOperation = `ZERO;
                endcase
            end
            // register to register operation
            `OP_RTYPE: begin
                case(ALUOp)
                    `ADD_SUB:
                    begin
                        case(funct7)
                            `FUNCT_R_DEFAULT: aluOperation = data1 + data2;
                            `FUNCT_R_SUBSRA:  aluOperation = data1 - data2;
                            default: begin
                                $display("undefined funct in R-add");
                                aluOperation = `ZERO;
                            end
                        endcase
                    end
                    `SLT: aluOperation ={{(`XLEN-1){0}}, ((data1 - data2) < 0)};
                    `SLTU: aluOperation = {{(`XLEN-1){0}}, ((data1 - $unsigned(data2)) < 0)};
                    `AND: aluOperation = data1 & data2;
                    `OR: aluOperation = data1 | data2;
                    `XOR: aluOperation = data1 ^ data2;
                    `SLL: aluOperation = data1 << shamt;
                    `SRL_SRA: begin
                        case(funct7)
                            `FUNCT_R_DEFAULT: aluOperation = data1 >> shamt;
                            `FUNCT_R_SUBSRA: aluOperation = data1 >>> shamt;
                            default: begin
                                $display("undefined funct: R-SRL");
                                aluOperation = `ZERO; // undefined funct
                            end
                        endcase
                    end
                    default: begin
                        $display("undefined operation: %x", ALUOp);
                        aluOperation = `ZERO; // undefined operation
                    end
                endcase
            end
            default: begin
                $display("undefined optype: %7b", optype);
                aluOperation = `ZERO; // undefined optype
            end
        endcase
    end
	endfunction
endmodule
