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
`include "header.v"
module jaa(
    input clk,
    input reset
    );

    parameter READ_OPCODE = 0;
    parameter READ_OPERAND = 1;
    parameter GENERATE_ARM_INSTRUCTION = 2;
    reg [1:0] state;
    reg [1:0] next_state;
    reg [7:0] java_opcode;
    reg [7:0] first_operand;
    reg [7:0] second_operand;
    wire [7:0] data;
    integer num_of_operand = 0;
    integer result;

    initial
        begin
    		result = $fopen("result.txt","w");
   	    end

    // here we`re gonna to setup ROM
    // add enable handling to file_reader module.
    // in this situation module read bytes clock by clock (bad solution)
    file_reader file_reader_inst(
        .clk(clk),
        .data(data)
    );

    // manage states
    always @(posedge clk)
        begin
            if(reset)
                state <= READ_OPCODE;
            else
                state <= next_state;
        end

    always @(*)
        begin
            next_state = state;
		    case(state)
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
                        8'b0110_0000: //iadd
                          begin
                            num_of_operand = ...;
                          end

		                if(num_of_operand == 0)
		                    next_state = GENERATE_ARM_INSTRUCTION;
		                else
		                    next_state = READ_OPERAND;
		            end
		        READ_OPERAND:
		            begin
		                if(num_of_operand == 1)
		                    begin
		                        first_operand = data;
		                        next_state = GENERATE_ARM_INSTRUCTION;
		                    end
		                else if(num_of_operand == 2)
		                    begin
                            second_operand = data;
		                    end
                    num_of_operand = num_of_operand - 1;
		            end
		        GENERATE_ARM_INSTRUCTION:
		            begin
		                case(java_opcode)
			                8'b0000_0011: //iconst_0
					            begin
					                $display("%b\n", mov_instruction(1, 4'b1, 11'b0));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0000_0100: //iconst_1
					            begin
					                $display("%b\n", mov_instruction(1, 4'b1, 11'b1));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0000_0101: //iconst_2
					            begin
					                $display("%b\n", mov_instruction(1, 4'b1, 11'b10));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0000_0110: //iconst_3
					            begin
					                $display("%b\n", mov_instruction(1, 4'b1, 11'b11));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0000_0111: //iconst_4
					            begin
					                $display("%b\n", mov_instruction(1, 4'b1, 11'b100));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0000_1000: //iconst_5
					            begin
					                $display("%b\n", mov_instruction(1, 4'b1, 11'b101));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0011_1011: //istore_0
					            begin
					                $display("%b\n", pop_instruction(16'b10));
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b0, 1));
					            end
					        8'b0011_1100: //istore_1
					            begin
					                $display("%b\n", pop_instruction(16'b10));
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b1, 1));
					            end
					        8'b0011_1101: //istore_2
					            begin
					                $display("%b\n", pop_instruction(16'b10));
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b10, 1));
					            end
					        8'b0011_1110: //istore_3
					            begin
					                $display("%b\n", pop_instruction(16'b10));
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b11, 1));
					            end
					        8'b0001_1010: //iload_0
					            begin
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b0, 0));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0001_1011: //iload_1
					            begin
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b1, 0));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0001_1100: //iload_2
					            begin
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b10, 0));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0001_1101: //iload_3
					            begin
					                $display("%b\n", str_ldr_instruction(4'b11, 4'b1, 12'b11, 0));
					                $display("%b\n", push_instruction(16'b10));
					            end
					        8'b0110_0000: //iadd
					            begin
					                $display("%b\n", pop_instruction(16'b110));
					                $display("%b\n", add_sub_instruction(0, 1, 4'b1, 4'b0, 12'b10));
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
        localparam [6:0] instruction_prefix = 6'b111000;
        localparam [4:0] add_opcode = 4'b0100;
        localparam [4:0] sub_opcode = 4'b0010;
        input is_second_operand_imm, is_add;
        input [3:0] first_operand_reg_index, dest_reg_index;
        input [11:0] second_operand;
        reg [4:0] opcode;

        begin
            if(is_add)
                opcode = add_opcode;
            else
                opcode = sub_opcode;
            if(is_second_operand_imm)
                add_sub_instruction = {
                instruction_prefix,
                is_second_operand_imm,
                opcode,
                1'b0,
                first_operand_reg_index,
                dest_reg_index,
                second_operand
                };
            else
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
        localparam [6:0] instruction_prefix = 6'b111000;
        localparam [4:0] mov_opcode = 4'b1101;
        localparam first_operand_reg_index = 4'b0000;
        input is_second_operand_imm;
        input [3:0] dest_reg_index;
        input [11:0] second_operand;

        begin
            if(is_second_operand_imm)
                mov_instruction = {
                instruction_prefix,
                is_second_operand_imm,
                mov_opcode,
                1'b0,
                first_operand_reg_index,
                dest_reg_index,
                second_operand
                };
            else
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
