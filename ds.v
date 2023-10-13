// Data Stack (DS) and Return Stack (RS)
// DS and RS are stacks with a capacity of 256, each with 8 bits, executed according to the clock
// The positive edge of the clock signal.
// if mode = 0 then empty stack
// If mode = 1 push the value from the data bus onto the stack.
// If mode = 2 pop a value from the stack and write it to the data bus.
// If mode = 3 do nothing (value z at data bus)
// It should be noted that when it comes to hardware, the top of stack of the data stack is always at the TOS register.
// The remainder is stored in the DS module. The return stack stores all of the data in the RS module. Verilog describes it as follows:
// (DS and RS modules work the same)

module ds(clock, mode, data_bus);
  input clock;
  input [1:0] mode;
  inout [31:0] data_bus;
  reg [31:0] tos;
  reg [31:0] data[0:255];
  reg [31:0] temp;
  
  assign data_bus[31:0] = temp[31:0];
  
  always @(posedge clock) begin
    case(mode[1:0])
      2'b00: begin
        tos[31:0] = 32'b1111_1111_1111_1111_1111_1111_1111_1111;
        temp[31:0] = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
      end
      2'b01: begin
        tos[31:0] = tos[31:0] + 1'b1;
        data[tos[31:0]][31:0] = data_bus[31:0];
        temp[31:0] = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
      end
      2'b10: begin
        temp[31:0] = data[tos[31:0]][31:0];
        tos[31:0] = tos[31:0] - 1'b1;
      end
      2'b11: begin
        temp[31:0] = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
      end
    endcase
  end
endmodule
