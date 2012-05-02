// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_decode (
	input wire clk,
    input wire rst,
    input wire stall,
    input wire flush,

	input wire [31:0] inst_f,
	output reg [31:0] inst_d,

	input wire [31:0] pc_plus_4_f,	
	output reg [31:0] pc_plus_4_d
);
	always @(posedge clk, negedge rst)
		if (rst == 0) begin			
			inst_d      <= 0;
			pc_plus_4_d <= 0;
		end else if (flush == 1) begin
			inst_d      <= 0;
			pc_plus_4_d <= 0;            
		end	else if (!stall) begin
			inst_d      <= inst_f;
			pc_plus_4_d <= pc_plus_4_f;
		end
endmodule
