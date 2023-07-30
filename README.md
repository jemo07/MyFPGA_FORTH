components of the cpu stack
The CPU stack consists of 3 main parts:
- Memory (MEM)
- Data Stack (DS)
- Return Stack (RS)
The CPU stack executes the instructions contained in the memory (each channel 8 bits or 1 byte) starting from the instructions that
Program Counter (PC) is pointing, for example, PC = 0, it starts executing the command in the channel 0. One instruction consists of 2 parts:
- 1 byte opcode tells what instruction it is. The next byte of the execution code is valid.
Operand if any
- 1 byte operand, an instruction may require a number of operands.
1 or 2, or no operand at all.
Upon completion of one command, the PC moves to the next command and starts executing (execute) that command, and so on.

Instruction Set Architecture
The whole set of instructions is as follows (oper or operand is the operand, the operation code in the table is a hexadecimal number).

// INSERT TABLE HERE. 


