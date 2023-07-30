// Control Unit
// Control unit is a state limiting device (FSM) that generates signals to control modules. to work properly (see Fig.
// 9.2) At the rising edge of the clock signal, if reset = 0, resets the state of the FSM to its initial state, the opcode line.
// is dragged from IR because the FSM needs to know that the CPU is executing the instruction. (instruction) what to generate a signal
// correct control signal sent to control various modules It's on the right side of the control unit. It's not usually written.
// control unit into the data path because it will cause the wires to become tangled and unrecognizable.
//       
//                ---------------  3
//                |             |--/-> pc_mode 
// Clock Reset->  |             |  2
//      Reset->   |             |--/-> mar_mode 
//                |             |
//                |             |---> mux_select
//                |             |  2
//                |             |--/-> mem_oe, mem_we 
//                |             |  2
//           8    |             |--/-> ir_mode
//   opcode -/->  |             |--->  alu_ena
//                |             |  2
//                |             |--/-> tos_mode
//                |             |  2
//                |             |--/-> tmp_mode
//                |             |  2
//                |             |--/-> ds_mode
//                |             |  2
//                |             |--/-> rs_mode
//                ---------------  3
//
// Figure 9.2 Control unit of CPU stack
// In Verilog language, it is written as follows:

module control(clock, reset, data_bus, oper0, pc_mode, mar_mode, mux_select, mem_oe,
mem_we, ir_mode, alu_ena, tos_mode, tmp_mode, ds_mode, rs_mode);
input clock;
input reset;
input [7:0] data_bus;
input [7:0] oper0;
output [2:0] pc_mode;
output [1:0] mar_mode;
output mux_select;
output mem_oe;
output mem_we;
output [1:0] ir_mode;
output alu_ena;
output [1:0] tos_mode;
output [1:0] tmp_mode;
output [1:0] ds_mode;
output [1:0] rs_mode;
reg [7:0] state;
reg [18:0] cont;
assign {pc_mode[2:0], mar_mode[1:0], mux_select, mem_oe, mem_we, ir_mode[1:0],
alu_ena, tos_mode[1:0], tmp_mode[1:0], ds_mode[1:0], rs_mode[1:0]} = cont[18:0];always @(posedge clock)
begin
	if (reset == 1'b0)
		begin
			state[7:0] = 8'b0000_0000;
		end
		else
			begin
				case(state[7:0])
				8'b0000_0000 : // reset
				begin
					cont[18:0] = 19'b000_00_0_1_1_00_1_00_00_00_00;
					state[7:0] = 8'b0000_0001;
				end
				8'b0000_0001 : // fetch
			begin
				cont[18:0] = 19'b011_11_0_0_1_01_1_11_11_11_11;
				state[7:0] = 8'b0000_0010;
			end
			8'b0000_0010 : // decode, pc = pc + 1
				begin
					cont[18:0] = 19'b100_11_0_1_1_11_1_11_11_11_11;
					case (data_bus[7:0]) // the number in parentheses is the number of clock cycles used
					8'b0000_0000 : state[7:0] = 8'b0000_0011; // LIT (2)
					8'b0000_0001 : state[7:0] = 8'b0000_0101; // LOAD (2)
					8'b0000_0010 : state[7:0] = 8'b0000_0111; // STORE (3)
					8'b0000_0011 : state[7:0] = 8'b0000_1010; // ADD (2)
					8'b0000_0100 : state[7:0] = 8'b0000_1010; // SUB (2)
					8'b0000_0101 : state[7:0] = 8'b0000_1010; // AND (2)
					8'b0000_0110 : state[7:0] = 8'b0000_1010; // OR (2)
					8'b0000_0111 : state[7:0] = 8'b0000_1010; // XOR (2)
					8'b0000_1000 : state[7:0] = 8'b0000_1100; // DROP (1)
					8'b0000_1001 : state[7:0] = 8'b0000_1101; // DUP (1)
					8'b0000_1010 : state[7:0] = 8'b0000_1110; // OVER (4)
					8'b0000_1011 : state[7:0] = 8'b0001_0010; // SWAP (3)
					8'b0000_1100 :
						begin
							if (oper0[7:0] != 8'b0000_0000)
								state[7:0] = 8'b0001_0101; // IF(1) branch not taken
							else
								state[7:0] = 8'b0001_0110; // IF(2) branch taken
						end
					8'b0000_1101 : state[7:0] = 8'b0001_1000; // CALL (4)
					8'b0000_1110 : state[7:0] = 8'b0001_1100; // EXIT (1)
					8'b0000_1111 : state[7:0] = 8'b1111_1111; // HALT
					endcase
				end
			8'b0000_0011 : // lit (1) : ds.push(tos)
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_10_11_01_11;
					state[7:0] = 8'b0000_0100;
				end
			8'b0000_0100 : // lit (2) : tos = mem[pc], pc = pc + 1
			begin
				cont[18:0] = 19'b100_11_0_0_1_11_1_01_11_11_11;
				state[7:0] = 8'b0000_0001;
			end
			8'b0000_0101 : // load (1) : mar = tos
				begin
					cont[18:0] = 19'b011_01_0_1_1_11_1_10_11_11_11;
					state[7:0] = 8'b0000_0110;
				end
			8'b0000_0110 : // load (2) : tos = mem[mar]
				begin
					cont[18:0] = 19'b011_11_1_0_1_11_1_01_11_11_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0000_0111 : // store (1) : mar = tos
				begin
					cont[18:0] = 19'b011_01_0_1_1_11_1_10_11_11_11;
					state[7:0] = 8'b0000_1000;
				end
			8'b0000_1000 : // store (2) : data_bus = ds.pop()
				begin
					cont[18:0] = 19'b011_11_1_1_0_11_1_11_11_10_11;
					state[7:0] = 8'b0000_1001;
				end
			8'b0000_1001 : // store (3) : write, tos = ds.pop()
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_01_11_10_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0000_1010 : // add, sub, and, or, xor (1) : tmp = ds.pop()
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_11_01_10_11;
					state[7:0] = 8'b0000_1011;
				end
			8'b0000_1011 : // add, sub, and, or, xor (2) : tos = tos op tmp
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_0_01_11_11_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0000_1100 : // drop (1) : tos = ds.pop()
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_01_11_10_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0000_1101 : // dup (1) : ds.push(tos)
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_10_11_01_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0000_1110 : // over (1) : tmp = ds.pop()
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_11_01_10_11;
					state[7:0] = 8'b0000_1111;
				end
			8'b0000_1111 : // over (2) : ds.push(tmp)
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_11_10_01_11;
					state[7:0] = 8'b0001_0000;
				end
			8'b0001_0000 : // over (3) : ds.push(tos)
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_10_11_01_11;
					state[7:0] = 8'b0001_0001;
				end
			8'b0001_0001 : // over (4) : tos = tmp
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_01_10_11_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0001_0010 : // swap (1) : tmp = tos
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_10_01_11_11;
					state[7:0] = 8'b0001_0011;
				end
			8'b0001_0011 : // swap (2) : tos = ds.pop()
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_01_11_10_11;
					state[7:0] = 8'b0001_0100;
				end
			8'b0001_0100 : // swap (3) : ds.push(tmp)
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_11_10_01_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0001_0101 : // IF (not taken 1) : pc = pc + 1, tos = ds.pop()
				begin
					cont[18:0] = 19'b100_11_0_1_1_11_1_01_11_10_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0001_0110 : // IF (taken 1) : pc = mem[pc]
				begin
					cont[18:0] = 19'b001_11_0_0_1_11_1_11_11_11_11;
					state[7:0] = 8'b0001_0111;
				end
			8'b0001_0111 : // IF (taken 2) : tos = ds.pop()
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_01_11_10_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0001_1000 : // CALL (1) : mar = pc
				begin
					cont[18:0] = 19'b010_01_0_1_1_11_1_11_11_11_11;
					state[7:0] = 8'b0001_1001;
				end
			8'b0001_1001 : // CALL (2) : pc = pc + 1
				begin
					cont[18:0] = 19'b100_11_0_1_1_11_1_11_11_11_11;
					state[7:0] = 8'b0001_1010;
				end
			8'b0001_1010 : // CALL (3) : rs.push(pc)
				begin
					cont[18:0] = 19'b010_11_0_1_1_11_1_11_11_11_01;
					state[7:0] = 8'b0001_1011;
				end
			8'b0001_1011 : // CALL (4) : pc = mem[mar]
				begin
					cont[18:0] = 19'b001_11_1_0_1_11_1_11_11_11_11;
					state[7:0] = 8'b0000_0001;
				end
			8'b0001_1100 : // EXIT (1) : pc = rs.pop()
				begin
					cont[18:0] = 19'b001_11_0_1_1_11_1_11_11_11_10;
					state[7:0] = 8'b0000_0001;
				end
			8'b1111_1111 : // halt
				begin
					cont[18:0] = 19'b011_11_0_1_1_11_1_11_11_11_11;
					state[7:0] = 8'b1111_1111;
				end
			endcase
		end
	end
endmodule
