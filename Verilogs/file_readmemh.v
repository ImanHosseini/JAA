module file_readmemh;
  // 1024 bytes
  reg [7:0] data [0:1023];
  // initalize the hexadecimal reads from the test.txt file
  initial
    begin
      $readmemh("test.txt", data);
    end
  // declare an integer for the conditional statement to read values from test file
  integer i;
  // for loop to read and display the values from the text file on the compiler screen
  initial
    begin
      $display("data:");
      for (i=0; i < 1024; i=i+1)
        begin
          $display("%d : %h",i,data[i]);
        end
    end
endmodule