`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    21:48:55 06/09/2018
// Design Name:
// Module Name:    JAA
// Project Name:    JAA
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module jaa(
  input clk,
  input reset,
  output reg [7:0] data
);

  parameter START = 3'b000;
  parameter READ_OPCODE = 3'b001;
  parameter READ_OPERAND = 3'b010;
  parameter FETCH_FROM_CONSTANT_POOL = 3'b011;
  parameter GENERATE_ARM_INSTRUCTION = 3'b100;
  parameter DATA_WIDTH = 7;
  parameter CURSOR_WIDTH = 9;
  reg [2:0] state = START;
  reg [1:0] next_state = READ_OPCODE;
  reg [DATA_WIDTH:0] java_opcode;
  reg [DATA_WIDTH:0] first_operand;
  reg [DATA_WIDTH:0] second_operand;
  reg [DATA_WIDTH:0] rom [0:1023]; // 1024 bytes
  reg [CURSOR_WIDTH:0] cursor = 0; // 0 to 1023
  reg [1:0] num_of_operand = 0;
  reg [191:0] instructions;
  reg [2:0] quantity;
  reg write_enable = 0;
  integer result;

  initial
    begin
      result = $fopen("result.txt","w");
      $readmemh("input_bytecode_1.txt", rom);
    end

  memory_writer mw(
    .clk(clk),
    .write_enable(write_enable),
    .instructions(instructions),
    .quantity(quantity)
  );

  // manage states
  always @(posedge clk)
    begin
      data <= rom[cursor];
      if(reset)
        state <= START;
      else
        state <= next_state;
    end

  always @(*)
    begin
      case(state)
        START:
          begin
            next_state = READ_OPCODE;
            num_of_operand = 0;
            cursor = 0;
          end
        READ_OPCODE:
          begin
            java_opcode = data;
            case(java_opcode)
              8'b0000_0011, //iconst_0
              8'b0000_0100, //iconst_1
              8'b0000_0101, //iconst_2
              8'b0000_0110, //iconst_3
              8'b0000_0111, //iconst_4
              8'b0000_1000, //iconst_5
              8'b0011_1011, //istore_0
              8'b0011_1100, //istore_1
              8'b0011_1101, //istore_2
              8'b0011_1110, //istore_3
              8'b0001_1010, //iload_0
              8'b0001_1011, //iload_1
              8'b0001_1100, //iload_2
              8'b0001_1101, //iload_3
              8'b0110_0000, //iadd
              8'b0101_1001, //dup
              8'b0101_1010, //dup_x1
              8'b0101_1011, //dup_x2
              8'b0101_1100, //dup2
              8'b0101_1101, //dup2_x1
              8'b0101_1110, //dup2_x2
              8'b0101_1111: // swap
                begin
                  next_state = GENERATE_ARM_INSTRUCTION;
                  num_of_operand = 0;
                  cursor = cursor + 1'b1;
                end
              8'b0011_0110, //istore operand
              8'b0001_0101: // iload operand
                begin
                  next_state = READ_OPERAND;
                  num_of_operand = 1;
                  cursor = cursor + 1'b1;
                end
              default:
                begin
                  next_state = READ_OPCODE;
                  num_of_operand = 0;
                  cursor = cursor + 1'b1;
                  $display("Not supported. %b %d ", java_opcode,cursor);
                end
            endcase
          end
        READ_OPERAND:
          begin
            if(num_of_operand == 1)
              begin
                case(java_opcode)
                  8'b0011_0110, // istore operand
                  8'b0001_0101: // iload operand
                    begin
                      first_operand = data;
                    end
                endcase
                next_state = GENERATE_ARM_INSTRUCTION;
                cursor = cursor + 1'b1;
              end
            num_of_operand = num_of_operand - 1'b1;
          end
        GENERATE_ARM_INSTRUCTION:
          begin
            $display("Opcode : %h %d", java_opcode,cursor);
            next_state = READ_OPCODE;
            num_of_operand = 0;
            cursor = cursor;
            case (java_opcode)
              8'b0000_0011: //iconst_0
                begin
                  $display("%b", mov_instruction(1, 4'b0001, 11'b0));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0000_0100: //iconst_1
                begin
                  instructions = {push_instruction(16'b10),mov_instruction(1, 4'b0001, 11'b1)};
                  quantity = 3'b010;
                  $display("%b", mov_instruction(1, 4'b0001, 11'b1));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0000_0101: //iconst_2
                begin
                  $display("%b", mov_instruction(1, 4'b0001, 11'b10));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0000_0110: //iconst_3
                begin
                  $display("%b", mov_instruction(1, 4'b0001, 11'b11));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0000_0111: //iconst_4
                begin
                  $display("%b", mov_instruction(1, 4'b0001, 11'b100));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0000_1000: //iconst_5
                begin
                  $display("%b", mov_instruction(1, 4'b0001, 11'b101));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0011_1011: //istore_0
                begin
                  $display("%b", pop_instruction(16'b1));
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b0, 1));
                end
              8'b0011_1100: //istore_1
                begin
                  $display("%b", pop_instruction(16'b1));
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b1, 1));
                end
              8'b0011_1101: //istore_2
                begin
                  $display("%b", pop_instruction(16'b1));
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b10, 1));
                end
              8'b0011_1110: //istore_3
                begin
                  $display("%b", pop_instruction(16'b1));
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b11, 1));
                end
              8'b0001_1010: //iload_0
                begin
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b0, 0));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0001_1011: //iload_1
                begin
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b1, 0));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0001_1100: //iload_2
                begin
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b10, 0));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0001_1101: //iload_3
                begin
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, 12'b11, 0));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0110_0000: //iadd
                begin
                  $display("%b", pop_instruction(16'b110));
                  $display("%b", add_sub_instruction(0, 1, 4'b0001, 4'b0, 12'b10));
                end
              8'b0101_1001: //dup
                begin
                  $display("%b", pop_instruction(16'b1));
                  $display("%b", push_instruction(16'b1));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0101_1010: //dup_x1
                begin
                  $display("%b", pop_instruction(16'b11));
                  $display("%b", push_instruction(16'b10));
                  $display("%b", push_instruction(16'b11));
                end
              8'b0101_1011: //dup_x2
                begin
                  $display("%b", pop_instruction(16'b111));
                  $display("%b", push_instruction(16'b100));
                  $display("%b", push_instruction(16'b10));
                  $display("%b", push_instruction(16'b101));
                end
              8'b0101_1100: //dup2
                begin
                  $display("%b", pop_instruction(16'b11));
                  $display("%b", push_instruction(16'b10));
                  $display("%b", push_instruction(16'b11));
                  $display("%b", push_instruction(16'b1));
                end
              8'b0101_1101: //dup2_x1
                begin
                  $display("%b", pop_instruction(16'b111));
                  $display("%b", push_instruction(16'b100));
                  $display("%b", push_instruction(16'b10));
                  $display("%b", push_instruction(16'b101));
                  $display("%b", push_instruction(16'b10));
                end
              8'b0101_1110: //dup2_x2
                begin
                  $display("%b", pop_instruction(16'b1111));
                  $display("%b", push_instruction(16'b1000));
                  $display("%b", push_instruction(16'b100));
                  $display("%b", push_instruction(16'b10));
                  $display("%b", push_instruction(16'b1001));
                  $display("%b", push_instruction(16'b100));
                end
              8'b0101_1111: // swap
                begin
                  $display("%b", pop_instruction(16'b11));
                  $display("%b", push_instruction(16'b11));
                end
              8'b0011_0110: // istore operand
                begin
                  $display("%b", pop_instruction(16'b10));
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, first_operand, 1));
                end
              8'b0001_0101: // iload operand
                begin
                  $display("%b", str_ldr_instruction(4'b0011, 4'b0001, first_operand, 0));
                  $display("%b", push_instruction(16'b10));
                end
              default:
                begin
                  $display("Not supported. %b", java_opcode);
                end
            endcase
          end
      endcase
    end

  function [31:0] pop_instruction;
    localparam [15:0] instruction_prefix = 16'b1110_1000_1011_1101;
    input [15:0] register_index;

    begin
      pop_instruction = {instruction_prefix, register_index};
    end
  endfunction

  function [31:0] push_instruction;
    localparam [15:0] instruction_prefix = 16'b1110_1001_0010_1101;
    input [15:0] register_index;

    begin
      push_instruction = {instruction_prefix, register_index};
    end
  endfunction

  function [31:0] add_sub_instruction;
    localparam [5:0] instruction_prefix = 6'b111000;
    localparam [3:0] add_opcode = 4'b0100;
    localparam [3:0] sub_opcode = 4'b0010;
    input is_second_operand_imm, is_add;
    input [3:0] first_operand_reg_index, dest_reg_index;
    input [11:0] second_operand;
    reg [3:0] opcode;

    begin
      if(is_add)
        opcode = add_opcode;
      else
        begin
          opcode = sub_opcode;
        end
      add_sub_instruction = {
        instruction_prefix,
        is_second_operand_imm,
        opcode,
        1'b0,
        first_operand_reg_index,
        dest_reg_index,
        second_operand
      };
    end
  endfunction

  function [31:0] mov_instruction;
    localparam [5:0] instruction_prefix = 6'b111000;
    localparam [3:0] mov_opcode = 4'b1101;
    localparam first_operand_reg_index = 4'b0000;
    input is_second_operand_imm;
    input [3:0] dest_reg_index;
    input [11:0] second_operand;

    begin
      mov_instruction = {
        instruction_prefix,
        is_second_operand_imm,
        mov_opcode,
        1'b0,
        first_operand_reg_index,
        dest_reg_index,
        second_operand
      };
    end
  endfunction

  function [31:0] str_ldr_instruction;
    localparam [11:0] ldr_instruction_prefix = 12'b1110_0101_1001;
    localparam [11:0] str_instruction_prefix = 12'b1110_0101_1000;
    input [3:0] dest_reg_index, mem_address_reg_index;
    input [11:0] offset;
    input is_str;

    begin
      if(is_str)
        str_ldr_instruction = {
          str_instruction_prefix,
          mem_address_reg_index,
          dest_reg_index,
          offset
        };
      else
        str_ldr_instruction = {
          ldr_instruction_prefix,
          mem_address_reg_index,
          dest_reg_index,
          offset
        };
    end
  endfunction

endmodule