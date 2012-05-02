// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_write_back (
	input wire clk, 
    input wire rst,

	input wire [31:0] inst_m, 
    output reg [31:0] inst_w, //for simulation only

	input wire reg_write_m, 
    output reg reg_write_w, 

    input wire mem_to_reg_m, 
    output reg mem_to_reg_w,

	input wire [31:0] read_data_m, 
    output reg [31:0] read_data_w,

	input wire [4:0] write_reg_m, 
    output reg [4:0] write_reg_w,

	input wire [31:0] alu_out_m,
    output reg [31:0] alu_out_w
);
	always @(posedge clk, negedge rst)
		if (rst == 0) begin			
			inst_w			<= 0;		
			reg_write_w	    <= 0;
			mem_to_reg_w	<= 0;
			read_data_w	    <= 0;
			alu_out_w 		<= 0;
			write_reg_w  	<= 0;
		end
		else begin		
			inst_w			<= inst_m;
			reg_write_w	    <= reg_write_m;
			mem_to_reg_w	<= mem_to_reg_m;
			read_data_w	    <= read_data_m;
			alu_out_w 		<= alu_out_m;
			write_reg_w  	<= write_reg_m;
		end
endmodule
