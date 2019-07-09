

module enable(prev,cur,flag,clk);
input [15:0] prev;
input flag;
input clk;
output [15:0] cur;
reg [15:0] wi;

always@(posedge clk)
begin
if(flag)
    assign wi = prev;
end

assign cur = wi;

endmodule
