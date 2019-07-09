



module jump_calculator(raw_address, pc_plus_two, jump_address);
	
	// The raw address from the jump instruction.
	input wire [11:0] raw_address;
	
	// The next pc address.
	input wire [15:0] pc_plus_two;
	
	// The actual target jump address.
	output wire [15:0] jump_address;

	//یک بیت آخر همراره صفر برای آنکه حالت 
	//word
	//بودن حفظ شود
	assign jump_address[0] = 0;
	
	// The top four bits of the target jump address are taken from the
	// next PC value.
	assign jump_address[15:12] = pc_plus_two[15:12];

	// The rest of the bits are encoded in the jump instruction.
	assign jump_address[11:1] = raw_address;

endmodule