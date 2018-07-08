package Tools;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;

/**
 * Created by ImanH on 5/25/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */
public abstract class Utils {
    public static final short DEFAULT_VERSION = 1;
    static final int PPRINT_DEFAULT_WIDTH = 32;
    static final String jaa_logo = "ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgIC8vDQogICAgICAgICAgICAgICAqICAgICgoIA0KICAgICAgICAgJSAgKiogICAoKCgoICANCiAgICAgJiUlICAvKiAgIyMjKCggICAgDQogICAjJSUgICgoICAjIyMjIyAgJSAgIA0KICAlJSUgICMoICAjIyMjICAlJSAgICANCiAlJSUlICUjICAlJSMjICAgJSUgICAgDQolJSUlJSAlIyAgJSUlJSAgJSUlICAgIA0KJSUlJSUgJSMgICUlJSUgICUlJSUgICANCiUlJSUlICAjICAjJSUlICAjJSUlJSAgDQolJSUlJSMgICAgICUlJSAgIyMlJSUjIA0KJSUlJSMjIyMgICAgJSUlICAjIyUlJSANCiUlJSMjIyMjIyMgICAlJSAgIyMjJSUlDQolJSMjIyMjIyMjIyMgICUlICMjIyMjJQ0KICMjIyMjIyMjIyMjIyAgJSAjIyMjIyMNCiAgIyMjIyMjIyMjIyMjICAgIyMjIyMjDQogICAjIyMjIyMjIyMjKCAgIyMjIyMjIA0KICAgICAjIyMjIyMjICAgIyMjIyAgICAg";
    static final String prologue=".data\n\tvar1: .word 0\n.text\n.global main\nmain:\npush {ip,lr}\nldr r3,adr_var1\n";
    static final String epilogue="pop {ip,pc}\nadr_var1: .word var1\n";
    static final String prologue2=".data\n\tvar1: .word 0\n.text\n.global main\nmain:\nldr r3,adr_var1\n";
    static final String epilogue2="bx lr\nadr_var1: .word var1\n";
    static final String HELP = "raw - deprecated, pre-jb version\nc2jb input_file (output_file) - compiles a classfile to jb\n" +
            "c2asm input_file (output_file) - compiles a jb to arm asm\ndisas input_file - disassembles jvm bytecode\nromgen - [experimental] make a rom from a file\n" +
            "jtest - [experimental] make a n-p model java test\noptions can be invoked on any command using -\n-q invokes quiet mode\n";



    public static void showInfo() {
        prettyPrint("JAA-2.0");
        byte[] valueDecoded = Base64.getDecoder().decode(jaa_logo);
        System.out.println(new String(valueDecoded));
    }

    public static void showHelp() {
        System.out.print(HELP);
    }

    public static void prettyPrint(String s) {
        prettyPrint(PPRINT_DEFAULT_WIDTH, s);
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

    public static byte[] readFile(String path)
            throws IOException {
        byte[] encoded = Files.readAllBytes(Paths.get(".", path));
        return encoded;
    }

    public static void writeFile(byte[] data,String out)
            throws IOException {
        Path path = Paths.get(".",out);
        Files.write(path, data);
    }

    public static void writeOutputAsm(byte[] data, String out)
        throws IOException{
        Path path = Paths.get(".",out);
        byte[] pro = prologue2.getBytes();
        byte[] epi = epilogue2.getBytes();
        byte[] all_data = new byte[data.length+pro.length+epi.length];

        System.arraycopy(pro,0,all_data,0,pro.length);
        System.arraycopy(data,0,all_data,pro.length,data.length);
        System.arraycopy(epi,0,all_data,pro.length+data.length,epi.length);
        Files.write(path,all_data);
    }

}
