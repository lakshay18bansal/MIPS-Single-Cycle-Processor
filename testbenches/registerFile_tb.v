`timescale 1ns/1ps
module tb_Register_File();
    reg [4:0] read_reg1, read_reg2, write_reg;
    reg [31:0] write_data;
    reg write_en, clk, rst;
    wire [31:0] read_data1, read_data2;
    
    integer i;
    Register_File uut (
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .write_en(write_en),
        .clk(clk),
        .rst(rst),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        write_en = 0;
        read_reg1 = 0;
        read_reg2 = 0;
        write_reg = 0;
        write_data = 0;
        
        // Test 1: Reset functionality
        #10;
        rst = 0;
        #10;
        $display("Test 1: Reset values");
        read_reg1 = 0;
        #10;
        if (read_data1 !== 32'h0) $error("Reset failed for reg0");
        
        // Test 2: Basic write/read
        $display("\nTest 2: Basic write/read");
        write_en = 1;
        for (i = 1; i < 32; i++) begin
            write_reg = i;
            write_data = 32'h1234 + i;
            @(negedge clk);
            read_reg1 = i;
            #10;
            if (read_data1 !== write_data) 
                $error("Mismatch at reg%d: Exp 0x%h, Got 0x%h", 
                      i, write_data, read_data1);
        end
        
        // Test 3: Read during write
        $display("\nTest 3: Read during write");
        write_reg = 5;
        write_data = 32'hCAFE_BABE;
        read_reg1 = 5;
        read_reg2 = 5;

        // 1. Check pre-write value
        @(negedge clk);
        #5;  // Check just before posedge
        if (read_data1 !== (32'h1234 + 5))
            $error("Pre-write check failed");
            
        // 2. Trigger write
        @(posedge clk);
        #5;  // Allow propagation

        // 3. Verify updated value
        if (read_data1 !== 32'hCAFE_BABE || read_data2 !== 32'hCAFE_BABE)
            $error("Post-write check failed");

        
        // Test 4: Write conflict check
        $display("\nTest 4: Write enable control");
        write_en = 0;
        write_reg = 10;
        write_data = 32'hDEAD_BEEF;
        @(posedge clk);
        #10;
        read_reg1 = 10;
        #5;
        if (read_data1 === 32'hDEAD_BEEF)
            $error("Unauthorized write occurred");
            
        // Test 5: Async reset
        $display("\nTest 5: Async reset");
        rst = 1;
        #5;
        read_reg1 = 1;
        read_reg2 = 2;
        #10;
        if (read_data1 !== 0 || read_data2 !== 0)
            $error("Reset not working");
        
        // Test 6: Dual port read
        $display("\nTest 6: Dual port read");
        rst = 0;
        write_en = 1;
        write_reg = 8;
        write_data = 32'hA5A5_A5A5;
        @(posedge clk);
        #10;
        read_reg1 = 8;
        read_reg2 = 8;
        #10;
        if (read_data1 !== read_data2 || read_data1 !== 32'hA5A5_A5A5)
            $error("Dual port mismatch");
        
        $display("\nAll tests completed");
        $finish;
    end
endmodule
