module rom (
  input [15:0] address,
  output [15:0] size,
  output reg [7:0] data
);

  assign size = 50;

  always @ (address)
    begin
      case (address)
        0 : data = 8'h66;
        1 : data = 8'h66;
        2 : data = 8'h66;
        3 : data = 8'h66;
        4 : data = 8'h66;
        5 : data = 8'h66;
        6 : data = 8'h00;
        7 : data = 8'h12;
        8 : data = 8'h00;
        9 : data = 8'h17;
        10 : data = 8'h00;
        11 : data = 8'h02;
        12 : data = 8'h00;
        13 : data = 8'h02;
        14 : data = 8'h00;
        15 : data = 8'h03;
        16 : data = 8'h00;
        17 : data = 8'h04;
        18 : data = 8'h01;
        19 : data = 8'h23;
        20 : data = 8'h45;
        21 : data = 8'h67;
        22 : data = 8'h89;
        23 : data = 8'h03;
        24 : data = 8'h04;
        25 : data = 8'h05;
        26 : data = 8'h06;
        27 : data = 8'h07;
        28 : data = 8'h08;
        29 : data = 8'h3b;
        30 : data = 8'h3c;
        31 : data = 8'h3d;
        32 : data = 8'h3e;
        33 : data = 8'h1a;
        34 : data = 8'h1b;
        35 : data = 8'h1c;
        36 : data = 8'h1d;
        37 : data = 8'h60;
        38 : data = 8'h59;
        39 : data = 8'h5a;
        40 : data = 8'h5b;
        41 : data = 8'h5c;
        42 : data = 8'h5d;
        43 : data = 8'h5e;
        44 : data = 8'h36;
        45 : data = 8'h00;
        46 : data = 8'h5f;
        47 : data = 8'h15;
        48 : data = 8'h00;
        default : data = 8'b0;
      endcase
    end

endmodule