


module Memory(input [15:0] A_in, WD, input WE, CLK, MemToRegM, output reg [15:0] RD);
	
	reg [15:0] text[16'b0000000000000000:16'b0010000000000000]; // 1kB text 00000000 up
	reg [15:0] data[16'b0010000000000001:16'b1000000000000000]; // 3kB data starting from top of text going up
	
	
	wire [15:0] A;

	assign A = A_in;
	
	always @(posedge CLK) begin
	if (A <= 16'b0010000000000000 && A >= 16'b0000000000000000) begin
		RD <= text[A];
	end else if (A <= 16'b1000000000000000 && A >= 16'b0010000000000001) begin
		RD <= data[A];
	end 
	
	if (WE) begin // MemWrite signal
		if (A <= 16'b0010000000000000 && A >= 16'b0000000000000000) begin
			text[A] <= WD;
		end else if (A <= 16'b1000000000000000 && A >= 16'b0010000000000001) begin
			data[A] <= WD;
			end
		end
	end 
endmodule