

`include "classify.v"
module control_unit(opcode, reg_rt_id, is_r_type, reg_write,
		mem_to_reg, mem_write, alu_src, reg_dest);
		
		
	input wire [3:0] opcode;
		
		
	// This register ID is used like a funct for opcode 0 (called REGIMM)
	input wire [3:0] reg_rt_id;

	// Used by the decoder.
	output wire is_r_type;

	output wire reg_write;
	output wire mem_to_reg;
	output wire mem_write;
	
	output wire alu_src;
	output wire reg_dest;
	
	
	// wire is_r_type;	// Declared as an output.
	wire is_i_type;
	wire is_j_type;
	
	wire is_shift_op;
	
	classify classifier(opcode, is_r_type, is_i_type, is_j_type);
	
	assign mem_write =
		(opcode == 4'b1001) | // store
		(opcode == 4'b1010); // store indirect
		
	assign reg_write =
		(opcode == 4'b0000) | // addition
		(opcode == 4'b0010) | //subtraction
		(opcode == 4'b0100) | //Mul
		(opcode == 4'b0101) |//and
		(opcode == 4'b0110) | //shift
		(opcode == 4'b1011) | //clear
		(opcode == 4'b1101) | ///compare
		(opcode == 4'b0001) | // addition read from base address
		(opcode == 4'b0011) | // addition immidiate
		(opcode == 4'b0111) | // load word
		(opcode == 4'b1000) ;//load indirect
		
	// This is 1 if and only if the instruction is an r-type instruction.
	assign reg_dest = is_r_type; 
	
	
	
endmodule
