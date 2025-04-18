`timescale 1ns / 1ns

module MIPS_tb;

    // Inputs
    reg clk;
    reg reset;

    // Output
    wire done;

    // Instantiate the Unit Under Test (UUT)
    MIPS_TOP uut (
        .clk(clk),
        .reset(reset),
        .done(done)
    );

    // Clock generation: 10ns period (50 MHz clock)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Apply reset for 
        @(posedge clk)
        reset = 0;

        // Wait for 'done' signal to go high
        wait(done);
        #11;
        $display("Simulation completed successfully at time %0t", $time);
        $finish;
    end

    // Monitor signals for debugging
    initial begin
        $display("Starting MIPS simulation...");
        $monitor("Time = %0t | clock = %b | Reset = %b | Done = %b", $time, clk, reset, done);

        // Timeout to prevent infinite simulation
        #5000;
        $display("Simulation ended due to timeout at time %0t", $time);
        $finish;
    end

    // Monitor on posedge of clk
    always @(posedge clk) begin
        $display("\ninstruction: %h | PC-in: %h | PC-out: %h | ALU_zero: %b", uut.instruction, uut.PC_in, uut.PC_out, uut.alu_zero);
        $display("Register File Contents:");
        $display("register $t0(R08): %h", uut.RF.registers[8*32 + 31 : 8*32]);
        $display("register $t1(R09): %h", uut.RF.registers[9*32 + 31 : 9*32]);
        $display("register $t2(R10): %h", uut.RF.registers[10*32 + 31 : 10*32]);
        $display("register $t3(R11): %h", uut.RF.registers[11*32 + 31 : 11*32]);
        $display("register $t4(R12): %h", uut.RF.registers[12*32 + 31 : 12*32]);
        $display("register $t5(R13): %h", uut.RF.registers[13*32 + 31 : 13*32]);
        $display("register $t6(R14): %h", uut.RF.registers[14*32 + 31 : 14*32]);
        $display("Data Memory:");
        $display("Address 0x00000000: %h", uut.DM.memory[0]);
        $display("Address 0x00000004: %h", uut.DM.memory[1]);
        $display("Address 0x00000008: %h", uut.DM.memory[2]);
        $display("Address 0x0000000c: %h", uut.DM.memory[3]);
        $display("Address 0x00000010: %h", uut.DM.memory[4]);
        $display("\n");
    end

endmodule
