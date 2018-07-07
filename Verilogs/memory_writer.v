module memory_writer(
  input clk,
  input write_enable,
  input [191:0] instructions,
  input [3:0] quantity
);

  reg [31:0] ram [0:1023];
  reg [9:0] cursor = 0; // 0 to 1023

  always @(posedge clk)
    begin
      if(write_enable)
        begin
          case (quantity)
            3'b010:
              begin
                ram[cursor] = instructions[31:0];
                ram[cursor+1'b1] = instructions[63:32];
                $display("new new new :%b", instructions[31:0]);
                $display("new new new :%b", instructions[63:32]);
                cursor = cursor + 2'b10;
              end
            3'b011:
              begin
                ram[cursor] = instructions[31:0];
                ram[cursor+1'b1] = instructions[63:32];
                ram[cursor+2'b10] = instructions[95:64];
                $display("new new new :%b", instructions[31:0]);
                $display("new new new :%b", instructions[63:32]);
                $display("new new new :%b", instructions[95:64]);
                cursor = cursor + 2'b11;
              end
            3'b100:
              begin
                ram[cursor] = instructions[31:0];
                ram[cursor+1'b1] = instructions[63:32];
                ram[cursor+2'b10] = instructions[95:64];
                ram[cursor+2'b11] = instructions[127:96];
                $display("new new new :%b", instructions[31:0]);
                $display("new new new :%b", instructions[63:32]);
                $display("new new new :%b", instructions[95:64]);
                $display("new new new :%b", instructions[127:96]);
                cursor = cursor + 3'b100;
              end
            3'b101:
              begin
                ram[cursor] = instructions[31:0];
                ram[cursor+1'b1] = instructions[63:32];
                ram[cursor+2'b10] = instructions[95:64];
                ram[cursor+2'b11] = instructions[127:96];
                ram[cursor+3'b100] = instructions[159:128];
                $display("new new new :%b", instructions[31:0]);
                $display("new new new :%b", instructions[63:32]);
                $display("new new new :%b", instructions[95:64]);
                $display("new new new :%b", instructions[127:96]);
                $display("new new new :%b", instructions[159:128]);
                cursor = cursor + 3'b101;
              end
            3'b110:
              begin
                ram[cursor] = instructions[31:0];
                ram[cursor+1'b1] = instructions[63:32];
                ram[cursor+2'b10] = instructions[95:64];
                ram[cursor+2'b11] = instructions[127:96];
                ram[cursor+3'b100] = instructions[159:128];
                ram[cursor+3'b101] = instructions[191:160];
                $display("new new new :%b", instructions[31:0]);
                $display("new new new :%b", instructions[63:32]);
                $display("new new new :%b", instructions[95:64]);
                $display("new new new :%b", instructions[127:96]);
                $display("new new new :%b", instructions[159:128]);
                $display("new new new :%b", instructions[191:160]);
                cursor = cursor + 3'b110;
              end
          endcase
        end
    end

endmodule