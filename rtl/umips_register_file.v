// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_register_file (
	input wire          clk,
	input wire          rst,
	input wire          we,
	input wire  [4:0]   a0,
	input wire  [4:0]   a1,
	input wire  [4:0]   a2,
	input wire  [31:0]  wd,
	output wire [31:0]  rd0,
	output wire [31:0]  rd1,
    output wire [31:0]  lo
);
	reg [31:0] regs[31:0];
	
    integer i;	
	initial begin			
		for(i=0; i<32; i=i+1)
			regs[i] <=0;
        //regs[28] <= 32'h00004000;//gp
        regs[29] <= 32'h00003FF4; //sp
	end
			
	always @(posedge clk)
		if (we) begin
			regs[a2] <= wd;
        end
			
    //Zero register
	assign rd0 = (a0 == 4'b0) ? 0: regs[a0];
	assign rd1 = (a1 == 4'b0) ? 0: regs[a1];
    
    //LOW register
    assign lo = regs[5'b01000];
endmodule
