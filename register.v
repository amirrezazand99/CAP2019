

`define REG_START_VALUE 0


// The value in new_value is saved to the register if should_write is 1

module register(clock, should_write, new_value, curr_value);
	// The clock.
	input wire clock;
	
	// clock posedge.
	input wire should_write;

	// New value for the register.
	input wire [15:0] new_value;

	// The current value stored in the register.
	output reg [15:0] curr_value;

	
	// start, others don't.
	reg is_init;
	
	initial begin
		is_init = 0;
		curr_value = `REG_START_VALUE;
	end
	
	// Register accepts new value at posedge of every clock.
	// گفتم اگر در سیکل اول رجیستر 
	// pc
	//حتما صفر باشه تا 
	// unknown 
	// نده
	always @(posedge clock) begin
		if (is_init) begin
			if (should_write) begin
				curr_value <= new_value;
			end
		end else begin
			is_init <= 1;
		end
	end

endmodule
