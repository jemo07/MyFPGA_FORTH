// Memory Address Register (MAR)
// MAR is an 32-bit register that stores the address (address) that will be read and written to memory. MAR works in rhythm.
// The clock signal at the positive edge of the clock signal (except mode = 2).
// If mode = 0, reset MAR to 0.
// If mode = 1, set MAR equal to the value in the data bus.
// If mode = 2, write the MAR value into the data bus.
// If mode = 3 do nothing (value z at data bus)
// In Verilog language, it is written as follows:
//
module register(clock, register_mode, data_bus, register_value);
  input clock;
  input [1:0] register_mode;
  inout [31:0] data_bus;
  output [31:0] register_value;
  reg [31:0] register_value;
  reg [31:0] temp;
  
  // This instruction does not wait for the clock signal.
  assign data_bus[31:0] = (register_mode[1:0] == 2'b10 ? register_value[31:0] : temp[31:0]);
  
  always @(posedge clock) begin
    case(register_mode[1:0])
      2'b00:
        begin
          register_value[31:0] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
          temp[31:0] = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
        end
      2'b01:
        begin
          register_value[31:0] = data_bus[31:0];
          temp[31:0] = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
        end
      2'b10:
        begin
          // do nothing (This mode does not work according to the clock signal.)
        end
      2'b11:
        begin
          temp[31:0] = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
        end
    endcase
  end
endmodule
