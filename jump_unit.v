

module jump_unit(pc_plus_two, 
		reg_rs, reg_rt, branch_variant, jump_address, pc_src, 
		ra_write, ra_write_value);
	
	// The current PC, used for jump and link.
	input wire [15:0] pc_plus_two;


	
	
	// The current register values.
	input wire [15:0] reg_rs;
	input wire [15:0] reg_rt;

	// The specific kind of jump variant.
	input wire [2:0] branch_variant;
	
	// The actual jump address.
	output reg [15:0] jump_address;

	// Whether the PC should jump address. 1 = should jump.
	output reg pc_src;



	// This is 1 if ra_write_value should be stored to the ra register.
	output wire ra_write;

	// This is the value to write to the ra register, if needed.
	output wire [15:0] ra_write_value;

	initial
    begin
        pc_src = 0;
        jump_address = 0;
    end
	// This is the register containing the value to jump to if the
	// instruction is JUMP_REG.
	wire [15:0] jump_reg_address;

	assign jump_reg_address = reg_rs;

	
	assign ra_write = (branch_variant == 4'b1011);

	assign ra_write_value = pc_plus_two;
    
    // Determine pc_src.
	always @(*) begin
		case (branch_variant)
			
			4'b1010: pc_src <= 1'b1;
			
			4'b1010: pc_src <= (reg_rs != reg_rt);
			

			default: pc_src <= 1'bx;
		endcase
	end
endmodule
