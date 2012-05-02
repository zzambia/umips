// This file is part of the umips project.
// Copyright (c) 2011 Ibrahim Abd Elkader <i.abdalkader@gmail.com> 
// See the file COPYING for copying permission.

module umips_bytesel (           
    input wire  [1:0]   byte_n,     //the byte or halfword index.
    input wire          sign_sel,   //selects zero or sign extension.
    input wire          byte_sel,   //select byte/halfword output.
    input wire          word_sel,   //select extended byte/halfword or word output.
   
    input wire  [31:0]  in_word,
    output wire [31:0]  out_word
);
    wire [7:0]  byte;
    wire [15:0] hword;
    
    wire [31:0] byte_signed;
    wire [31:0] hword_signed;
    
    wire [31:0] out_signed;
    
    mux4 #(8) byte_mux (
        .s(byte_n),
        .s3(in_word[7:0]),
        .s2(in_word[15:8]),
        .s1(in_word[23:16]),
        .s0(in_word[31:24]),
        .y(byte)
    );

    mux #(16) hword_mux (
        .s(byte_n[0]),
        .s1(in_word[15:0]),
        .s0(in_word[31:16]),
        .y(hword)
    );    
    
    mux #(32) byte_signext (
        .s(sign_sel),
        .s0({{24'b0}, byte}),
        .s1({{24{byte[7]}}, byte}),
        .y(byte_signed)
    );    

    mux #(32) hword_signext (
        .s(sign_sel),
        .s0({{16'b0}, hword}),
        .s1({{16{hword[15]}}, hword}),
        .y(hword_signed)
    );    
     
    mux #(32)  byte_hword_mux(
        .s(byte_sel),
        .s0(byte_signed),
        .s1(hword_signed),
        .y(out_signed)
    );

    mux #(32) word_mux(
        .s(word_sel),
        .s0(in_word),
        .s1(out_signed),
        .y(out_word)
    );    
endmodule
