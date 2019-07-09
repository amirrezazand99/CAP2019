

module classify(opcode, is_r_type, is_i_type, is_j_type);
	input wire [5:0] opcode;
	output wire is_r_type;
	output wire is_i_type;
	output wire is_j_type;
	
	// R-type: addu, div, mfhi, mflo, sll, subtraction
	assign is_r_type = 
		(opcode == 4'b0000) | // addition
		(opcode == 4'b0010) | //subtraction
		(opcode == 4'b0100) | //Mul
		(opcode == 4'b0101) |//and
		(opcode == 4'b0110) | //shift
		(opcode == 4'b1011) | //clear
		(opcode == 4'b1101); ///compare
		
	assign is_i_type = 
		(opcode == 4'b0001) | // addition read from base address
		(opcode == 4'b0011) | // addition immidiate
		(opcode == 4'b0111) | // load word
		(opcode == 4'b1000) | // load indirect
		(opcode == 4'b1001) | // store
		(opcode == 4'b1010) | // store indirect
		(opcode == 4'b1100) | // move immediate
		(opcode == 4'b1110); // branch nq
	
	assign is_j_type = 
		(opcode == 4'b1111); // jump
		
endmodule
		
		
		
		