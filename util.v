


module adder (input [15:0] a, input [15:0] b, output [15:0] out);
 
  assign out = a + b;
endmodule

module and1_2(input a, b, output reg out);
  always @(*) begin
    
    out = a & b;
  end
endmodule

// Inverter outputs the inverse of the input if control is 1.
module inverter(input in, control, output reg out);
  always @(*) begin
    out = (control) ? ~in : in;
  end
endmodule

module mux32_2 (input [15:0] a, b, input high_a, output [15:0] out);
  assign out = high_a ? a : b;
 
endmodule

module mux5_2 (input [4:0] a, b, input high_a, output [4:0] out);
  assign out = high_a ? a : b;
endmodule

// A = 0, B = 1, C = 2
module mux32_3 (input [15:0] a, b, c, input[1:0] control, output [15:0] out);
  assign out = (control == 0) ? a : ((control == 2'b01) ? b : ((control == 2'b10) ? c : 16'bxxxx));
endmodule