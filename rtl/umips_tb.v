// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

`timescale 1 ps / 1 ps

module umips_tb (
);
	reg rst;
    reg clk;
	
	umips_cpu umips_cpu (
        .clk(clk),
        .rst(rst)
    );

	initial begin
		rst <= 0; 
		#5;
		rst <= 1;		
	end
		
	always begin
		clk <= 1;
		#5;
		clk <= 0;
		#5;
	end	
endmodule
