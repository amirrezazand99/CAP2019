

`include "mem_pipeline_register.v"
`include "mem.v"


module mem_stage(input CLK, RegWriteE, MemtoRegE, MemWriteE,
  input [15:0] ALUOutE, WriteDataE,
	input [3:0] WriteRegE,
  output RegWriteM, MemtoRegM,
  output [15:0] RD, ALUOutM, output [3:0] WriteRegM);

  // Internal wires
  wire MemWriteM;
  wire [15:0] WriteDataM;

  // Modules
  mem_pipeline_register memPipelineRegister(
    // inputs
    CLK, RegWriteE, MemtoRegE,
    MemWriteE, ALUOutE, WriteDataE, WriteRegE,
    // outputs
    RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM);

  Memory dataMemory(.A_in(ALUOutM), .WD(WriteDataM), .WE(MemWriteM), .CLK(CLK), .MemToRegM(MemtoRegM), .RD(RD));

endmodule