



module alu(lvalue, rvalue, OP, result, Hi,LOW);

input [15:0] lvalue;
input [15:0] rvalue;
input [3:0] OP;
output reg [15:0] result;
output reg [15:0] Hi;
output reg [15:0] LOW;
reg [15:0] truevall;
reg [15:0] truevalr;
reg [15:0] compare1;
reg [15:0] compare2;
reg [31:0] mulhelper;


        

always @(lvalue, rvalue, OP)
begin
    if (lvalue == 16'bxxxxxxxxxxxxxxxx)
        truevall = 0;
    else
        truevall = lvalue;
    if (rvalue == 16'bxxxxxxxxxxxxxxxx)
        truevalr = 0;
    else
        truevalr = rvalue;
    case (OP)
        4'b0000: result = truevall + truevalr; // lvalue + rvalue;
        4'b0010: result = truevall - truevalr; // lvalue - rvalue;
        4'b0101: result = truevall & truevalr; // lvalue & rvalue;
		4'b0100: mulhelper = truevall * truevalr; // lvalue + rvalue;
        4'b1101: compare1 = truevall < truevalr; // compare
		4'b1101: compare2 = truevall > truevalr; // compare2
        4'b0110: result = truevall << truevalr;
        
	4'b0011: result = truevalr;	// truevaluer is the immediate value
	
    endcase
	if(mulhelper != 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)
		Hi = mulhelper[15:0];
		LOW = mulhelper[31:16];
	if( compare1 == compare2) 
		result = 1'b1;
	
end


endmodule