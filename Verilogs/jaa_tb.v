module jaa_tb();

  reg clk = 1;
  reg reset = 1;
  wire [31:0] arm_instruction;

  always #10 clk = ~clk;

  jaa unit_under_test(
    .clk(clk),
    .reset(reset),
    .arm_instruction(arm_instruction)
  );

  initial
    begin
      #2 reset = 0;
      #500 $stop;
    end

endmodule