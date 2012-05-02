// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

`include "umips_alu.vh"
module umips_control_unit (
	input  wire         rst,     
    input  wire [5:0]   opcode, 
    input  wire [5:0]   ifunct,    
	output wire [1:0]   reg_dst, 
    output wire [1:0]   alu_src_a, 
    output wire [1:0]   alu_src_b,
    output wire [3:0]   alu_op,
	output wire         reg_write,
    output wire         mem_write, 
    output wire         mem_to_reg, 
    output wire         jump, 
    output wire         branch,
    output wire         jump_reg,
    output wire         sign_sel,
    output wire         byte_sel,
    output wire         word_sel
);	
	//R-Type instructions	
	localparam OP_NOP  = 6'b000000;
	localparam OP_ADD  = 6'b100000;
	localparam OP_ADDU = 6'b100001;
	localparam OP_SUB  = 6'b100010;
	localparam OP_SUBU = 6'b100011;	
	localparam OP_AND  = 6'b100100;
	localparam OP_OR   = 6'b100101;
	localparam OP_XOR  = 6'b100110;
	localparam OP_JR   = 6'b001000;
    localparam OP_MUL  = 6'b011000;
    localparam OP_SLT  = 6'b101010;
	localparam OP_MFLO = 6'b010010;
    
	//I-Type Instructions
	localparam OP_LW    = 6'b100011;
	localparam OP_SW    = 6'b101011;
    localparam OP_LB    = 6'b100000;
	localparam OP_SB    = 6'b101000;
    localparam OP_LH    = 6'b100001;
	localparam OP_SH    = 6'b101001;
    localparam OP_LBU   = 6'b100100;
    localparam OP_LHU   = 6'b100101;
	localparam OP_BEQ   = 6'b000100;
    localparam OP_BNE   = 6'b000101;
	localparam OP_ADDI  = 6'b001000;
	localparam OP_ADDIU = 6'b001001;
    localparam OP_SLTI  = 6'b001010;
    localparam OP_ANDI  = 6'b001100;
    localparam OP_ORI   = 6'b001101;

	//J-Type Instructions
	localparam OP_JMP   = 6'b000010;
	localparam OP_JAL   = 6'b000011;
	
	reg [18:0] control;
	assign {reg_dst, reg_write, mem_write, alu_src_a, alu_src_b, jump, branch, jump_reg, mem_to_reg, sign_sel, byte_sel, word_sel, alu_op} = control;
    
	always @(*)
		if (rst == 0)
			control <= 19'b0;
		else if (opcode == 0)
			case (ifunct)
				//R-Type Instructions
				OP_NOP:     control <= 19'b0;
				OP_ADD:     control <= {15'b0110_0000_0000_000, `ALU_ADD};
				OP_ADDU:    control <= {15'b0110_0000_0000_000, `ALU_ADD};
				OP_SUB:     control <= {15'b0110_0000_0000_000, `ALU_SUB};
				OP_SUBU:    control <= {15'b0110_0000_0000_000, `ALU_SUB};
				OP_AND:     control <= {15'b0110_0000_0000_000, `ALU_AND};
				OP_OR:      control <= {15'b0110_0000_0000_000, `ALU_OR };
				OP_XOR:     control <= {15'b0110_0000_0000_000, `ALU_XOR};
                OP_SLT:     control <= {15'b0110_0000_0000_000, `ALU_LT };
                OP_MUL:     control <= {15'b1110_0000_0000_000, `ALU_MUL};
                OP_MFLO:    control <= {15'b0110_1000_0000_000, `ALU_ADD};
                OP_JR:      control <= {15'b0000_0000_0010_000, `ALU_NOP};
				default:    control <= {15'b0000_0000_0000_000, `ALU_NOP};
			endcase		
		else 
			case (opcode)				
				//I-Type Instructions
                OP_LW:      control <= {15'b0010_0001_0001_000, `ALU_ADD};
                OP_SW:      control <= {15'b0001_0001_0000_000, `ALU_ADD};
                OP_LB:      control <= {15'b0010_0001_0001_101, `ALU_ADD};
                OP_LH:      control <= {15'b0010_0001_0001_111, `ALU_ADD};
                OP_LBU:     control <= {15'b0010_0001_0001_001, `ALU_ADD};
                OP_LHU:     control <= {15'b0010_0001_0001_011, `ALU_ADD};
                OP_SLTI:    control <= {15'b0010_0001_0000_000, `ALU_LT };
				OP_BEQ:     control <= {15'b0000_0000_0100_000, `ALU_EQ };
                OP_BNE:     control <= {15'b0000_0000_0100_000, `ALU_NE };
                OP_ADDI:    control <= {15'b0010_0001_0000_000, `ALU_ADD};                
				OP_ADDIU:   control <= {15'b0010_0001_0000_000, `ALU_ADD};			                                                       
                OP_ORI:     control <= {15'b0010_0001_0000_000, `ALU_OR };
                OP_ANDI:    control <= {15'b0010_0001_0000_000, `ALU_AND};
                                
				//J-Type Instructions                     
				OP_JMP:     control <= {15'b0000_0000_1000_000, `ALU_NOP};
                OP_JAL:     control <= {15'b1010_1110_1000_000, `ALU_ADD};//HACK fro JAL PC = PC+8
                //OP_JAL:     control <= {12'b1010_0110_1000, `ALU_ADD};                
				default:    control <= {15'b0000_0000_0000_000, `ALU_NOP};
			endcase					
endmodule
