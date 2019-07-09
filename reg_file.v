

`include "register.v"

module reg_file(clock, reg_rs_id, reg_rt_id, control_reg_write, control_write_id,
		reg_write_value, reg_rs_value, reg_rt_value, ra_write,
		ra_write_value);
		// sys call
		// هنوز زده نشده
		input wire clock;
		
		input wire [3:0] reg_rs_id;
		input wire [3:0] reg_rt_id;
		
		input wire control_reg_write;
		// This is the id of the register to write to at negedge of the clock,
		// if control_reg_write is set. To avoid race conditions, avoid
		// modifying this signal at negedge of the clock.
		input wire [3:0] control_write_id;
		
		input wire [15:0] reg_write_value;
		
		input wire ra_write;
		input wire [15:0] ra_write_value;
		
		output reg [31:0] reg_rs_value;
		output reg [31:0] reg_rt_value;
		
		
		wire inverted_clock;
		
		wire reg_should_write [15:0];
		// 14 reg 16 bit 
		wire [15:0] bank_outputs [13:0];
		
		assign inverted_clock = ~clock;
		
		// For bank[i], the should_write value is reg_should_write[i] and the
		// curr_value is bank_outputs[i].
		//register bank [15:0] (inverted_clock, reg_should_write, reg_write_value,
		//		bank_outputs);
	
		// The generate block allows us to use a for loop to set up wires for
		// each individual register.
		generate
		genvar i;
		for (i = 0; i < 32; i = i + 1) begin
			wire reg_should_write_gen;
			wire reg_ra_should_write;
			wire [31:0] reg_output;
			wire is_ra_reg;

			register r(inverted_clock, reg_should_write_gen | reg_ra_should_write, reg_write_value, reg_output);
			
			// 9 = status register , ra
			assign is_ra_reg = (i == 9);
			
			assign reg_ra_should_write = is_ra_reg && ra_write;
			
			assign reg_should_write_gen = ((i == control_write_id) ? 1 : 0) & (i != 0) & control_reg_write;
			// Move this register's value on to the corresponding output if
			// the reg_id matches.
			assign bank_outputs[i] = reg_output;
			
		end
	endgenerate
	
	
	always@(*) begin
		reg_rs_value <= bank_outputs[reg_rs_id];
		reg_rt_value <= bank_outputs[reg_rt_id];
	end
	
	
endmodule
