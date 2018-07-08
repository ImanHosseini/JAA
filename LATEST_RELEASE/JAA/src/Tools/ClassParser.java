package Tools;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Objects;

import static Tools.Utils.*;

/**
 * Created by ImanH on 5/25/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */

// Parse a classfile into .jb file

/* .jb FORMAT
Header:
    u4 - 0xCAFEFAAA - Magic Number
    u2 - JAA Version
    u2 - cp_data offset - byte offsets IN cp_data
    u2 - code offset
cp_table:
    Constant Pool Offsets
cp_data:
    Constant Pool Data
Code:
    JVM code
==============================
|Header|cp_table|cp_data|code|
==============================
 */

public class ClassParser {

    static final int MAX_DATA = 64*4;
    static final int MAX_TABLE = 64;
    boolean DEBUG_MODE=true;
    String file;
    byte[] input;
    byte[] output;
    byte[] code;
    byte[] cp_data;
    byte[] cp_table;
    String out_name;
    int input_head=0;
    int table_ptr=0;

    static final int[] tagSize = {
           -1,-1,-1,4,4,8,8,2,2,4,4,4,4,-1,-1,3,2,-1,4
    };

    public ClassParser(String file) throws Exception{
        this.file=file;
        this.input=readFile(file);
        this.cp_data=new byte[MAX_DATA];
        this.cp_table = new byte[MAX_TABLE];
        this.out_name=file+".jb";
    }

    public ClassParser(String file,String out_name) throws Exception{
        this.file=file;
        this.input=readFile(file);
        this.cp_data=new byte[MAX_DATA];
        this.cp_table = new byte[MAX_TABLE];
        this.out_name=out_name;
    }

    public void parseV2(){
        validate();
        input_head=10;
        int num_of_cp_entries = readShort(8);
        // long and double take 2 slots in cp table
        int data_ptr=0;
        table_ptr=0;
        int entry_num=1;
        HashMap<Integer,String> cp_strings = new HashMap<>();
        while (entry_num<num_of_cp_entries){
            if(DEBUG_MODE) System.out.println(input_head);
            int tag = (int) input[input_head];
            int size = tagSize[tag];
            if(DEBUG_MODE) {
                System.out.println("tag is "+tag);
                dumpTable();
            }
            if(tag==1){
                size = readShort(input_head+1)+2;
                byte[] str = new byte[size];
                System.arraycopy(input,input_head+3,str,0,size-2);
                String str_s = new String(str).substring(0,str.length-2);
                cp_strings.put(entry_num,str_s);
                byte[] ptr = new byte[2];
                ptr = shortToByte((short) (0xFFFF));
                System.arraycopy(ptr,0,cp_table,table_ptr,2);
                table_ptr+=2;
               // data_ptr += size;
                if(DEBUG_MODE) System.out.println("cp_string: "+entry_num+" : "+str_s);
            }
            else if(tag>2 && tag<7) {
                System.arraycopy(input, input_head+1, cp_data, data_ptr, size);
                byte[] entry = new byte[2];
                entry = shortToByte((short) data_ptr);
                System.arraycopy(entry,0,cp_table,table_ptr,2);
                table_ptr+=2;
//                System.arraycopy(ptr,0,cp_table,data_ptr,2);
//                table_ptr+=2;
                data_ptr += size;
            } else{
                byte[] ptr = new byte[2];
                ptr = shortToByte((short) (0xFFFF));
                System.arraycopy(ptr,0,cp_table,table_ptr,2);
                table_ptr+=2;
            }
            if (tag == 5 || tag == 6) {
                entry_num ++;
                byte[] ptr = new byte[2];
                ptr = shortToByte((short) (0xFFFF));
                System.arraycopy(ptr,0,cp_table,table_ptr,2);
                table_ptr+=2;
                entry_num++;
            } else {
                entry_num++;
            }
            input_head+=size+1;
        }
        input_head+=6;
        short icount = readShort(input_head);
        input_head += 2+icount*2;
        short fcount = readShort(input_head);
        input_head += 2+fcount*2;
        int method_cnt = readShort(input_head);
        if(DEBUG_MODE) System.out.println("MC is: "+method_cnt);
        input_head+=2;
        int m_count=0;
        // Parse Methods
        while(m_count<method_cnt){
            int e_id = (int) readShort(input_head+2);
            if(DEBUG_MODE) System.out.println("eid is: "+e_id);
            String method_name = cp_strings.get(e_id);
            if(DEBUG_MODE) System.out.println("NAME IS: "+method_name);
            short len = readShort(input_head+6);
            // Parse Attributes
            input_head+=8;
            int a_id=0;
            while(a_id<len){
                String att_name = cp_strings.get((int)readShort(input_head));
                System.out.println(att_name+"*"+method_name);
                input_head+=2;
                int att_len = readInt(input_head);

                if(att_name.equals("Code") && method_name.equals("main")){
                    System.out.println(input_head);
                    input_head+=8;
                    int code_size = readInt(input_head);
                    System.out.println(code_size);
                    code=new byte[code_size];
                    System.arraycopy(input,input_head+4,code,0,code_size);
                }
                input_head+=4+att_len;
                a_id++;
            }
            m_count++;
        }
        // Assemble Output
        output=new byte[10 + data_ptr+table_ptr+code.length];
        if(DEBUG_MODE) System.out.println("OUTPUT SIZE: "+output.length+" CP_TABLE: "+table_ptr);
        output[0]=(byte)0xca; output[1]=(byte)0xfe; output[2]=(byte)0xfa; output[3]=(byte) 0xaa;
        byte[] aux = shortToByte(DEFAULT_VERSION);
        System.arraycopy(aux,0,output,4,2);
        aux = shortToByte((short)(10+table_ptr));
        System.arraycopy(aux,0,output,6,2);
        aux = shortToByte((short)(10+table_ptr+data_ptr));
        System.arraycopy(aux,0,output,8,2);
        System.arraycopy(cp_table,0,output,10,table_ptr);
        System.arraycopy(cp_data,0,output,10+table_ptr,data_ptr);
        System.arraycopy(code,0,output,10+table_ptr+data_ptr,code.length);
        try {
            writeFile(output, out_name);
        }catch (Exception e){
            System.out.println(e.toString());
        }
    }

    public void parse(){
        validate();
        input_head=10;
        int num_of_cp_entries = readShort(8);
        // long and double take 2 slots in cp table
        int data_ptr=0;
        int table_ptr=0;
        int entry_num=1;
        HashMap<Integer,String> cp_strings = new HashMap<>();
        while (entry_num<num_of_cp_entries){
            if(DEBUG_MODE) System.out.println(input_head);
            int tag = (int) input[input_head];
            int size = tagSize[tag];
            if(tag==1){
                size = readShort(input_head+1)+2;
                byte[] str = new byte[size];
                System.arraycopy(input,input_head+3,str,0,size-2);
                String str_s = new String(str).substring(0,str.length-2);
                cp_strings.put(entry_num,str_s);
                if(DEBUG_MODE) System.out.println("cp_string: "+entry_num+" : "+str_s);
            }
            if(tag>2 && tag<7) {
                System.arraycopy(input, input_head, cp_data, data_ptr, size);
                byte[] entry = new byte[2];
                byte[] ptr = new byte[2];
                entry = shortToByte((short) entry_num);
                ptr = shortToByte((short) (input_head - 8));
                System.arraycopy(entry,0,cp_table,table_ptr,2);
                table_ptr+=2;
                System.arraycopy(ptr,0,cp_table,table_ptr,2);
                data_ptr += size;
            }
            if (tag == 5 || tag == 6) {
                entry_num += 2;
            } else {
                entry_num++;
            }
            input_head+=size+1;
        }
        input_head+=6;
        short icount = readShort(input_head);
        input_head += 2+icount*2;
        short fcount = readShort(input_head);
        input_head += 2+fcount*2;
        int method_cnt = readShort(input_head);
        if(DEBUG_MODE) System.out.println("MC is: "+method_cnt);
        input_head+=2;
        int m_count=0;
        // Parse Methods
        while(m_count<method_cnt){
            int e_id = (int) readShort(input_head+2);
            if(DEBUG_MODE) System.out.println("eid is: "+e_id);
            String method_name = cp_strings.get(e_id);
            if(DEBUG_MODE) System.out.println("NAME IS: "+method_name);
            short len = readShort(input_head+6);
            // Parse Attributes
            input_head+=8;
            int a_id=0;
            while(a_id<len){
                String att_name = cp_strings.get((int)readShort(input_head));
                System.out.println(att_name+"*"+method_name);
                input_head+=2;
                int att_len = readInt(input_head);

                if(att_name.equals("Code") && method_name.equals("main")){
                    System.out.println(input_head);
                    input_head+=8;
                    int code_size = readInt(input_head);
                    System.out.println(code_size);
                    code=new byte[code_size];
                    System.arraycopy(input,input_head+4,code,0,code_size);
                }
                input_head+=4+att_len;
                a_id++;
            }
            m_count++;
        }
        // Assemble Output
        output=new byte[10 + data_ptr+table_ptr+code.length];
        if(DEBUG_MODE) System.out.println("OUTPUT SIZE: "+output.length+" CP_TABLE: "+cp_table.length);
        output[0]=(byte)0xca; output[1]=(byte)0xfe; output[2]=(byte)0xfa; output[3]=(byte) 0xaa;
        byte[] aux = shortToByte(DEFAULT_VERSION);
        System.arraycopy(aux,0,output,4,2);
        aux = shortToByte((short)(10+table_ptr));
        System.arraycopy(aux,0,output,6,2);
        aux = shortToByte((short)(10+table_ptr+data_ptr));
        System.arraycopy(aux,0,output,8,2);
        System.arraycopy(cp_table,0,output,10,table_ptr);
        System.arraycopy(cp_data,0,output,10+table_ptr,data_ptr);
        System.arraycopy(code,0,output,10+table_ptr+data_ptr,code.length);
        try {
            writeFile(output, out_name);
        }catch (Exception e){
            System.out.println(e.toString());
        }
        }

    public void validate(){
        return;
    }

    public short readShort(int i){
        short val=(short)( ((input[i]&0xFF)<<8) | (input[i+1]&0xFF) );
        return val;
    }

    public int readInt(int i){
        int val=( ( (input[i]&0xFF)<<24) | ((input[i+1]&0xFF)<<16) | ((input[i+2]&0xFF)<<8) | (input[i+3]&0xFF));
        return val;
    }

    public byte[] shortToByte(short x){
        byte[] ret=new byte[2];
        ret[1] = (byte)(x & 0xff);
        ret[0] = (byte)((x >> 8) & 0xff);
        return ret;
    }

    public void dumpTable(){
        for (int i=0;i<table_ptr;i++){
            System.out.print(String.format("%02x ", cp_table[i]));
        }
        System.out.print("\n");
    }


    public static void main(String[] args) throws Exception{
        ClassParser cp = new ClassParser("test.class");
        cp.parseV2();
    }
}
