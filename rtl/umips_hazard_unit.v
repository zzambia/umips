// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_hazard_unit (
    input wire [4:0] rs_e,
    input wire [4:0] rt_e,
    input wire [4:0] rs_d,
    input wire [4:0] rt_d,

	input wire reg_write_m,
	input wire reg_write_w,
	input wire mem_to_reg_e,

	input wire [4:0] write_reg_m, 
	input wire [4:0] write_reg_w, 

    input wire [1:0] alu_src_a_d, 
    input wire [1:0] alu_src_a_e,	

	output reg stall_f,
	output reg stall_d,
	output reg flush_e,

    output reg [1:0] forward_a_d,
    output reg [1:0] forward_b_d,
    output reg [1:0] forward_a_e,
    output reg [1:0] forward_b_e
);	
	always @(*) begin
    //Forward to decode stage
	if ((rs_d != 0) &&  (reg_write_w == 1) && (rs_d == write_reg_w)) 
		forward_a_d <= 2'b01;
	else 
		forward_a_d <= 2'b00;

    if ((rt_d != 0) &&  (reg_write_w == 1) && (rt_d == write_reg_w))
		forward_b_d <= 2'b01;
	else 
		forward_b_d <= 2'b00;
 
        //forward lo
  	if (alu_src_a_d == 2 &&  reg_write_w == 1 && write_reg_w == 5'b01000) 
		forward_a_d <= 2'b01;
        
    //Forward to execute stage
	if ((rs_e != 0) &&  (reg_write_m == 1) && (rs_e == write_reg_m)) 
		forward_a_e <= 2'b10;
	else if ((rs_e != 0) &&  (reg_write_w == 1) && (rs_e == write_reg_w)) 
		forward_a_e <= 2'b01;
	else 
		forward_a_e <= 2'b00;
		
	if ((rt_e != 0) &&  (reg_write_m == 1) && (rt_e == write_reg_m)) 
		forward_b_e <= 2'b10;
	else if ((rt_e != 0) &&  (reg_write_w == 1) && (rt_e == write_reg_w)) 
		forward_b_e <= 2'b01;
	else 
		forward_b_e <= 2'b00;						
     
    //forward lo
  	if (alu_src_a_e == 2 &&  reg_write_m == 1 && write_reg_m == 5'b01000) 
		forward_a_e <= 2'b10;
	else if (alu_src_a_e == 2 && reg_write_w == 1 && write_reg_w == 5'b01000) 
		forward_a_e <= 2'b01;
        
	//lw rt_e equals rs_d or rt_d
	if (mem_to_reg_e && rt_e != 0 && (rs_d == rt_e || rt_d == rt_e)) begin 
		stall_f <= 1;
		stall_d <= 1;
		flush_e <= 1;
    end	else begin
		stall_f <= 0;
		stall_d <= 0;
		flush_e <= 0;
	end
    
	end
endmodule
