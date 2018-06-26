module file_writer(
  enable,
  done,
  data
);

  parameter DATA_WIDTH = 7;
  input enable;
  input done;
  input [DATA_WIDTH:0] data;
  integer file;

  initial
    begin
      file = $fopen("output.txt","w");
    end

  always @(enable)
    begin
      if (enable)
        begin
          $fwrite(file,"%h\n",data);
        end
      else if (done)
        begin
          $fclose(file);
        end
    end

endmodule