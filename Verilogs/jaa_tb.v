module jaa_tb();

    reg clk = 1;
    reg reset = 1;

    always #5 clk = ~clk;

    jaa unit_under_test(
        .clk(clk),
        .reset(reset)
    );

    initial
        begin
            #10000 $stop;
        end

endmodule