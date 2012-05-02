// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_signext( 
	input [15:0] a,
	output[31:0] y
);
	assign y = {{16{a[15]}},a};
endmodule
