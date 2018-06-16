module file_reader_tb();

    parameter DATA_WIDTH = 7;    
    reg clk = 1;
    wire [DATA_WIDTH:0] data;

    always #5 clk = ~clk;

    file_reader unit_under_test(
        .clk(clk),
        .data(data)
    );

    always @(posedge clk)
        begin
            $display("%h",data);
        end

    initial
        begin
            #20000 $stop;
        end

endmodule 