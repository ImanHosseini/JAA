package Kernel;

import Instructions.ARM_Instruction;
import Instructions.JVM_Instruction;

import static Instructions.JVM_Instruction.*;
import static Instructions.ARM_Instruction.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;


/**
 * Created by ImanH on 5/10/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */

// Main computation happens here: read binary with JVM instructions and output ARM instructions

public class Kernel {
    static final String jaa_logo = "ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgIC8vDQogICAgICAgICAgICAgICAqICAgICgoIA0KICAgICAgICAgJSAgKiogICAoKCgoICANCiAgICAgJiUlICAvKiAgIyMjKCggICAgDQogICAjJSUgICgoICAjIyMjIyAgJSAgIA0KICAlJSUgICMoICAjIyMjICAlJSAgICANCiAlJSUlICUjICAlJSMjICAgJSUgICAgDQolJSUlJSAlIyAgJSUlJSAgJSUlICAgIA0KJSUlJSUgJSMgICUlJSUgICUlJSUgICANCiUlJSUlICAjICAjJSUlICAjJSUlJSAgDQolJSUlJSMgICAgICUlJSAgIyMlJSUjIA0KJSUlJSMjIyMgICAgJSUlICAjIyUlJSANCiUlJSMjIyMjIyMgICAlJSAgIyMjJSUlDQolJSMjIyMjIyMjIyMgICUlICMjIyMjJQ0KICMjIyMjIyMjIyMjIyAgJSAjIyMjIyMNCiAgIyMjIyMjIyMjIyMjICAgIyMjIyMjDQogICAjIyMjIyMjIyMjKCAgIyMjIyMjIA0KICAgICAjIyMjIyMjICAgIyMjIyAgICAg";

    static final int PPRINT_DEFAULT_WIDTH = 32;
    static final int MAXINST = 10000;
    int pc = 0;
    ARM_Instruction[] output;


    public static void main(String[] args) throws IOException {
        showInfo();
        Kernel ker = new Kernel();
        ker.RunKernel(args);
    }

    public void RunKernel(String[] args) throws IOException {
        output = new ARM_Instruction[MAXINST];
        if (args.length == 0) {
            byte[] bytecode = readFile("bt1");
            // Test file reading
            prettyPrint(32, "INPUT-DISASSEMBLY");
            JVM_Instruction[] input_program;
            input_program = new JVM_Instruction[bytecode.length];
            int i = 0;
            for (byte b : bytecode) {
                System.out.print(String.format("%02x ", b));
                System.out.print(JVM_Instruction.Opcode_to_Mnemonic.get(Byte.toUnsignedInt(b)) + "\n");
                input_program[i] = new JVM_Instruction(b);
                i++;
            }
            prettyPrint(32, "ARM-OUTPUT");
            // Bytecode translation
            for (i = 0; i < input_program.length; i++) {
                translateToARM(input_program[i]);
            }

            prettyPrint("TASK-COMPLETED");

        }
    }


    static byte[] readFile(String path)
            throws IOException {
        byte[] encoded = Files.readAllBytes(Paths.get(".", path));
        return encoded;
    }

    public static void prettyPrint(int w, String s) {
        int j = (w - s.length()) / 2;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < j; i++) {
            sb.append("=");
        }
        sb.append(s);
        while (sb.length() < w) {
            sb.append("=");
        }
        System.out.println(sb.toString());
    }

    public static void prettyPrint(String s) {
        prettyPrint(PPRINT_DEFAULT_WIDTH, s);
    }

    public void translateToARM(JVM_Instruction j_inst) {
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
                ainst = new ARM_Instruction(ARM_Mnemonic.str, "r1","[r3+#"+sp+"]");
                addToOutput(ainst);
                return;
            }
            case iload_0: case iload_1: case iload_2: case iload_3:{
                String sp = j_mn.toString().split("_")[1];
                ARM_Instruction ainst = new ARM_Instruction(ARM_Mnemonic.ldr, "r1","[r3+#"+sp+"]");
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

        }
    }

    public void addToOutput(ARM_Instruction ainst) {
        output[pc] = ainst;
        System.out.println(ainst.toString());
        pc++;
    }

    public static void showInfo() {
        prettyPrint("JAA-1.0");
        byte[] valueDecoded = Base64.getDecoder().decode(jaa_logo);
        System.out.println(new String(valueDecoded));
    }
}
