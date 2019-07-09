

module mux_two(first,second,flag,signal);
	input [15:0] first;
	input [15:0] second;
	input flag;
	output [15:0] signal;
	//copied from util
	assign signal = flag ? first : second;
endmodule
