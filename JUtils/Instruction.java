/**
 * Created by ImanH on 5/9/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */
public abstract class Instruction {
    public enum Arch{ARM,JVM}
    public abstract Arch getArch();
    public abstract String getMnemonic();
    public abstract int getOpcode();
    public abstract byte[] getBytes();
}
