// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

`include "umips_alu.vh"

module umips_alu (
	input wire [3:0] op,
	input wire [31:0] a,
	input wire [31:0] b,
	output reg [31:0] aluout
);		
	always @(*)	begin
		case (op)
			`ALU_ADD: aluout <= a + b;
			`ALU_SUB: aluout <= a - b;
            `ALU_MUL: aluout <= a * b;
			`ALU_AND: aluout <= a & b;
			`ALU_OR:  aluout <= a | b;
			`ALU_XOR: aluout <= a ^ b;
            `ALU_EQ:  aluout <= (a == b) ? 'b1:'b0;
            `ALU_NE:  aluout <= (a != b) ? 'b1:'b0;
            `ALU_LT:  aluout <= (a < b)  ? 'b1:'b0;
            `ALU_GT:  aluout <= (a > b)  ? 'b1:'b0;
			default:  aluout <= {32{1'bx}};
		endcase		
	end
endmodule
