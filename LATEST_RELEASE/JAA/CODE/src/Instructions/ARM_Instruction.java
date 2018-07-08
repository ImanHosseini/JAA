package Instructions;

import java.util.HashMap;

/**
 * Created by ImanH on 5/10/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */
public class ARM_Instruction extends Instruction {
    public enum ARM_Mnemonic{push,pop,add,str,ldr,mov,mvn}
    private Arch arch;
    private ARM_Mnemonic mnemonic;
    private int opcode;
    private String asString="";
    private String[] args;
    static final HashMap<ARM_Mnemonic,Integer> Mnemonic_to_Opcode;
    static final HashMap<Integer,ARM_Mnemonic> Opcode_to_Mnemonic;
    // CCode : Condition Code, is 4-bit value of condition codes e.g. EQ "0000" is for equal, and checks Z flag set. Range: from 0 up to 14 (0xe/"1110")
    static final HashMap<String,String> Suffix_to_CCode;
    static final HashMap<String,String> CCode_to_Suffix;
    static final HashMap<String,Integer> Reg_to_Num;
    static
    {
        Mnemonic_to_Opcode = new HashMap<>();
        Opcode_to_Mnemonic = new HashMap<>();
        Reg_to_Num = new HashMap<>();
        Suffix_to_CCode = new HashMap<>();
        CCode_to_Suffix = new HashMap<>();
        // OPCODE - MNEMONIC

        // SUFFIX - CCODE
        Suffix_to_CCode.put("EQ","0000");
        CCode_to_Suffix.put("0000","EQ");
        Suffix_to_CCode.put("NE","0001");
        CCode_to_Suffix.put("0001","NE");
        Suffix_to_CCode.put("AL","1110");
        CCode_to_Suffix.put("1110","AL");
        // REG - NUM
        Reg_to_Num.put("fp",11);
        Reg_to_Num.put("ip",12);
        Reg_to_Num.put("sp",13);
        Reg_to_Num.put("lr",14);
        Reg_to_Num.put("pc",15);

    }

    public ARM_Instruction(){
        this.arch= Arch.ARM;
    }

    public ARM_Instruction(ARM_Mnemonic mnemonic){
        this.arch= Arch.ARM;
        this.mnemonic=mnemonic;
        this.opcode=-1;
    }

    public ARM_Instruction(ARM_Mnemonic mnemonic,String[] args){
        this.arch=Arch.ARM;
        this.mnemonic=mnemonic;
        this.opcode=-1;
        this.args=args;
        this.handle();
    }

    public ARM_Instruction(ARM_Mnemonic mnemonic,String arg0){
        this.arch=Arch.ARM;
        this.mnemonic=mnemonic;
        this.opcode=-1;
        this.args=new String[1];
        args[0]=arg0;
        this.handle();
    }


    public ARM_Instruction(ARM_Mnemonic mnemonic,String arg0,String arg1){
        this.arch=Arch.ARM;
        this.mnemonic=mnemonic;
        this.opcode=-1;
        this.args=new String[2];
        args[0]=arg0;
        args[1]=arg1;
        this.handle();
    }


    public ARM_Instruction(ARM_Mnemonic mnemonic,String arg0,String arg1,String arg2){
        this.arch=Arch.ARM;
        this.mnemonic=mnemonic;
        this.opcode=-1;
        this.args=new String[3];
        args[0]=arg0;
        args[1]=arg1;
        args[2]=arg2;
        this.handle();
    }

    public ARM_Instruction(ARM_Mnemonic mnemonic,String arg0,String arg1,String arg2,String arg3){
        this.arch=Arch.ARM;
        this.mnemonic=mnemonic;
        this.opcode=-1;
        this.args=new String[4];
        args[0]=arg0;
        args[1]=arg1;
        args[2]=arg2;
        args[3]=arg3;
        this.handle();
    }

    public void handle(){
        switch (mnemonic){
            case push:{
                asString=mnemonic.toString()+" {";
                boolean first=true;
                for (String s:args){
                    if(first) {
                        asString+=s;
                        first=false;
                    }
                    else asString+=","+s;
                }
                asString+="}";
             return;
            }
            case add:{
                asString=mnemonic.toString()+" ";
                boolean first=true;
                for (String s:args){
                    if(first) {
                        asString+=s;
                        first=false;
                    }
                    else asString+=","+s;
                }

                return;
            }
            case pop:{
                asString=mnemonic.toString()+" {";
                boolean first=true;
                for (String s:args){
                    if(first) {
                        asString+=s;
                        first=false;
                    }
                    else asString+=","+s;
                }
                asString+="}";
                return;
            }

            case str: {
                asString=mnemonic.toString()+" ";
                boolean first=true;
                for (String s:args){
                    if(first) {
                        asString+=s;
                        first=false;
                    }
                    else asString+=","+s;
                }

                return;
            }

            case ldr: {
                asString=mnemonic.toString()+" ";
                boolean first=true;
                for (String s:args){
                    if(first) {
                        asString+=s;
                        first=false;
                    }
                    else asString+=","+s;
                }

                return;
            }
            case mov: {
                asString=mnemonic.toString()+" ";
                boolean first=true;
                for (String s:args){
                    if(first) {
                        asString+=s;
                        first=false;
                    }
                    else asString+=","+s;
                }

                return;
            }
            case mvn: {
                asString=mnemonic.toString()+" ";
                boolean first=true;
                for (String s:args){
                    if(first) {
                        asString+=s;
                        first=false;
                    }
                    else asString+=","+s;
                }

                return;
            }
        }
    }

    public static int Reg_to_Num(String reg){
        if(reg.startsWith("r")) return Integer.parseInt(reg.substring(1));
        return Reg_to_Num.get(reg);
    }

    @Override
    public Arch getArch() {
        return arch;
    }

    @Override
    public String getMnemonic() {
        return mnemonic.toString();
    }

    @Override
    public int getOpcode() {
        return opcode;
    }

    @Override
    public byte[] getBytes() {
        return new byte[0];
    }

    @Override
    public String toString(){
        return asString;
    }



}