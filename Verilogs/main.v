module JAA (clk, reset);
    parameter
        READ_OPCODE = 0,
        READ_OPERAND = 1,
        GENERATE_ARM_INSTRA = 2;
    input clk, reset;
    reg state, next_state;
    reg [7:0] java_opcode, first_opd, second_opd;
    integer num_of_opd = 0;
    
    initial
    	begin
    		result = $fopen("result.txt","w");
    	end
    	
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
		                // read java opcode from ROM and assign it to java_opcode
		                // set num_of_opd value regarding to java_opcode
		                if(num_of_opd == 0)
		                    next_state = GENERATE_ARM_INSTRA;
		                else
		                    next_state = READ_OPERAND;
		            end
		        READ_OPERAND:
		            begin
		                if(num_of_opd == 1)
		                    begin
		                        // first_opd = ROM output
		                        num_of_opd = 0;
		                        next_state = GENERATE_ARM_INSTRA;
		                    end
		                else
		                    begin
		                        // second_opd = ROM output
		                        num_of_opd = 1;
		                    end
		            end
		        GENERATE_ARM_INSTRA:
		            begin
		                case(java_opcode)
			                8'b0000_0011: //iconst_0
					            begin
					                $fwrite(result,"%b\n", mov_instr(1, 4'b1, 11'b0));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0000_0100: //iconst_1
					            begin
					                $fwrite(result,"%b\n", mov_instr(1, 4'b1, 11'b1));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0000_0101: //iconst_2
					            begin
					                $fwrite(result,"%b\n", mov_instr(1, 4'b1, 11'b10));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0000_0110: //iconst_3
					            begin
					                $fwrite(result,"%b\n", mov_instr(1, 4'b1, 11'b11));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0000_0111: //iconst_4
					            begin
					                $fwrite(result,"%b\n", mov_instr(1, 4'b1, 11'b100));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0000_1000: //iconst_5
					            begin
					                $fwrite(result,"%b\n", mov_instr(1, 4'b1, 11'b101));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0011_1011: //istore_0
					            begin
					                $fwrite(result,"%b\n", pop_instr(16'b10));
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b0, 1));
					            end
					        8'b0011_1100: //istore_1
					            begin
					                $fwrite(result,"%b\n", pop_instr(16'b10));
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b1, 1));
					            end
					        8'b0011_1101: //istore_2
					            begin
					                $fwrite(result,"%b\n", pop_instr(16'b10));
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b10, 1));
					            end
					        8'b0011_1110: //istore_3
					            begin
					                $fwrite(result,"%b\n", pop_instr(16'b10));
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b11, 1));
					            end
					        8'b0001_1010: //iload_0
					            begin
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b0, 0));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0001_1011: //iload_1
					            begin
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b1, 0));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0001_1100: //iload_2
					            begin
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b10, 0));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0001_1101: //iload_3
					            begin
					                $fwrite(result,"%b\n", str_ldr_instr(4'b11, 4'b1, 12'b11, 0));
					                $fwrite(result,"%b\n", push_instr(16'b10));
					            end
					        8'b0110_0000: //iadd
					            begin
					                $fwrite(result,"%b\n", pop_instr(16'b110));
					                $fwrite(result,"%b\n", add_sub_instr(0, 1, 4'b1, 4'b0, 12'b10));
					            end
		                endcase
		            end
		    endcase
        end
    
    function [31:0] pop_instr;
        localparam [15:0] instr_prefix = 16'b1110_1000_1011_1101;
        input [15:0] register_index;
        
        begin
            pop_instr = {instr_prefix, register_index};
        end
    endfunction
    
    function [31:0] push_instr;
        localparam [15:0] instr_prefix = 16'b1110_1001_0010_1101;
        input [15:0] register_index;
        
        begin
            push_instr = {instr_prefix, register_index};
        end
    endfunction
    
    function [31:0] add_sub_instr;
        localparam [6:0] instr_prefix = 6'b111000;
        localparam [4:0] add_opcode = 4'b0100;
        localparam [4:0] sub_opcode = 4'b0010;
        input is_second_opd_imm, is_add;
        input [3:0] first_opd_reg_index, dest_reg_index;
        input [11:0] second_opd;
        reg [4:0] opcode;
        
        begin
            if(is_add)
                opcode = add_opcode;
            else
                opcode = sub_opcode;
        
            if(is_second_opd_imm)
                add_sub_instr = {instr_prefix, is_second_opd_imm,
                opcode, 1'b0, first_opd_reg_index,
                dest_reg_index, second_opd};
            else
                add_sub_instr = {instr_prefix, is_second_opd_imm,
                opcode, 1'b0, first_opd_reg_index,
                dest_reg_index, second_opd};
        end
    endfunction
    
    function [31:0] mov_instr;
        localparam [6:0] instr_prefix = 6'b111000;
        localparam [4:0] mov_opcode = 4'b1101;
        localparam first_opd_reg_index = 4'b0000;
        input is_second_opd_imm;
        input [3:0] dest_reg_index;
        input [11:0] second_opd;
        
        begin
            if(is_second_opd_imm)
                mov_instr = {instr_prefix, is_second_opd_imm,
                mov_opcode, 1'b0, first_opd_reg_index,
                dest_reg_index, second_opd};
            else
                mov_instr = {instr_prefix, is_second_opd_imm,
                mov_opcode, 1'b0, first_opd_reg_index,
                dest_reg_index, second_opd};
        end
    endfunction
    
    function [31:0] str_ldr_instr;
        localparam [11:0] ldr_instr_prefix = 12'b1110_0101_1001;
        localparam [11:0] str_instr_prefix = 12'b1110_0101_1000;
        input [3:0] dest_reg_index, mem_addr_reg_index;
        input [11:0] offset;
        input is_str;
        
        begin
            if(is_str)
                str_ldr_instr = {str_instr_prefix, mem_addr_reg_index,
                    dest_reg_index, offset};
            else
                str_ldr_instr = {ldr_instr_prefix, mem_addr_reg_index,
                    dest_reg_index, offset};
        end
    endfunction
endmodule


module ROM(clk, addr, data);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 6;
    parameter DEPTH = 1 << ADDR_WIDTH;
    input clk;
    input [ADDR_WIDTH - 1:0] addr;
    output reg [DATA_WIDTH - 1:0] data;
    
    reg [ADDR_WIDTH - 1:0] rom [DEPTH - 1:0];
    
    initial
        begin
            $readmemb("rom.data", rom);
        end

    always @(posedge clk)
        begin
            data <= rom[addr];
        end
endmodule






