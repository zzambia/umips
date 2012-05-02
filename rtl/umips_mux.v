module mux #(parameter N=32)( 
	input s,
	input [N-1:0] s0,
	input [N-1:0] s1,	
	output[N-1:0] y
);
	assign y = (s == 0) ? s0: s1;
endmodule

module mux3 #(parameter N=32)( 
	input [1:0]s,
	input [N-1:0] s0,
	input [N-1:0] s1,
	input [N-1:0] s2,	
	output[N-1:0] y
);
	assign y = (s == 0) ? s0: (s == 1) ? s1: (s == 2) ? s2: 0;
endmodule
    
 module mux4 #(parameter N=32)( 
	input [1:0]s,
	input [N-1:0] s0,
	input [N-1:0] s1,
	input [N-1:0] s2,
    input [N-1:0] s3,
	output[N-1:0] y
);
	assign y = (s == 0) ? s0: (s == 1) ? s1: (s == 2) ? s2: (s == 3) ? s3: 5'b0;
endmodule
