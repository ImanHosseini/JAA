`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    21:48:55 06/09/2018
// Design Name:
// Module Name:    JAA
// Project Name:
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
	output reg [31:0] arm_instruction
    );

    parameter READ_OPCODE = 0;
    parameter READ_OPERAND = 1;
    parameter GENERATE_ARM_INSTRUCTION = 2;
    reg [1:0] state = READ_OPCODE;
    reg [1:0] next_state = READ_OPCODE;
    reg [7:0] java_opcode;
    reg [7:0] first_operand;
    reg [7:0] second_operand;
    reg [7:0] data;
    reg [1:0] num_of_operand = 0;
    integer result;

    parameter DATA_WIDTH = 7;
    parameter CURSOR_WIDTH = 9;
    reg [DATA_WIDTH:0] rom [0:1023]; // 1024 bytes
    reg [CURSOR_WIDTH:0] cursor = 0; // 0 to 1023

    initial
        begin
    		result = $fopen("result.txt","w");
    		$readmemh("input_bytecode_1.txt", rom);
   	    end

    // manage states
    always @(posedge clk)
        begin
            data <= rom[cursor];
            cursor <= cursor + 1'b1;
            if(reset)
                state <= READ_OPCODE;
            else
                state <= next_state;
        end

    always @(*)
        begin
            $display("Read : %h",data);
            next_state = state;
            case(state)
                READ_OPCODE:
                    begin
                        java_opcode = data;
                        case(java_opcode)
                            8'b0000_0011: //iconst_0
                                begin
                                    $display("jaa :%b", mov_instruction(1, 4'b0001, 11'b0));
                                    $display("jaa :%b", push_instruction(16'b10));
                                end
                            8'b0000_0100: //iconst_1
                                begin
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
                            8'b0011_0110: //istore
                                begin
                                    next_state = READ_OPERAND;
                                    num_of_operand = 1;
                                end
                            8'b0101_1111: // swap
                                begin
                                    $display("%b", pop_instruction(16'b11));
                                    $display("%b", push_instruction(16'b11));
                                end

                            default:
                                begin
                                    next_state = READ_OPCODE;
                                    $display("Not supported. %b", java_opcode);
                                end
                        endcase
                    end
                READ_OPERAND:
                    begin
                        if(num_of_operand == 1)
                            begin
                                case(java_opcode)
                                    8'b0011_0110: //istore
                                        begin
                                            first_operand = data;
                                            $display("%b", pop_instruction(16'b10));
                                            $display("%b", str_ldr_instruction(4'b0011, 4'b0001, first_operand, 1));
                                        end
                                endcase
                                next_state = READ_OPCODE;
                            end
                        num_of_operand = num_of_operand - 1;
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