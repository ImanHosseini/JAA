package Tools;

import static Tools.Utils.readFile;
import static Tools.Utils.writeFile;

public class ROMGen {
    public static final String INFO = "// This file is automatically generated via JAA ROM generator tool. DO NOT MODIFY! ";
    public static final String HEAD = "module [rom] (\ninput [15:0] addr ,\ninput read_en ,\noutput reg [7:0] data\n);\nalways @ (read_en or addr)\nbegin\n  case (addr)\n" ;
    public static final String TAIL = "    default : data = 0;\n  endcase\nend\n\nendmodule\n";
    public String out_filename;
    public String in_filename;

    public static void main(String[] args) throws Exception{
        ROMGen rg = new ROMGen("test.class.jb","rom1");
        rg.generate();
    }

    public ROMGen(String in,String out){
        this.out_filename=out;
        this.in_filename=in;
    }

    public void generate() throws Exception{
        byte[] data = readFile(in_filename);
        StringBuilder sb = new StringBuilder();
        sb.append(INFO+"\n"+HEAD.replace("[rom]",in_filename));
        for(int i =0 ; i<data.length; i++){
            sb.append("    "+i+" : data = 8'h"+String.format("%02x ", data[i])+";\n");
        }
        sb.append(TAIL);
        writeFile(sb.toString().getBytes(),out_filename+".v");

    }

}