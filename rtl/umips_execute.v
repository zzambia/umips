// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_execute (
	input wire  clk, 
    input wire  rst,
    input wire  flush,

	input wire [31:0] imm_d, 
    output reg [31:0] imm_e,

	input wire [31:0] inst_d, 
    output reg [31:0] inst_e,

    input wire [4:0] rs_d,
    output reg [4:0] rs_e,

    input wire [4:0] rt_d,
    output reg [4:0] rt_e,
    
    input wire [4:0] rd_d,
    output reg [4:0] rd_e,

	input wire [31:0] reg_read_0_d,
    output reg [31:0] reg_read_0_e,

	input wire [31:0] reg_read_1_d,
    output reg [31:0] reg_read_1_e,

    input wire [1:0] reg_dest_d,
    output reg [1:0] reg_dest_e,

    input wire [1:0] alu_src_a_d,
    output reg [1:0] alu_src_a_e,

    input wire [1:0] alu_src_b_d,
    output reg [1:0] alu_src_b_e,

	input wire branch_d, 
	output reg branch_e, 
    
	input wire reg_write_d, 
	output reg reg_write_e, 

    input wire mem_write_d,
    output reg mem_write_e, 

    input wire mem_to_reg_d,
    output reg mem_to_reg_e, 
    
    input wire [3:0]alu_op_d,
    output reg [3:0]alu_op_e, 

    input wire [31:0] pc_plus_4_d,
    output reg [31:0] pc_plus_4_e,
    
    input wire  sign_sel_d,
    output reg  sign_sel_e,
    
    input wire  byte_sel_d,
    output reg  byte_sel_e,
    
    input wire  word_sel_d,
    output reg  word_sel_e
    
);
	always @(posedge clk, negedge rst)
		if (rst==0) begin
			rs_e            <= 0;
			rt_e            <= 0;
			rd_e            <= 0;
			inst_e          <= 0;
			imm_e           <= 0;
			reg_dest_e      <= 0;
			reg_write_e     <= 0;
			mem_write_e     <= 0;
			mem_to_reg_e    <= 0;
			alu_src_a_e     <= 0;
			alu_src_b_e     <= 0;
			alu_op_e        <= 0;			
            branch_e        <= 0;
			reg_read_0_e    <= 0;
			reg_read_1_e    <= 0;
            pc_plus_4_e     <= 0;
            sign_sel_e      <= 0;
            byte_sel_e      <= 0;
            word_sel_e      <= 0;
		end else if (flush==1) begin
			rs_e            <= 0;
			rt_e            <= 0;
			rd_e            <= 0;
			inst_e          <= 0;
			imm_e           <= 0;
			reg_dest_e      <= 0;
			reg_write_e     <= 0;
			mem_write_e     <= 0;
			mem_to_reg_e    <= 0;
			alu_src_a_e     <= 0;
			alu_src_b_e     <= 0;
			alu_op_e        <= 0;			
            branch_e        <= 0;
			reg_read_0_e    <= 0;
			reg_read_1_e    <= 0;
            pc_plus_4_e     <= 0;
            sign_sel_e      <= 0;
            byte_sel_e      <= 0;
            word_sel_e      <= 0;
		end else begin		
			rs_e            <= rs_d;
			rt_e            <= rt_d;
			rd_e            <= rd_d;
			imm_e           <= imm_d;	
			inst_e          <= inst_d;
			reg_dest_e      <= reg_dest_d;
			reg_write_e     <= reg_write_d;
			mem_write_e     <= mem_write_d;
			mem_to_reg_e    <= mem_to_reg_d;
			alu_src_a_e     <= alu_src_a_d;
			alu_src_b_e     <= alu_src_b_d;
			alu_op_e        <= alu_op_d;
            branch_e        <= branch_d;
			reg_read_0_e    <= reg_read_0_d;
			reg_read_1_e    <= reg_read_1_d;
            pc_plus_4_e     <= pc_plus_4_d;
            sign_sel_e      <= sign_sel_d;
            byte_sel_e      <= byte_sel_d;
            word_sel_e      <= word_sel_d;
		end
endmodule
