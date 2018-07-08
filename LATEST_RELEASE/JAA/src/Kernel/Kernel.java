package Kernel;

import Instructions.ARM_Instruction;
import Instructions.JVM_Instruction;

import static Instructions.JVM_Instruction.*;
import static Instructions.ARM_Instruction.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import static Tools.Utils.*;


/**
 * Created by ImanH on 5/10/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */

// Main computation happens here: read binary with JVM instructions and output ARM instructions


public class Kernel {



    static final int MAXINST = 10000;
    int pc = 0;
    int input_cursor;
    byte[] input_bytes;
    ARM_Instruction[] output;
    String out_asm="";


    public static void main(String[] args) throws IOException {
        showInfo();
        Kernel ker = new Kernel();
        ker.RunRaw(args[0]);
    }

    public void JB2ASM(String in,String out) throws Exception{
        byte[] jb_file = readFile(in);
        int code_offset = ((jb_file[8]&0xFF)<<8) | (jb_file[9]&0xFF);
        byte[] code = new byte[jb_file.length-code_offset];
        System.arraycopy(jb_file,10,code,0,jb_file.length-code_offset);
        input_bytes = new byte[code.length];
        System.arraycopy(code,0,input_bytes,0,code.length);

        int i = 0;

        output = new ARM_Instruction[MAXINST];
        // Bytecode translation
        for (input_cursor = 0; input_cursor < input_bytes.length; input_cursor++) {
            translateToARM(input_cursor);
        }

        writeOutputAsm(out_asm.getBytes(),out);
    }

    public void JB2ASM(String in) throws Exception{
        String out = in+".asm";
        JB2ASM(in,out);
    }



    public void RunRaw(String file) throws IOException {
        output = new ARM_Instruction[MAXINST];

            byte[] bytecode = readFile(file);
            // Test file reading
            prettyPrint(32, "INPUT-DISASSEMBLY");
            JVM_Instruction[] input_program;


        for (int in_cnt=0;in_cnt<bytecode.length;in_cnt++) {
            byte b = bytecode[in_cnt];
            JVM_Mnemonic jm = JVM_Instruction.Opcode_to_Mnemonic.get(Byte.toUnsignedInt(b));
            System.out.print(String.format("%02x ", b));
            int cnt = 0;
            if(JVM_Instruction.Operand_bytes.containsKey(jm)){
                cnt = JVM_Instruction.Operand_bytes.get(jm);
                in_cnt += cnt;
            }
            System.out.print(jm + "\n");
            for( int j=0 ;j<cnt;j++){
                System.out.print(" "+String.format("%02x ", bytecode[in_cnt+j+1]));
            }
            System.out.print("\n");
            in_cnt++;
        }
            prettyPrint(32, "ARM-OUTPUT");
            // Bytecode translation
        for (input_cursor = 0; input_cursor < input_bytes.length; input_cursor++) {
            translateToARM(input_cursor);
        }

            System.out.print(out_asm);
            prettyPrint("TASK-COMPLETED");


    }


    public void Disassemble(String file) throws Exception{

        byte[] bytecode = readFile(file);
        // Test file reading
        prettyPrint(32, "INPUT-DISASSEMBLY");
        JVM_Instruction[] input_program;
        input_program = new JVM_Instruction[bytecode.length];
        int i = 0;
        for (byte b : bytecode) {
            System.out.print(String.format("%02x ", b));
            if(!JVM_Instruction.Opcode_to_Mnemonic.containsKey(Byte.toUnsignedInt(b))){
                System.out.print("unknown opcode" + "\n");
            }
            System.out.print(JVM_Instruction.Opcode_to_Mnemonic.get(Byte.toUnsignedInt(b)) + "\n");
            input_program[i] = new JVM_Instruction(b);
            i++;
        }
    }




    public void translateToARM(int i) {
        JVM_Instruction j_inst = new JVM_Instruction(input_bytes[i]);
        JVM_Instruction.JVM_Mnemonic j_mn = j_inst.getJMnemonic();
        switch (j_mn) {
            case iconst_m1:
            case iconst_0:
            case iconst_1:
            case iconst_2:
            case iconst_3:
            case iconst_4:
            case iconst_5: {
                String sp = j_mn.toString().split("_")[1];
                // Special Weird Case
                if (sp.equals("m1")) {
                    ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.mvn, "r1", "#0");
                    addToOutput(ainst);
                    ainst = new ARM_Instruction(ARM_Mnemonic.push, "r1");
                    addToOutput(ainst);
                    return;
                }
                sp = "#" + sp;
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.mov, "r1", sp);
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.push, "r1");
                addToOutput(ainst);
                return;
            }
            case istore_0: case istore_1: case istore_2: case istore_3:{
                String sp = j_mn.toString().split("_")[1];
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r1");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.str, "r1","[r3,#"+sp+"]");
                addToOutput(ainst);
                return;
            }
            case istore:{
                int op = input_bytes[i+1];
                input_cursor++;
                String sp = Integer.toString(op);
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r1");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.str, "r1","[r3,#"+sp+"]");
                addToOutput(ainst);
                return;
            }
            case iload_0: case iload_1: case iload_2: case iload_3:{
                String sp = j_mn.toString().split("_")[1];
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.ldr, "r1","[r3,#"+sp+"]");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.push, "r1");
                addToOutput(ainst);
                return;
            }
            case iload:{
                int op = input_bytes[i+1];
                input_cursor++;
                String sp = Integer.toString(op);
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.ldr, "r1","[r3,#"+sp+"]");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.push, "r1");
                addToOutput(ainst);
                return;
            }
            case iadd:{
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r1","r2");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.add, "r0","r1","r2");
                addToOutput(ainst);
                return;
            }
            case nop:
                return;
            case returnn:
                return;
            case pop:{
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r0");
                addToOutput(ainst);
                return;
            }
            case pop2:{
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r0","r1");
                addToOutput(ainst);
                return;
            }
            case swap:{
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r0");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r1");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.push, "r0");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.push, "r1");
                addToOutput(ainst);
                return;
            }
            case isub:{
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.pop, "r1","r2");
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.sub, "r0","r1","r2");
                addToOutput(ainst);
                return;
            }
            case bipush:{
                int op = input_bytes[i+1];
                input_cursor++;
                String sp = Integer.toString(op);
                sp = "#" + sp;
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.mov, "r1", sp);
                addToOutput(ainst);
                ainst = new ARM_Instruction(ARM_Mnemonic.push, "r1");
                addToOutput(ainst);
                return;
            }
        }
    }

    public void addToOutput(ARM_Instruction ainst) {
        output[pc] = ainst;
        out_asm+=ainst.toString()+"\n";
        // System.out.println(ainst.toString());
        pc++;
    }





}
