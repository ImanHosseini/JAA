module file_reader(
    clk,
    data
    );

    parameter DATA_WIDTH = 7;
    parameter CURSOR_WIDTH = 9;
    input clk;
    output reg [DATA_WIDTH:0] data;
    reg [DATA_WIDTH:0] rom [0:1023]; // 1024 bytes
    reg [CURSOR_WIDTH:0] cursor = 0; // 0 to 1023

    initial
        begin
            $readmemh("test.txt", rom);
        end

    always @(posedge clk)
        begin
            data <= rom[cursor];
            cursor <= cursor + 1;
        end

endmodule