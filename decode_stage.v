


`include "control_unit.v"
`include "jump_unit.v"
`include "hazard_unit.v"

module decode_stage(clock, instruction, pc_plus_two, writeback_value, writeback_id, reg_write_W,

		reg_rs_value, reg_rt_value, immediate, jump_address, reg_rs_id,
		reg_rt_id, 

		reg_write_D, mem_to_reg, mem_write, alu_op, alu_src, reg_dest, pc_src,
		
		);

	input wire clock;

	// Inputs from the Fetch stage.
	input wire [15:0] instruction;
	input wire [15:0] pc_plus_two;

	// Inputs from the Writeback stage.
	input wire [15:0] writeback_value;
	input wire [3:0] writeback_id;
	input wire reg_write_W;

	// Outputs from the decode stage.
	output wire [15:0] reg_rs_value;
	output wire [15:0] reg_rt_value;
	output wire [15:0] immediate;
	output wire [15:0] jump_address;
	output wire [3:0] reg_rs_id;
	output wire [3:0] reg_rt_id;


	// Outputs from the control unit.
	output wire reg_write_D;
	output wire mem_to_reg;
	output wire mem_write;
	output wire [3:0] alu_op;
	output wire alu_src;
	output wire reg_dest;
	output wire pc_src;
	

	
	// Internal wires.
	wire is_r_type;

	wire [5:0] funct;
	wire [5:0] opcode;

	wire [15:0] maybe_jump_address;
	wire [15:0] maybe_branch_address;


	wire imm_is_unsigned;
	wire [15:0] sign_immediate;
	wire [15:0] unsign_immediate;

	// True if ra_write_value needs to be written to the ra register.
	wire ra_write;
	wire [15:0] ra_write_value;

	// This wire holds the shamt value specified by the instruction. The
	// actual shamt value may be modified by the control unit for some
	// instructions.
	wire [3:0] instr_shamt;
	
	assign immediate = imm_is_unsigned ? unsign_immediate : sign_immediate;

	// The decoder
	// TODO: Link part of Jump and Link not implemented!
	decoder decoder(
		.clock (clock),
		.instruction (instruction),
		.pc_plus_two (pc_plus_two),
		.writeback_value (writeback_value),
		.should_writeback (reg_write_W),
		.writeback_id (writeback_id),
		.is_r_type (is_r_type),
		.ra_write (ra_write),
		.ra_write_value (ra_write_value),
		.reg_rs_value (reg_rs_value),
		.reg_rt_value (reg_rt_value),
		.sign_immediate (sign_immediate),
		.unsign_immediate (unsign_immediate),
		.branch_address (maybe_branch_address),
		.jump_address (maybe_jump_address),
		.reg_rs_id (reg_rs_id),
		.reg_rt_id (reg_rt_id),
		.shamt (instr_shamt),
		.funct (funct),
		.opcode (opcode)
		
		);

	// The control unit.
	control_unit control(
		.opcode (opcode),
		.funct (funct),
		.instr_shamt (instr_shamt),
		.reg_rt_id (reg_rt_id),
		.is_r_type (is_r_type),
		.reg_write (reg_write_D),
		.mem_to_reg (mem_to_reg),
		.mem_write (mem_write),
		.alu_op (alu_op),
		.alu_src (alu_src),
		.reg_dest (reg_dest),
		.branch_variant (branch_variant),
		.imm_is_unsigned (imm_is_unsigned)

		);
	
	// The jump decider.
	jump_unit jump_decider(
		.pc_plus_two(pc_plus_two),
		.maybe_jump_address (maybe_jump_address),
		.maybe_branch_address (maybe_branch_address),
		.reg_rs (reg_rs_value),
		.reg_rt (reg_rt_value),
		.branch_variant (branch_variant),
		.jump_address (jump_address),
		.pc_src (pc_src),
		.ra_write_value (ra_write_value),
		.ra_write (ra_write)
		);
	

endmodule