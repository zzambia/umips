// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_fetch (
	input wire clk,
    input wire rst,
    input wire stall,
	input wire [31:0] d,
	output reg [31:0] q
);
    always @(posedge clk, negedge rst)
        if (rst == 0)
		    q <= 0;
        else if (stall == 0)
            q <= d;
endmodule
