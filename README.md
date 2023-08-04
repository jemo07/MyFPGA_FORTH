

# MyFPGA_FORTH

## Overview

MyFPGA_FORTH is a project focused on implementing a FORTH-like language for FPGA. It consists of various Verilog files that define different components of a typical computer architecture, including the Arithmetic Logic Unit (ALU), Control Unit (CU), Memory Address Register (MAR), Multiplexer (MUX), Program Counter (PC), and a stack implementation.

## Components

### ALU (Arithmetic Logic Unit)
- **File**: `ALU.v`
- **Description**: The corresponding Verilog file defines the behavior of the ALU.
- The ALU (Arithmetic Logic Unit) file contains the logic for performing arithmetic and logical operations. It includes various case statements to handle different operations like addition, subtraction, AND, OR, etc. The file defines the inputs and outputs for the ALU and includes the logic for handling the operations.


### Control Unit (CU)
- **File**: `CU.v`
- **Description**: The Control Unit directs the operation of the processor.
- The Control Unit file is responsible for controlling the operation of the CPU. It takes inputs like the opcode and other control signals and generates the necessary control outputs to guide the other components of the CPU. The file includes logic for decoding instructions and generating the appropriate control signals.

### Memory Address Register (MAR)
- **File**: `MAR.v`
- **Description**: The MAR holds the address in memory of the instruction at present being executed.
- The MAR (Memory Address Register) file is used to store the address that will be accessed in memory. It includes logic for loading and storing addresses, and it interacts with other components to facilitate memory access.

### Multiplexer (MUX)
- **File**: `MUX.v`
- **Description**:The Multiplexer file contains the logic for selecting one of several input data lines and forwarding the selected input to a single output line.
- The logic for selecting one of several input data lines and forwarding the selected input to a single output line. It includes the logic for handling different selection lines and forwarding the appropriate input to the output. The MUX is used to select one of many inputs and forward the selected input to a single output line.

### Program Counter (PC)
- **File**: `PC.v`
- **Description**:The Program Counter file is responsible for keeping track of the address of the next instruction to be executed. 
- The Program Counter holds the address of the next instruction to be executed. It includes logic for incrementing the program counter, loading new values, and handling jumps and branches in the code.

### Stack Implementation
- **File**: `STACK.v`
- **Description**: This file contains the Verilog code for implementing a stack, a fundamental data structure used in computer science and FORTH.
- The Stack file contains the logic for implementing a stack data structure. It includes operations for pushing and popping data onto and off the stack. The file defines the necessary inputs and outputs for interacting with the stack and includes the logic for handling the stack operations.

These files collectively define the core components of a CPU and provide the logic necessary for executing instructions and performing computations. The design is modular, with each file handling a specific part of the CPU's functionality.

## Testbench for ALU ( TODO ) 
- **File**: `testbenchALU.v`
- **Description**: This file contains the testbench for the ALU, allowing for simulation and verification of the ALU's functionality.
- The ALU (Arithmetic Logic Unit) contains the logic for performing arithmetic and logical operations. It includes various case statements to handle different operations like addition, subtraction, AND, OR, etc. The file defines the inputs and outputs for the ALU and includes the logic for handling the operations.

## Additional Files ( TODO ) 
- **ALUoutput**: An output file related to the ALU, possibly containing simulation or test results.

## Getting Started

1. Clone the repository.
2. Open the Verilog files in a suitable FPGA development environment.
3. Compile and simulate the design as needed.

## Contributing

Feel free to fork the project and submit pull requests for any enhancements or fixes.

## License

[Add License Information Here]

## Contact

[Your Contact Information]



# Components of the CPU Stack
The CPU stack consists of 3 main parts:
- **Memory (MEM)**
- **Data Stack (DS)**
- **Return Stack (RS)**
The CPU stack executes the instructions contained in the memory (each channel 8 bits or 1 byte) starting from the instructions that
Program Counter (PC) is pointing, for example, PC = 0, it starts executing the command in the channel 0. One instruction consists of 2 parts:
- 1 byte opcode tells what instruction it is. The next byte of the execution code is valid.
Operand if any
- 1 byte operand, an instruction may require a number of operands.
1 or 2, or no operand at all.
Upon completion of one command, the PC moves to the next command and starts executing (execute) that command, and so on.

# Instruction Set Architecture
The whole set of instructions is as follows (oper or operand is the operand, the operation code in the table is a hexadecimal number).

// INSERT TABLE HERE. 



