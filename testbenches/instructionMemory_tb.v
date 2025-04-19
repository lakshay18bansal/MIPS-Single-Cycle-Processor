`timescale 1ns / 1ns

module Instruction_Memory_tb;

    // Inputs
    reg clk;
    reg [31:0] read_address;

    // Output
    wire [31:0] instruction_out;

    // Instantiate the Unit Under Test (UUT)
    Instruction_Memory uut (
        .clk(clk),
        .read_address(read_address),
        .instruction_out(instruction_out)
    );

    // Clock generator: 10ns period
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        read_address = 0;

        // Wait for memory initialization
        #10;

        // Display all addresses and their instructions
        for (read_address = 0; read_address < 128 * 4; read_address = read_address + 4) begin
            #10;
            $display("time = %t, Address = 0x%h, Instruction = 0x%h", $time, read_address, instruction_out);
        end

        // Finish
        $finish;
    end

endmodule
