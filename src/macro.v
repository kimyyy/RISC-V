`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:42 11/20/2019 
// Design Name: 
// Module Name:    macro 
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
`define OP_ITYPE  7'b0010011
`define OP_RTYPE  7'b0110011
`define OP_LUI    7'b0110111
`define OP_AUIPC  7'b0010111
`define OP_STR    7'b0100011
`define OP_LD     7'b0000011
`define OP_BRANCH 7'b1100011
`define OP_JAL    7'b1101111
`define OP_JALR   7'b1100111

`define ADD_SUB  3'b000
`define SLL  3'b001
`define SLT  3'b010
`define SLTU 3'b011
`define XOR  3'b100
`define SRL_SRA  3'b101
`define OR   3'b110
`define AND  3'b111

`define FUNCT_SRA 6'b010000
`define FUNCT_SRL 6'b000000

`define FUNCT_R_SUBSRA  7'b0100000
`define FUNCT_R_DEFAULT 7'b0000000

`define FUNCT_I_DEFAULT 7'b0000000
`define FUNCT_I_SRAI 7'b0100000
`define ZERO {`XLEN{0}}
`define XLEN 32
`define PC_LIMIT 32'd20
