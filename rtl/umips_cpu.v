// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_cpu (
    input  wire             clk,
    input  wire             rst,
    output wire             LCD_RW,
	output wire             LCD_EN,
    output wire             LCD_RS,
	output wire     [7:0]   LCD_DATA,
    output wire     [9:0]   LEDG
 );
	wire    [31:0]  pc;
    reg     [31:0]  pc_next;
    wire    [31:0]  pc_branch;
    wire    [31:0]  pc_jump;
                     
    wire    [31:0]  pc_plus_4_f;
    wire    [31:0]  pc_plus_4_d;
    wire    [31:0]  pc_plus_4_e;
                    
    wire    [31:0]  imm_d;
    wire    [31:0]  imm_e;
                    
    wire    [31:0]  inst_f;
    wire    [31:0]  inst_d;
    wire    [31:0]  inst_e;
    wire    [31:0]  inst_m;
    wire    [31:0]  inst_w;
                    
    wire    [31:0]  lo;
    wire    [31:0]  hi;
                    
    wire    [31:0]  read_data;        
    wire    [31:0]  read_data_m;
    wire    [31:0]  read_data_w;
    wire    [31:0]  read_data_io;    
    wire    [31:0]  reg_data_w;
            
    wire    [31:0]  reg_read_0_d; 
    wire    [31:0]  reg_read_0_e;
    wire    [31:0]  reg_read_1_d;
    wire    [31:0]  reg_read_1_e;
            
    wire    [31:0]  reg_read_0_d_out;
    wire    [31:0]  reg_read_0_d_tmp;
    wire    [31:0]  reg_read_1_d_out;
            
    wire    [31:0]  alu_src_a;
    wire    [31:0]  alu_src_b;
    wire    [31:0]  alu_out_e;
    wire    [31:0]  alu_out_m;
    wire    [31:0]  alu_out_w;
	wire    [3:0]   alu_op_d;
	wire    [3:0]   alu_op_e;
            
    wire    [1:0]   reg_dest_d;
    wire    [1:0]   reg_dest_e;
            
    wire    [1:0]   alu_src_a_d;
    wire    [1:0]   alu_src_a_e;
    wire    [1:0]   alu_src_b_d;
    wire    [1:0]   alu_src_b_e;
            
    wire    [31:0]  write_data_e;
    wire    [31:0]  write_data_m;
            
	wire    [4:0]   write_reg_e;
	wire    [4:0]   write_reg_m;
	wire    [4:0]   write_reg_w;
            
	wire    [4:0]   rs_d;
	wire    [4:0]   rs_e;
            
	wire    [4:0]   rt_d;
	wire    [4:0]   rt_e;

	wire    [4:0]   rd_d;
	wire    [4:0]   rd_e;
            
	wire            stall_f;
	wire            stall_d;
	wire            flush_e;
            
	wire            jump;
    wire            jump_reg;
    wire            branch;
    wire            branch_d;
	wire            branch_e;
            
	wire            mem_write_d;
	wire            mem_write_e;
	wire            mem_write_m;
            
    wire            reg_write_d;
    wire            reg_write_e;
	wire            reg_write_m;
	wire            reg_write_w;

	wire            mem_to_reg_d;
	wire            mem_to_reg_e;
	wire            mem_to_reg_m;
	wire            mem_to_reg_w;
                   
    wire            sign_sel_d;
    wire            sign_sel_e;
    wire            sign_sel_m;
                   
    wire            byte_sel_d;
    wire            byte_sel_e;
    wire            byte_sel_m;
    
    wire            word_sel_d;
    wire            word_sel_e;
    wire            word_sel_m;
        
    assign rs_d = inst_d[25:21];
	assign rt_d = inst_d[20:16]; 
	assign rd_d = inst_d[15:11];
    assign branch = (branch_e & alu_out_e[0]);
    
	//Fetch stage
	umips_fetch umips_fetch (
        .clk(clk),
        .rst(rst),
        .stall(stall_f),
        .d(pc_next),
        .q(pc)
    );	
       
	//Decode stage
	umips_decode umips_decode (
        .clk(clk),
        .rst(rst),
        .stall(stall_d),
        .flush(branch), 
        .inst_f(inst_f),        
        .inst_d(inst_d),
        .pc_plus_4_f(pc_plus_4_f),
        .pc_plus_4_d(pc_plus_4_d)        
    );
	
	//Execute stage
	umips_execute umips_execute(
        .clk(clk),
        .rst(rst),
        .flush(flush_e),
        
        .imm_d(imm_d),
        .imm_e(imm_e), 

        .inst_d(inst_d),
        .inst_e(inst_e),
        
        .rs_d(rs_d),
        .rs_e(rs_e),

        .rt_d(rt_d),
        .rt_e(rt_e),

        .rd_d(rd_d),
        .rd_e(rd_e), 

        .reg_read_0_d(reg_read_0_d_out),
        .reg_read_0_e(reg_read_0_e),

        .reg_read_1_d(reg_read_1_d_out),
        .reg_read_1_e(reg_read_1_e),

        .reg_dest_d(reg_dest_d),
        .reg_dest_e(reg_dest_e),
        
        .alu_src_a_d(alu_src_a_d),
        .alu_src_a_e(alu_src_a_e),
        
        .alu_src_b_d(alu_src_b_d),
        .alu_src_b_e(alu_src_b_e),

        .reg_write_d(reg_write_d),
        .reg_write_e(reg_write_e),

        .mem_write_d(mem_write_d),
        .mem_write_e(mem_write_e), 
        
        .mem_to_reg_d(mem_to_reg_d), 
        .mem_to_reg_e(mem_to_reg_e),
        
        .branch_d(branch_d),
        .branch_e(branch_e),
        
        .alu_op_d(alu_op_d),
        .alu_op_e(alu_op_e),
        
        .pc_plus_4_d(pc_plus_4_d),
        .pc_plus_4_e(pc_plus_4_e),
        
        .sign_sel_d(sign_sel_d),
        .sign_sel_e(sign_sel_e),
        
        .byte_sel_d(byte_sel_d),
        .byte_sel_e(byte_sel_e),
        
        .word_sel_d(word_sel_d),
        .word_sel_e(word_sel_e)
    );	
                            
	//Memory stage
	umips_memory umips_memory (
        .clk(clk),
        .rst(rst),

        .inst_e(inst_e),
        .inst_m(inst_m),

        .reg_write_e(reg_write_e),
        .reg_write_m(reg_write_m),

        .mem_write_e(mem_write_e),
        .mem_write_m(mem_write_m),

        .mem_to_reg_e(mem_to_reg_e),
        .mem_to_reg_m(mem_to_reg_m),
        
        .alu_out_e(alu_out_e), 
        .alu_out_m(alu_out_m), 

        .write_reg_e(write_reg_e),
        .write_reg_m(write_reg_m),

        .write_data_e(write_data_e),
        .write_data_m(write_data_m),
        
        .sign_sel_e(sign_sel_e),
        .sign_sel_m(sign_sel_m),
        
        .byte_sel_e(byte_sel_e),
        .byte_sel_m(byte_sel_m),
        
        .word_sel_e(word_sel_e),
        .word_sel_m(word_sel_m)
    );
                        
	//Writeback stage	
	umips_write_back umips_write_back (
        .clk(clk),
        .rst(rst),

        .inst_m(inst_m),
        .inst_w(inst_w),

        .reg_write_m(reg_write_m), 
        .reg_write_w(reg_write_w),            

        .mem_to_reg_m(mem_to_reg_m),
		.mem_to_reg_w(mem_to_reg_w),

        .read_data_m(read_data_m),
        .read_data_w(read_data_w),

        .write_reg_m(write_reg_m),
        .write_reg_w(write_reg_w),
        
        .alu_out_m(alu_out_m), 
        .alu_out_w(alu_out_w)
    );
	
	//Control unit
	umips_control_unit umips_control_unit (
        .rst(rst),

        .opcode(inst_d[31:26]),
        .ifunct(inst_d[5:0]), 

        .reg_dst(reg_dest_d),

        .alu_op(alu_op_d),
        .alu_src_a(alu_src_a_d),
        .alu_src_b(alu_src_b_d),        

        .reg_write(reg_write_d),
        .mem_write(mem_write_d), 
        .mem_to_reg(mem_to_reg_d),

        .jump(jump), 
        .jump_reg(jump_reg), 
        .branch(branch_d),
        
        .sign_sel(sign_sel_d),
        .byte_sel(byte_sel_d),
        .word_sel(word_sel_d)        
    );
	

	//Instruction memory
    umips_ram #("imem.hex") umips_inst_memory (
        .clk(clk),
        .we(1'b0), 
        .wd(32'b0),
        .a0(pc), 
        .rd0(inst_f)
    );   

	//Data memory
	umips_ram #("dmem.hex") umips_data_memory (
        .clk(clk),
        .we(mem_write_m  & (!alu_out_m[15])), 
        .wd(write_data_m), 
        .a0(alu_out_m), 
        .rd0(read_data)
    );
    
    //MMIO
	umips_mmio umips_mmio(
        .clk(clk),
        .we(mem_write_m  & alu_out_m[15]), 
        .wd(write_data_m), 
        .a0(alu_out_m),  
        .LEDG(LEDG),
        .LCD_RW(LCD_RW),
        .LCD_RS(LCD_RS),
        .LCD_EN(LCD_EN),
        .LCD_DATA(LCD_DATA)
    );

    //Byte addressable memory logic
    umips_bytesel umips_bytesel (        
        .sign_sel(sign_sel_m),
        .byte_sel(byte_sel_m),
        .word_sel(word_sel_m),
        .byte_n(alu_out_m[1:0]),
        .in_word(read_data),
        .out_word(read_data_m)
     );
    
	//immediate sign extension
	umips_signext umips_signext( 
        .a(inst_d[15:0]), 
        .y(imm_d)
    );
    
    //Control flow
    assign pc_plus_4_f = pc + 32'b100;
    assign pc_branch = pc_plus_4_e + (imm_e<<2);
    assign pc_jump = {pc_plus_4_d[31:28], (inst_d[25:0] << 2)};   
    always @(*) begin
		case ({jump, jump_reg, branch})
			3'b000:  pc_next = pc_plus_4_f;
			3'b001:  pc_next = pc_branch;
            3'b010:  pc_next = reg_read_0_d;
			3'b100:  pc_next = pc_jump;
            default: pc_next = pc_plus_4_f;
		endcase
	end	

	mux mem_to_reg_mux(
        mem_to_reg_w, 
        alu_out_w, 
        read_data_w, 
        reg_data_w
    );
    
	mux4 #(5) reg_dest_mux(
        reg_dest_e, 
        rt_e, 
        rd_e, 
        5'b11111, 
        5'b01000, 
        write_reg_e
    ); //rt/rd/ra/lo 
    
    //Register file
	umips_register_file umips_register_file (
        .clk(clk),
        .rst(rst),
        .we(reg_write_w),
        .a0(rs_d), 
        .a1(rt_d),
        .a2(write_reg_w),
        .wd(reg_data_w), 
        .rd0(reg_read_0_d),
        .rd1(reg_read_1_d), 
        .lo(lo)
    );
			
	//ALU	
	wire [1:0] forward_a_d, forward_b_d, forward_a_e, forward_b_e;
    //ALU src mux in decode stage    
    mux4 alu_src_a_mux1_d(alu_src_a_d, reg_read_0_d, 32'b0, lo, 32'b100, reg_read_0_d_tmp);//HACK for JAL PC = PC+8    
    mux3 alu_src_a_mux2_d(forward_a_d, reg_read_0_d_tmp, reg_data_w, 'b0, reg_read_0_d_out);    
    mux3 alu_src_b_mux_d(forward_b_d, reg_read_1_d, reg_data_w, 'b0, reg_read_1_d_out);
    
    //ALU src mux in execute stage
	mux3 alu_src_a_mux_e(forward_a_e, reg_read_0_e, reg_data_w, alu_out_m, alu_src_a);
	mux3 alu_src_b_mux1_e(forward_b_e, reg_read_1_e, reg_data_w, alu_out_m, write_data_e);
    mux3 alu_src_b_mux2_e(alu_src_b_e, write_data_e, imm_e, pc_plus_4_e, alu_src_b);
    
    // ALU
	umips_alu umips_alu ( 
        .op(alu_op_e),
        .a(alu_src_a), 
        .b(alu_src_b),
        .aluout(alu_out_e)
    );
	    
	// Hazard unit
    umips_hazard_unit umips_hazard_unit ( 
        .rs_e(rs_e),
        .rt_e(rt_e),
        .rs_d(rs_d),
        .rt_d(rt_d),
        .reg_write_m(reg_write_m),
        .reg_write_w(reg_write_w),
        .mem_to_reg_e(mem_to_reg_e),
        .write_reg_m(write_reg_m),
        .write_reg_w(write_reg_w),
        .alu_src_a_d(alu_src_a_d),
        .alu_src_a_e(alu_src_a_e),
        .stall_f(stall_f),
        .stall_d(stall_d),
        .flush_e(flush_e),
        .forward_a_d(forward_a_d),
        .forward_b_d(forward_b_d),
        .forward_a_e(forward_a_e),
        .forward_b_e(forward_b_e)
    );  
endmodule
