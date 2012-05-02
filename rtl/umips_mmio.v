// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_mmio (
    input  wire         clk,
    input  wire         we,
    input  wire [31:0]  wd,
    input  wire [31:0]  a0,        
	output wire         LCD_EN,
    output wire         LCD_RS,
    output wire         LCD_RW,
	output wire [7:0]   LCD_DATA,
    output wire [9:0]   LEDG
);  
    reg [31:0] mmio[31:0];
    
    integer i;	
    initial begin
        for(i=0; i<32; i=i+1)
			mmio[i] <=32'b0;
	end      
      
    always @(posedge clk) begin
        if (we) begin
            mmio[a0[6:2]] <= wd;
        end        
	end
    
    assign LEDG = mmio[0][9:0];
    assign {LCD_EN, LCD_RS, LCD_RW, LCD_DATA} = mmio[1][10:0];
endmodule
	
