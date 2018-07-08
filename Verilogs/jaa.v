`timescale 1ns / 1ps
module jaa(
  input clk,
  input reset,
  output [7:0] data
);

  // States
  parameter START = 3'b000;
  parameter READ_OFFSETS = 3'b001;
  parameter READ_OPCODE = 3'b010;
  parameter READ_OPERAND = 3'b011;
  parameter FETCH_FROM_CONSTANT_POOL = 3'b100;
  parameter GENERATE_ARM_INSTRUCTION = 3'b111;
  parameter STOP = 3'b101;
  // Constants
  parameter BYTE_WIDTH = 7;
  parameter CURSOR_WIDTH = 15; // Based on .jb format
  // Cursor Constants
  parameter CURSOR_START = 16'b110;
  parameter CP_TABLE_START = 16'b1010; // 11'th byte
  reg [2:0] state = START;
  reg [2:0] next_state = READ_OPCODE;
  reg [15:0] cp_data_offset;
  reg [15:0] cp_code_offset;
  reg [BYTE_WIDTH:0] java_opcode;
  reg [BYTE_WIDTH:0] first_operand;
  reg [CURSOR_WIDTH:0] cursor = CURSOR_START; // 0 to 1023
  reg [CURSOR_WIDTH:0] next_cursor = CURSOR_START; // 0 to 1023
  reg [191:0] instructions; // For writing on memory
  reg [3:0] quantity; // Indicates the number of ARM instrucions generated by the last java bytecode
  reg write_enable = 0;
  reg [2:0] offset_state;
  reg [2:0] next_offset_state;
  wire [15:0] size;

  rom r(
    .address(cursor),
    .size(size),
    .data(data)
  );

  memory_writer mw(
    .clk(clk),
    .write_enable(write_enable),
    .instructions(instructions),
    .quantity(quantity)
  );

  // manage states and memory
  always @(posedge clk)
    begin
      if(reset)
        state <= START;
      else
        if (cursor <= size)
          begin
            state <= next_state;
            cursor <= next_cursor;
            offset_state <= next_offset_state;
          end
        else
          state <= STOP;
    end

  always @(*)
    begin
      case(state)
        START:
          begin
            next_state = READ_OFFSETS;
            write_enable = 0;
            next_cursor = CURSOR_START;
            next_offset_state = 3'b000;
          end
        READ_OFFSETS:
          begin
            write_enable = 0;
            case (offset_state)
              3'b000:
                begin
                  cp_data_offset[15:8] = data;
                  next_cursor = cursor + 1'b1;
                  next_state = READ_OFFSETS;
                  next_offset_state = 3'b001;
                end
              3'b001:
                begin
                  cp_data_offset[7:0] = data;
                  next_cursor = cursor + 1'b1;
                  next_state = READ_OFFSETS;
                  next_offset_state = 3'b010;
                end
              3'b010:
                begin
                  cp_code_offset[15:8] = data;
                  next_cursor = cursor + 1'b1;
                  next_state = READ_OFFSETS;
                  next_offset_state = 3'b011;
                end
              3'b011:
                begin
                  cp_code_offset[7:0] = data;
                  next_cursor = cp_code_offset;
                  next_state = READ_OFFSETS;
                  next_offset_state = 3'b100;
                end
              3'b100:
                begin
                  next_state = READ_OPCODE;
                end
            endcase
          end
        READ_OPCODE:
          begin
            java_opcode = data;
            write_enable = 0;
            next_cursor = next_cursor + 1'b1;
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
              8'b0101_1111, //swap
              8'b0111_1110, //iand
              8'b1000_0010: //ixor
                begin
                  next_state = GENERATE_ARM_INSTRUCTION;
                end
              8'b0011_0110, //istore operand
              8'b0001_0101, //iload operand
              8'b0001_0000: //bipush
                begin
                  next_state = READ_OPERAND;
                end
              default:
                begin
                  next_state = READ_OPCODE;
                  $display("Not supported. %b %d ", java_opcode,cursor);
                end
            endcase
          end
        READ_OPERAND:
          begin
            write_enable = 0;
            first_operand = data;
            next_state = GENERATE_ARM_INSTRUCTION;
            next_cursor = next_cursor + 1'b1;
          end
        FETCH_FROM_CONSTANT_POOL:
          begin
            next_state = GENERATE_ARM_INSTRUCTION;
            next_cursor = next_cursor + 1'b1;
            //{rom[CP_TABLE_START],rom[CP_TABLE_START +  1]} + cp_data_offset  -> address of starting byte(just use this)
          end
        GENERATE_ARM_INSTRUCTION:
          begin
            $display("Opcode : %h %d", java_opcode, cursor);
            next_state = READ_OPCODE;
            write_enable = 1;
            next_cursor = next_cursor;
            case (java_opcode)
              8'b0000_0011: //iconst_0
                begin
                  instructions = {
                    push_instruction(16'b10),
                    mov_instruction(1, 4'b0001, 11'b0)
                  };
                  quantity = 3'b010;
                end
              8'b0000_0100: //iconst_1
                begin
                  instructions = {
                    push_instruction(16'b10),
                    mov_instruction(1, 4'b0001, 11'b1)
                  };
                  quantity = 3'b010;
                end
              8'b0000_0101: //iconst_2
                begin
                  instructions = {
                    push_instruction(16'b10),
                    mov_instruction(1, 4'b0001, 11'b10)
                  };
                  quantity = 3'b010;
                end
              8'b0000_0110: //iconst_3
                begin
                  instructions = {
                    push_instruction(16'b10),
                    mov_instruction(1, 4'b0001, 11'b11)
                  };
                  quantity = 3'b010;
                end
              8'b0000_0111: //iconst_4
                begin
                  instructions = {
                    push_instruction(16'b10),
                    mov_instruction(1, 4'b0001, 11'b100)
                  };
                  quantity = 3'b010;
                end
              8'b0000_1000: //iconst_5
                begin
                  instructions = {
                    push_instruction(16'b10),
                    mov_instruction(1, 4'b0001, 11'b101)
                  };
                  quantity = 3'b010;
                end
              8'b0011_1011: //istore_0
                begin
                  instructions = {
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b0, 1),
                    pop_instruction(16'b1)
                  };
                  quantity = 3'b010;
                end
              8'b0011_1100: //istore_1
                begin
                  instructions = {
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b1, 1),
                    pop_instruction(16'b1)
                  };
                  quantity = 3'b010;
                end
              8'b0011_1101: //istore_2
                begin
                  instructions = {
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b10, 1),
                    pop_instruction(16'b1)
                  };
                  quantity = 3'b010;
                end
              8'b0011_1110: //istore_3
                begin
                  instructions = {
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b11, 1),
                    pop_instruction(16'b1)
                  };
                  quantity = 3'b010;
                end
              8'b0001_1010: //iload_0
                begin
                  instructions = {
                    push_instruction(16'b10),
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b0, 0)
                  };
                  quantity = 3'b010;
                end
              8'b0001_1011: //iload_1
                begin
                  instructions = {
                    push_instruction(16'b10),
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b1, 0)
                  };
                  quantity = 3'b010;
                end
              8'b0001_1100: //iload_2
                begin
                  instructions = {
                    push_instruction(16'b10),
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b10, 0)
                  };
                  quantity = 3'b010;
                end
              8'b0001_1101: //iload_3
                begin
                  instructions = {
                    push_instruction(16'b10),
                    str_ldr_instruction(4'b0011, 4'b0001, 12'b11, 0)
                  };
                  quantity = 3'b010;
                end
              8'b0110_0000: //iadd
                begin
                  instructions = {
                    add_sub_instruction(0, 1, 4'b0001, 4'b0, 12'b10),
                    pop_instruction(16'b110)
                  };
                  quantity = 3'b010;
                end
              8'b0101_1001: //dup
                begin
                  instructions = {
                    push_instruction(16'b10),
                    push_instruction(16'b1),
                    pop_instruction(16'b1)
                  };
                  quantity = 3'b011;
                end
              8'b0101_1010: //dup_x1
                begin
                  instructions = {
                    push_instruction(16'b11),
                    push_instruction(16'b10),
                    pop_instruction(16'b11)
                  };
                  quantity = 3'b011;
                end
              8'b0101_1011: //dup_x2
                begin
                  instructions = {
                    push_instruction(16'b101),
                    push_instruction(16'b10),
                    push_instruction(16'b100),
                    pop_instruction(16'b111)
                  };
                  quantity = 3'b110;
                end
              8'b0101_1100: //dup2
                begin
                  instructions = {
                    push_instruction(16'b1),
                    push_instruction(16'b11),
                    push_instruction(16'b10),
                    pop_instruction(16'b11)
                  };
                  quantity = 3'b110;
                end
              8'b0101_1101: //dup2_x1
                begin
                  instructions = {
                    push_instruction(16'b10),
                    push_instruction(16'b101),
                    push_instruction(16'b10),
                    push_instruction(16'b100),
                    pop_instruction(16'b111)
                  };
                  quantity = 3'b101;
                end
              8'b0101_1110: //dup2_x2
                begin
                  instructions = {
                    push_instruction(16'b100),
                    push_instruction(16'b1001),
                    push_instruction(16'b10),
                    push_instruction(16'b100),
                    push_instruction(16'b1000),
                    pop_instruction(16'b1111)
                  };
                  quantity = 3'b110;
                end
              8'b0101_1111: //swap
                begin
                  instructions = {
                    push_instruction(16'b11),
                    pop_instruction(16'b11)
                  };
                  quantity = 3'b010;
                end
              8'b0011_0110: //istore operand
                begin
                  instructions = {
                    str_ldr_instruction(4'b0011, 4'b0001, first_operand, 1),
                    pop_instruction(16'b10)
                  };
                  quantity = 3'b010;
                end
              8'b0001_0101: //iload operand
                begin
                  instructions = {
                    push_instruction(16'b10),
                    str_ldr_instruction(4'b0011, 4'b0001, first_operand, 0)
                  };
                  quantity = 3'b010;
                end
              8'b0001_0000: //bipush
                //check this one
                begin
                  instructions = {
                    push_instruction(16'b10),
                    mov_instruction(0, 4'b0001, first_operand)
                  };
                  quantity = 3'b010;
                end
              8'b0111_1110: //iand
                begin
                  instructions = {
                    push_instruction(16'b0),
                    and_xor_instruction(0, 1, 4'b0001, 4'b0, 12'b10),
                    pop_instruction(16'b110)
                  };
                  quantity = 3'b011;
                end
              8'b1000_0010: //ixor
                begin
                  instructions = {
                    push_instruction(16'b0),
                    and_xor_instruction(0, 0, 4'b0001, 4'b0, 12'b10),
                    pop_instruction(16'b110)
                  };
                  quantity = 3'b011;
                end
              default:
                begin
                  $display("Not supported. %b", java_opcode);
                end
            endcase
          end
        STOP:
          begin
            write_enable = 0;
            $display("Stop");
          end
        default: // Same as START state
          begin
            next_state = READ_OFFSETS;
            write_enable = 0;
            next_cursor = CURSOR_START;
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

  function [31:0] and_xor_instruction;
    localparam [5:0] instruction_prefix = 6'b111000;
    localparam [3:0] and_opcode = 4'b0000;
    localparam [3:0] xor_opcode = 4'b0001;
    input is_second_operand_imm, is_and;
    input [3:0] first_operand_reg_index, dest_reg_index;
    input [11:0] second_operand;
    reg [3:0] opcode;

    begin
      if(is_and)
        opcode = and_opcode;
      else
        begin
          opcode = xor_opcode;
        end
      and_xor_instruction = {
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