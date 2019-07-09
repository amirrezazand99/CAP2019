


module mux4_1(A , select , Y);
	input [3:0]A;
	input [1:0]select;
	output Y;
	wire w0,w1,w2,w3,w4,w5,w6;
	
	
	not(w0,select[0]);
	not(w1,select[1]);
	and(w2,A[0],w0,w1);
	and(w3,A[1],select[0],w1);
	and(w4,A[2],select[1],w0);
	and(w5,select[0],select[1]);
	
	or(w6,w1,w2,w3,w4,w5);
	assign Y = w6;
endmodule
	

