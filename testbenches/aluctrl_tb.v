
module tb;
    reg [5:0] funct;
    reg [1:0] ALUOp;
    wire [2:0] ALU_control_out;

    ALU_control uut (
        .ALUOp(ALUOp),
        .funct(funct),
        .ALU_control_out(ALU_control_out)
    );

    initial begin
        // Test case 1
        ALUOp = 2'b00; funct = 6'b000000; // ADD
        #10;
        $display("ALUOp: %b, funct: %b, ALU_control_out: %b", ALUOp, funct, ALU_control_out);

        // Test case 2
        ALUOp = 2'b01; funct = 6'b000000; // SUB
        #10;
        $display("ALUOp: %b, funct: %b, ALU_control_out: %b", ALUOp, funct, ALU_control_out);

        // Test case 3
        ALUOp = 2'b10; funct = 6'b100010; // AND
        #10;
        $display("ALUOp: %b, funct: %b, ALU_control_out: %b", ALUOp, funct, ALU_control_out);

        // Test case 4
        ALUOp = 2'b11; funct = 6'b101010; // OR
        #10;
        $display("ALUOp: %b, funct: %b, ALU_control_out: %b", ALUOp, funct, ALU_control_out);
    end
endmodule