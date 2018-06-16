module file_writer_tb();
    
    parameter DATA_WIDTH = 7;
    reg clk = 0;
    reg done = 0;
    wire [DATA_WIDTH:0] data;

    always #5 clk = ~clk;

    file_reader fr_unit_under_test(
        .clk(clk),
        .data(data)
        );

    file_writer fw_unit_under_test(
        .enable(clk),
        .done(done),
        .data(data)
        );

    always @(posedge clk)
        begin
            $display("%h",data);
        end

    initial
        begin
            #20000 done = 1;
            $stop;
        end

endmodule 