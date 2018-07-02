module jaa_tb();

  reg clk = 1;
  reg reset = 1;
  wire [7:0] data;

  always #5 clk = ~clk;

  jaa unit_under_test(
    .clk(clk),
    .reset(reset),
    .data(data)
  );

  initial
    begin
      #2 reset = 0;
      #800 $stop;
    end

endmodule