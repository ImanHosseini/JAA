module JAA;
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
        input is_str;
        
        begin
            if(is_str)
                str_ldr_instr = {str_instr_prefix, mem_addr_reg_index,
                    dest_reg_index, 12'b0};
            else
                str_ldr_instr = {ldr_instr_prefix, mem_addr_reg_index,
                    dest_reg_index, 12'b0};
        end
    endfunction
    
    function [31:0] generate_arm_insrt;
        parameter DATA_WIDTH = 8;
        input [DATA_WIDTH - 1:0] bytecode_opcode;
        
        case(bytecode_opcode)
            8'b0000_0011: //iconst_0
                begin
                    
                end
            8'b0000_0100: //iconst_1
                begin
                
                end
            8'b0000_0101: //iconst_2
                begin
                
                end
            8'b0000_0110: //iconst_3
                begin
                
                end
            8'b0000_0111: //iconst_4
                begin
                
                end
            8'b0000_1000: //iconst_5
                begin
                
                end
            8'b0011_1011: //istore_0
                begin
                
                end
            8'b0011_1100: //istore_1
                begin
                
                end
            8'b0011_1101: //istore_2
                begin
                
                end
            8'b0011_1110: //istore_3
                begin
                
                end
            8'b0001_1010: //iload_0
                begin
                
                end
            8'b0001_1011: //iload_1
                begin
                
                end
            8'b0001_1100: //iload_2
                begin
                
                end
            8'b0001_1101: //iload_3
                begin
                
                end
            8'b0110_0000: //iadd
                begin
                
                end
        endcase
    endfunction
endmodule


module ROM(addr, data);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 6;
    parameter DEPTH = 1 << ADDR_WIDTH;
    input [ADDR_WIDTH - 1:0] addr;
    output [DATA_WIDTH - 1:0] data;
    
    reg [ADDR_WIDTH - 1:0] rom [DEPTH - 1:0];
    
    initial
        begin
            $readmemb("rom.data", rom);
        end
        
    assign data = rom[addr];
endmodule