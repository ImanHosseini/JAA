module ram_writer(
    instruction
    );

    parameter INSTRUCTION_WIDTH = 31;
    parameter CURSOR_WIDTH = 9;
    input [INSTRUCTION_WIDTH:0] instruction;
    reg [INSTRUCTION_WIDTH:0] ram [0:1023]; // 1024 bytes
    reg [CURSOR_WIDTH:0] cursor = 0; // 0 to 1023

    always @(*)
        begin
            ram[cursor] = instruction;
            cursor = cursor + 1'b1;
            $display("ram :%b , %d", instruction, cursor);
        end

endmodule