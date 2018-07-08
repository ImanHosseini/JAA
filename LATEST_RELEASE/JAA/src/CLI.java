/**
 * Created by ImanH on 5/25/2018.
 * Seyed Iman Hosseini Zavaraki
 * Github @ https://github.com/ImanHosseini
 * Wordpress @ https://imanhosseini.wordpress.com/
 */

import Kernel.Kernel;
import Tools.ClassParser;
import Tools.JTestGen;
import Tools.ROMGen;

import static Tools.Utils.*;

public class CLI {

    // JAA Commandline Interface
    public static void main(String[] args){
        boolean quiet=false;
        int options_num=0;
        if(args.length==0){
            showInfo();
            System.out.println("use ? or help for more info");
            return;
        }
        for(String str:args){
            if(str.charAt(0)=='-'){
                switch(str){
                    case "-q":{
                        quiet=true;
                        options_num++;
                        break;
                    }
                    default:{
                        showInfo();
                        System.out.println("invalid option\nuse ? or help for more info");
                    }

                }
            }
        }

        if(args[0].equals("disas")){
            if(args.length==1){
                if(!quiet) showInfo();
                System.out.println("no input specified\nuse ? or help for more info");
                return;
            }
            if(args.length-options_num>2){
                if(!quiet) showInfo();
                System.out.println("no many arguments\nuse ? or help for more info");
                return;
            }
            if(!quiet) showInfo();
            Kernel ker=new Kernel();
            try{
                ker.Disassemble(args[1]);
            }catch (Exception e){

                System.out.println("file does not exist");
                return;
            }
            return;

        }

        if(args[0].equals("raw")){
            if(args.length==1){
                if(!quiet) showInfo();
                System.out.println("no input specified\nuse ? or help for more info");
                return;
            }
            if(args.length-options_num>2){
                if(!quiet) showInfo();
                System.out.println("no many arguments\nuse ? or help for more info");
                return;
            }
            Kernel ker=new Kernel();
            if(!quiet) showInfo();
            try{
                ker.RunRaw(args[1]);
            }catch (Exception e){

                System.out.println("file does not exist");
                return;
            }
            return;
        }

        if(args[0].equals("c2jb")){
            if(args.length==1){
                if(!quiet) showInfo();
                System.out.println("no input specified\nuse ? or help for more info");
                return;
            }
            if(args.length-options_num==2){
                if(!quiet) showInfo();
                try {
                    ClassParser cp = new ClassParser(args[1]);
                    cp.parse();
                    return;
                }catch (Exception e){

                    System.out.println("file does not exist");
                    return;
                }
            }

            if(args.length-options_num==3){
                if(!quiet) showInfo();
                try {
                    ClassParser cp = new ClassParser(args[1],args[2]);
                    cp.parse();
                    return;
                }catch (Exception e){
                    System.out.println("file does not exist");
                    return;
                }
            }

        }

        if(args[0].equals("c2asm")){
            if(args.length==1){
                if(!quiet) showInfo();
                System.out.println("no input specified\nuse ? or help for more info");
                return;
            }
            if(args.length-options_num==2){
                if(!quiet) showInfo();
                try {
                    Kernel ker = new Kernel();
                    ker.JB2ASM(args[1]);
                    return;
                }catch (Exception e){

                    System.out.println("file does not exist");
                    return;
                }
            }

            if(args.length-options_num==3){
                if(!quiet) showInfo();
                try {
                    Kernel ker = new Kernel();
                    ker.JB2ASM(args[1],args[2]);
                    return;
                }catch (Exception e){
                    System.out.println("file does not exist");
                    return;
                }
            }

        }

        if(args[0].equals("?") || args[0].equals("help")){
            showInfo();
            showHelp();
            return;
        }

        if(args[0].equals("romgen")){
            ROMGen rg = new ROMGen(args[1],args[1]+"_rom");
            try {
                rg.generate();
            }catch (Exception e){

            }
            return;
        }

        if(args[0].equals("jtest")){
            try{
                JTestGen jtg = new JTestGen(Integer.parseInt(args[1]),Integer.parseInt(args[2]),args[3]);
            }catch (Exception e){

            }
            return;

        }

        System.out.println("use ? or help for more info");
        return;



    }
}
