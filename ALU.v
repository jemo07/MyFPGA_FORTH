// Arithmetic Logic Unit (ALU)
// ALU is a basic function computation circuit such as add (+), sub (-), and, or, xor, etc., based on alu_opcode.
// If alu_ena = 0 writes the result to the data bus.
// If alu_ena = 1 write the value z (high impedance)
// In Verilog language, it is written as follows:

module alu(ena, opcode, oper0, oper1, data_bus);
input ena;
input [7:0] opcode;
input [7:0] oper0;
input [7:0] oper1;
inout [7:0] data_bus;
wire [7:0] temp;
assign data_bus[7:0] = (ena == 1'b0 ? temp[7:0] : 8'bzzzz_zzzz);
assign temp[7:0] =
(opcode[7:0] == 8'b0000_0111 ? oper1[7:0] + oper0[7:0] : // ADD
(opcode[7:0] == 8'b0000_1000 ? oper1[7:0] - oper0[7:0] : // SUB
(opcode[7:0] == 8'b0000_1001 ? oper1[7:0] & oper0[7:0] : // AND
(opcode[7:0] == 8'b0000_1010 ? oper1[7:0] | oper0[7:0] : // OR
(opcode[7:0] == 8'b0000_1011 ? oper1[7:0] ^ oper0[7:0] : // XOR
8'b0000_0000 )))));
endmodule
