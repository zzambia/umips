// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_memory (
	input wire          clk, 
    input wire          rst,

	input wire  [31:0]  inst_e, 
    output reg  [31:0]  inst_m,

	input wire          reg_write_e, 
	output reg          reg_write_m,

    input wire          mem_write_e, 
    output reg          mem_write_m, 

    input wire          mem_to_reg_e, 
    output reg          mem_to_reg_m,
    
	input wire  [31:0]  alu_out_e, 
    output reg  [31:0]  alu_out_m,

	input wire  [4:0]   write_reg_e, 
    output reg  [4:0]   write_reg_m,

    input wire  [31:0]  write_data_e, 
    output reg  [31:0]  write_data_m,
        
    input wire          sign_sel_e,
    output reg          sign_sel_m,
    
    input wire          byte_sel_e,
    output reg          byte_sel_m,
    
    input wire          word_sel_e,
    output reg          word_sel_m
);
	always @(posedge clk, negedge rst)
		if (rst == 0) begin			
			inst_m          <= 0;
			reg_write_m	    <= 0;
			mem_write_m 	<= 0;
			mem_to_reg_m 	<= 0;
			alu_out_m 		<= 0;
			write_reg_m 	<= 0;
			write_data_m 	<= 0;
            sign_sel_m      <= 0;
            byte_sel_m      <= 0;
            word_sel_m      <= 0;            
		end else begin		
			inst_m			<= inst_e;
			reg_write_m	    <= reg_write_e;
			mem_write_m 	<= mem_write_e;
			mem_to_reg_m 	<= mem_to_reg_e;
			alu_out_m 		<= alu_out_e;
			write_reg_m 	<= write_reg_e;
            write_data_m 	<= write_data_e;
            sign_sel_m      <= sign_sel_e;
            byte_sel_m      <= byte_sel_e;
            word_sel_m      <= word_sel_e;
		end
endmodule
