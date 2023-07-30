// Program Counter (PC)
// The PC is an 8-bit register that stores the address of the command being executed.
// The clock pulse at the positive edge of the clock signal (except mode = 2).
// If mode = 0 reset PC to 0
// If mode = 1, set the PC value to be equal to the value in the data bus.
// If mode = 2, write the PC value to the data bus.
// If mode = 3 do nothing (value z at data bus)
// If mode = 4, increase PC by one unit.
// In Verilog language, it is written as follows:

module pc(clock, pc_mode, data_bus, pc_value);


	input clock;
	input [2:0] pc_mode;
	inout [7:0] data_bus;
	output [7:0] pc_value;
	reg [7:0] pc_value;
	reg [7:0] temp;
// This instruction does not wait for the clock signal.
	assign data_bus[7:0] = (pc_mode[2:0] == 3'b010 ? pc_value[7:0] : temp[7:0]);
	always @(posedge clock)
	begin
		case(pc_mode[2:0])
			3'b000:
				begin
					pc_value[7:0] = 8'b0000_0000;
					temp[7:0] = 8'bzzzz_zzzz;
				end
			3'b001:
				begin
					pc_value[7:0] = data_bus[7:0];
					temp[7:0] = 8'bzzzz_zzzz;
				end
			3'b010:
				begin
					// do nothing (This mode does not work according to the clock signal.)
				end
			3'b011:
				begin
					temp[7:0] = 8'bzzzz_zzzz;
				end
			3'b100:
				begin
					pc_value[7:0] = pc_value[7:0] + 1'b1;
					temp[7:0] = 8'bzzzz_zzzz;
				end
		endcase
	end

endmodule
