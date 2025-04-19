`timescale 1ns/1ns

module tb_Data_Memory;
    // Clock and control signals
    reg         clk;
    reg         reset;
    reg         MemWrite;
    reg         MemRead;
    reg  [31:0] address;
    reg  [31:0] WriteData;
    wire [31:0] ReadData;

    // Instantiate the module under test
    Data_Memory uut (
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .address(address),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    // Clock generation: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Monitor signals
        $monitor("Time: %0t | clk: %b | reset: %b | MemWrite: %b | MemRead: %b | address: 0x%h | WriteData: 0x%h | ReadData: 0x%h", 
             $time, clk, reset, MemWrite, MemRead, address, WriteData, ReadData);

        // Initial reset
        reset     = 1;
        MemWrite  = 0;
        MemRead   = 0;
        address   = 0;
        WriteData = 0;
        
        #10;
        reset = 0;  // release reset
        
        #10;
        // 1) Simple write to address 4
        address   = 32'd4;          
        WriteData = 32'h1234_5678;  
        MemWrite  = 1;
        MemRead   = 0;
        reset     = 0;

        #10;
        // 2) Read back from address 4
        MemWrite  = 0;
        address  = 32'd4;
        MemRead  = 1;

        #20;
        MemRead  = 0;
        #10;

        // 3) Simultaneous read/write at address 8
        address   = 32'd8;
        WriteData = 32'hDEAD_BEEF;
        MemWrite  = 1;
        MemRead   = 1;
        #20;

        MemWrite  = 0;
        MemRead   = 0;
        #10;
        $finish;
    end
endmodule
