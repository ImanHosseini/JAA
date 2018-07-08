package Tools;

import java.io.IOException;
import java.util.Random;
import static Tools.Utils.*;


public class JTestGen {
    static final String head="public class Main{\n" + "\tpublic static void main(String[] args){\n";
    static final String tail="}\n}\n";
    int n,p;
    public static void main(String[] args) throws IOException{
        JTestGen jg = new JTestGen(4,10,"t4_35");
    }

    public JTestGen(int n,int p,String name) throws IOException {
        StringBuilder sb = new StringBuilder();
        sb.append(head.replace("Main",name));
        for(int i=0;i<n;i++){
            sb.append("int x"+i+"="+(i+1)+";\n");
        }
        Random rand = new Random();
        for(int i=0;i<p;i++){
            for(int j=0;j<n;j++){
                int k = Math.abs(rand.nextInt())%n;
                boolean sub = rand.nextBoolean();
                if(sub){
                    sb.append("x"+j+"=x"+j+"-x"+k+";\n");
                }else{
                    sb.append("x"+j+"=x"+j+"+x"+k+";\n");
                }
            }
        }
        sb.append(tail);
        writeFile(sb.toString().getBytes(),name+".java");
    }
}
