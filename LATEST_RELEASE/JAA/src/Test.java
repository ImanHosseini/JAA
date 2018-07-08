import Instructions.Instruction;
import Instructions.JVM_Instruction;

/**
 * Created by ImanH on 5/9/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */
public class Test {
    public static void main(String[] args){
        Instruction ins = new JVM_Instruction();
        System.out.println(ins.getArch());
    }
}
