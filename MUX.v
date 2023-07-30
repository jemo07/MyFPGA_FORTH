// Multiplexor (MUX)
// To select between PC and MAR to set the address (address) to read/write the memory.
// If select = 0, select the PC value.
// If select = 1, select the MAR value.
// In Verilog language, it is written as follows:

module mux(sel, in0, in1, out);
  input sel;
  input [31:0] in0;
  input [31:0] in1;
  output [31:0] out;
  assign out[31:0] = (sel == 1'b0 ? in0[31:0] : in1[31:0]);
endmodule

