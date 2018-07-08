package Instructions;

import java.util.HashMap;

/**
 * Created by ImanH on 5/9/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */
public class JVM_Instruction extends Instruction {
    public enum JVM_Mnemonic{iadd,iload,iload_0,iload_1,iload_2,iload_3,iconst_m1,iconst_0,iconst_1,iconst_2,iconst_3,
        iconst_4,iconst_5,istore,istore_0,istore_1,istore_2,istore_3,returnn,nop,swap,pop,pop2,isub,bipush}
    private Arch arch;
    private JVM_Mnemonic mnemonic;
    private int opcode;
    public static final HashMap<JVM_Mnemonic,Integer> Mnemonic_to_Opcode;
    public static final HashMap<Integer,JVM_Mnemonic> Opcode_to_Mnemonic;
    public static final HashMap<JVM_Mnemonic,Integer> Operand_bytes;
    static
    {
        Operand_bytes = new HashMap<>();
        Operand_bytes.put(JVM_Mnemonic.bipush,1);
        Operand_bytes.put(JVM_Mnemonic.istore,1);
        Operand_bytes.put(JVM_Mnemonic.iload,1);
        Mnemonic_to_Opcode = new HashMap<>();
        Opcode_to_Mnemonic = new HashMap<>();
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iadd, 0x60);
        Opcode_to_Mnemonic.put(0x60,JVM_Mnemonic.iadd);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iload, 0x15);
        Opcode_to_Mnemonic.put(0x15,JVM_Mnemonic.iload);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iload_0,0x1a);
        Opcode_to_Mnemonic.put(0x1a,JVM_Mnemonic.iload_0);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iload_1,0x1b);
        Opcode_to_Mnemonic.put(0x1b,JVM_Mnemonic.iload_1);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iload_2,0x1c);
        Opcode_to_Mnemonic.put(0x1c,JVM_Mnemonic.iload_2);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iload_3,0x1d);
        Opcode_to_Mnemonic.put(0x1d,JVM_Mnemonic.iload_3);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iconst_m1,0x2);
        Opcode_to_Mnemonic.put(0x2,JVM_Mnemonic.iconst_m1);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iconst_0,0x3);
        Opcode_to_Mnemonic.put(0x3,JVM_Mnemonic.iconst_0);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iconst_1,0x4);
        Opcode_to_Mnemonic.put(0x4,JVM_Mnemonic.iconst_1);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iconst_2,0x5);
        Opcode_to_Mnemonic.put(0x5,JVM_Mnemonic.iconst_2);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iconst_3,0x6);
        Opcode_to_Mnemonic.put(0x6,JVM_Mnemonic.iconst_3);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iconst_4,0x7);
        Opcode_to_Mnemonic.put(0x7,JVM_Mnemonic.iconst_4);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.iconst_5,0x8);
        Opcode_to_Mnemonic.put(0x8,JVM_Mnemonic.iconst_5);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.istore, 0x36);
        Opcode_to_Mnemonic.put(0x36,JVM_Mnemonic.istore);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.istore_0,0x3b);
        Opcode_to_Mnemonic.put(0x3b,JVM_Mnemonic.istore_0);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.istore_1,0x3c);
        Opcode_to_Mnemonic.put(0x3c,JVM_Mnemonic.istore_1);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.istore_2,0x3d);
        Opcode_to_Mnemonic.put(0x3d,JVM_Mnemonic.istore_2);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.istore_3,0x3e);
        Opcode_to_Mnemonic.put(0x3e,JVM_Mnemonic.istore_3);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.returnn,0xb1);
        Opcode_to_Mnemonic.put(0xb1,JVM_Mnemonic.returnn);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.nop,0x00);
        Opcode_to_Mnemonic.put(0x00,JVM_Mnemonic.nop);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.swap,0x5f);
        Opcode_to_Mnemonic.put(0x5f,JVM_Mnemonic.swap);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.pop,0x57);
        Opcode_to_Mnemonic.put(0x57,JVM_Mnemonic.pop);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.pop2,0x58);
        Opcode_to_Mnemonic.put(0x58,JVM_Mnemonic.pop2);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.isub,0x64);
        Opcode_to_Mnemonic.put(0x64,JVM_Mnemonic.isub);
        Mnemonic_to_Opcode.put(JVM_Mnemonic.bipush,0x10);
        Opcode_to_Mnemonic.put(0x10,JVM_Mnemonic.bipush);
    }

    public JVM_Instruction(){
        this.arch= Arch.JVM;
    }

    public JVM_Instruction(JVM_Mnemonic mnemonic){
        this.arch= Arch.JVM;
        this.mnemonic=mnemonic;
        this.opcode=Mnemonic_to_Opcode.get(mnemonic);
    }

    public JVM_Instruction(byte b){
        this.arch= Arch.JVM;
        this.mnemonic=Opcode_to_Mnemonic.get(Byte.toUnsignedInt(b));
        this.opcode=Mnemonic_to_Opcode.get(mnemonic);
    }

    @Override
    public Arch getArch() {
        return arch;
    }

    @Override
    public String getMnemonic() {
        return mnemonic.toString();
    }

    public JVM_Mnemonic getJMnemonic(){
        return mnemonic;
    }

    @Override
    public int getOpcode() {
        return opcode;
    }

    @Override
    public byte[] getBytes() {
        return new byte[0];
    }

}
