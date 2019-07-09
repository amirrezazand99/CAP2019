


module program_counter(clock, stallf, next_count, cur_count);
input [15:0] next_count;
input stallf;
input clock;
output reg [31:0] cur_count;
reg [15:0] current;
always @(posedge clock)
begin
    if(stallf==1)
        cur_count <= next_count;
	
		
end
initial
begin
    // See readme for the required starting two bytes of the binary.
    cur_count <= 16'h0000;
end
endmodule

