// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

//Synchronous RAM with Old Data Read-During-Write 
//Behavior, note that address is word aligned
module umips_ram #(parameter INIT_HEX="") (
    input  wire        clk,
    input  wire        we,
    input  wire [31:0] wd,
    input  wire [31:0] a0,
    output wire [31:0] rd0
);
    //16K memory
	reg [31:0] ram[4095:0];
    
    //Load memory from hex file      
	initial begin
		$readmemh(INIT_HEX, ram);
	end

    //write wd on rising edge
	always @(posedge clk) begin            
        if (we) begin
            ram[a0[13:2]] <= wd;
        end
    end
    assign rd0 = ram[a0[13:2]];
endmodule
	
