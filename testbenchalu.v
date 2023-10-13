`timescale 1ns / 1ps

module alu_tb;

    reg ena;
    reg [7:0] opcode;
    reg [7:0] oper0;
    reg [7:0] oper1;
    wire [7:0] data_bus;

    // Instantiate the alu module
    alu uut (
        .ena(ena), 
        .opcode(opcode), 
        .oper0(oper0), 
        .oper1(oper1), 
        .data_bus(data_bus)
    );

    initial begin
        // Initialize inputs
        ena = 0;
        opcode = 8'b0000_0111; // ADD operation
        oper0 = 8'b0000_0010; // 2
        oper1 = 8'b0000_0011; // 3

        // Apply inputs
        #10 ena = 1;
        #10;
        ena = 0;

        // Check output
        #10 if (data_bus === 8'b0000_0101) // 5
            $display("Test passed!");
        else
            $display("Test failed. Output was: %b", data_bus);
        
        // Finish the simulation
        $finish;
    end

endmodule

