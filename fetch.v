

`include "util.v"

module fetch(pc_branch_d, pcsrc_d, stallf, clk, pc_plus_2f, instructionf);
	input [15:0] pc_branch_d;
	input pcsrc_d;
	input stallf;
	input clk;
	output [15:0] pc_plus_2f;
	output [15:0] instructionf;

	wire [15:0] next_count;
	wire [15:0] cur_count;
	program_counter pc(clk, stallf, next_count, cur_count);
	adder ad1(cur_count, 2, pc_plus_2f);
	mux_two mux1(pc_branch_d, pc_plus_2f, pcsrc_d, next_count);

	Memory mem(cur_count,1'b0, clk , 1'b1,instructionf);

endmodule
