
module jaa ( clk, reset, data );
  output [7:0] data;
  input clk, reset;
  wire   write_enable;
  wire   [191:0] instructions;
  wire   [3:0] quantity;
  assign data[7] = 1'b0;
  assign data[6] = 1'b0;
  assign data[5] = 1'b0;
  assign data[4] = 1'b0;
  assign data[3] = 1'b0;
  assign data[2] = 1'b0;
  assign data[1] = 1'b0;
  assign data[0] = 1'b0;

  RSLATX1 \instructions_reg[0]  ( .R(1'b0), .S(1'b0), .Q(instructions[0]) );
  TLATX4 write_enable_reg ( .G(1'b1), .D(1'b0), .Q(write_enable) );
  TLATX4 \instructions_reg[1]  ( .G(1'b0), .D(1'b0), .Q(instructions[1]) );
  TLATX4 \instructions_reg[2]  ( .G(1'b0), .D(1'b0), .Q(instructions[2]) );
  TLATX4 \instructions_reg[3]  ( .G(1'b0), .D(1'b0), .Q(instructions[3]) );
  TLATX4 \instructions_reg[4]  ( .G(1'b0), .D(1'b0), .Q(instructions[4]) );
  TLATX4 \instructions_reg[5]  ( .G(1'b0), .D(1'b0), .Q(instructions[5]) );
  TLATX4 \instructions_reg[6]  ( .G(1'b0), .D(1'b0), .Q(instructions[6]) );
  TLATX4 \instructions_reg[7]  ( .G(1'b0), .D(1'b0), .Q(instructions[7]) );
  TLATX4 \instructions_reg[8]  ( .G(1'b0), .D(1'b0), .Q(instructions[8]) );
  TLATX4 \instructions_reg[9]  ( .G(1'b0), .D(1'b0), .Q(instructions[9]) );
  TLATX4 \instructions_reg[10]  ( .G(1'b0), .D(1'b0), .Q(instructions[10]) );
  TLATX4 \instructions_reg[11]  ( .G(1'b0), .D(1'b0), .Q(instructions[11]) );
  TLATX4 \instructions_reg[12]  ( .G(1'b0), .D(1'b1), .Q(instructions[12]) );
  TLATX4 \instructions_reg[13]  ( .G(1'b0), .D(1'b0), .Q(instructions[13]) );
  TLATX4 \instructions_reg[14]  ( .G(1'b0), .D(1'b0), .Q(instructions[14]) );
  TLATX4 \instructions_reg[15]  ( .G(1'b0), .D(1'b0), .Q(instructions[15]) );
  TLATX4 \instructions_reg[16]  ( .G(1'b0), .D(1'b0), .Q(instructions[16]) );
  TLATX4 \instructions_reg[17]  ( .G(1'b0), .D(1'b0), .Q(instructions[17]) );
  TLATX4 \instructions_reg[18]  ( .G(1'b0), .D(1'b0), .Q(instructions[18]) );
  TLATX4 \instructions_reg[19]  ( .G(1'b0), .D(1'b0), .Q(instructions[19]) );
  TLATX4 \instructions_reg[20]  ( .G(1'b0), .D(1'b0), .Q(instructions[20]) );
  TLATX4 \instructions_reg[21]  ( .G(1'b0), .D(1'b1), .Q(instructions[21]) );
  TLATX4 \instructions_reg[22]  ( .G(1'b0), .D(1'b0), .Q(instructions[22]) );
  TLATX4 \instructions_reg[23]  ( .G(1'b0), .D(1'b1), .Q(instructions[23]) );
  TLATX4 \instructions_reg[24]  ( .G(1'b0), .D(1'b1), .Q(instructions[24]) );
  TLATX4 \instructions_reg[25]  ( .G(1'b0), .D(1'b1), .Q(instructions[25]) );
  TLATX4 \instructions_reg[26]  ( .G(1'b0), .D(1'b0), .Q(instructions[26]) );
  TLATX4 \instructions_reg[27]  ( .G(1'b0), .D(1'b0), .Q(instructions[27]) );
  TLATX4 \instructions_reg[28]  ( .G(1'b0), .D(1'b0), .Q(instructions[28]) );
  TLATX4 \instructions_reg[29]  ( .G(1'b0), .D(1'b1), .Q(instructions[29]) );
  TLATX4 \instructions_reg[30]  ( .G(1'b0), .D(1'b1), .Q(instructions[30]) );
  TLATX4 \instructions_reg[31]  ( .G(1'b0), .D(1'b1), .Q(instructions[31]) );
  TLATX4 \instructions_reg[32]  ( .G(1'b0), .D(1'b0), .Q(instructions[32]) );
  TLATX4 \instructions_reg[33]  ( .G(1'b0), .D(1'b1), .Q(instructions[33]) );
  TLATX4 \instructions_reg[34]  ( .G(1'b0), .D(1'b0), .Q(instructions[34]) );
  TLATX4 \instructions_reg[35]  ( .G(1'b0), .D(1'b0), .Q(instructions[35]) );
  TLATX4 \instructions_reg[36]  ( .G(1'b0), .D(1'b0), .Q(instructions[36]) );
  TLATX4 \instructions_reg[37]  ( .G(1'b0), .D(1'b0), .Q(instructions[37]) );
  TLATX4 \instructions_reg[38]  ( .G(1'b0), .D(1'b0), .Q(instructions[38]) );
  TLATX4 \instructions_reg[39]  ( .G(1'b0), .D(1'b0), .Q(instructions[39]) );
  TLATX4 \instructions_reg[40]  ( .G(1'b0), .D(1'b0), .Q(instructions[40]) );
  TLATX4 \instructions_reg[41]  ( .G(1'b0), .D(1'b0), .Q(instructions[41]) );
  TLATX4 \instructions_reg[42]  ( .G(1'b0), .D(1'b0), .Q(instructions[42]) );
  TLATX4 \instructions_reg[43]  ( .G(1'b0), .D(1'b0), .Q(instructions[43]) );
  TLATX4 \instructions_reg[44]  ( .G(1'b0), .D(1'b0), .Q(instructions[44]) );
  TLATX4 \instructions_reg[45]  ( .G(1'b0), .D(1'b0), .Q(instructions[45]) );
  TLATX4 \instructions_reg[46]  ( .G(1'b0), .D(1'b0), .Q(instructions[46]) );
  TLATX4 \instructions_reg[47]  ( .G(1'b0), .D(1'b0), .Q(instructions[47]) );
  TLATX4 \instructions_reg[48]  ( .G(1'b0), .D(1'b1), .Q(instructions[48]) );
  TLATX4 \instructions_reg[49]  ( .G(1'b0), .D(1'b0), .Q(instructions[49]) );
  TLATX4 \instructions_reg[50]  ( .G(1'b0), .D(1'b1), .Q(instructions[50]) );
  TLATX4 \instructions_reg[51]  ( .G(1'b0), .D(1'b1), .Q(instructions[51]) );
  TLATX4 \instructions_reg[52]  ( .G(1'b0), .D(1'b0), .Q(instructions[52]) );
  TLATX4 \instructions_reg[53]  ( .G(1'b0), .D(1'b1), .Q(instructions[53]) );
  TLATX4 \instructions_reg[54]  ( .G(1'b0), .D(1'b0), .Q(instructions[54]) );
  TLATX4 \instructions_reg[55]  ( .G(1'b0), .D(1'b0), .Q(instructions[55]) );
  TLATX4 \instructions_reg[56]  ( .G(1'b0), .D(1'b1), .Q(instructions[56]) );
  TLATX4 \instructions_reg[57]  ( .G(1'b0), .D(1'b0), .Q(instructions[57]) );
  TLATX4 \instructions_reg[58]  ( .G(1'b0), .D(1'b0), .Q(instructions[58]) );
  TLATX4 \instructions_reg[59]  ( .G(1'b0), .D(1'b1), .Q(instructions[59]) );
  TLATX4 \instructions_reg[60]  ( .G(1'b0), .D(1'b0), .Q(instructions[60]) );
  TLATX4 \instructions_reg[61]  ( .G(1'b0), .D(1'b1), .Q(instructions[61]) );
  TLATX4 \instructions_reg[62]  ( .G(1'b0), .D(1'b1), .Q(instructions[62]) );
  TLATX4 \instructions_reg[63]  ( .G(1'b0), .D(1'b1), .Q(instructions[63]) );
  TLATX4 \instructions_reg[64]  ( .G(1'b0), .D(1'b0), .Q(instructions[64]) );
  TLATX4 \instructions_reg[65]  ( .G(1'b0), .D(1'b0), .Q(instructions[65]) );
  TLATX4 \instructions_reg[66]  ( .G(1'b0), .D(1'b0), .Q(instructions[66]) );
  TLATX4 \instructions_reg[67]  ( .G(1'b0), .D(1'b0), .Q(instructions[67]) );
  TLATX4 \instructions_reg[68]  ( .G(1'b0), .D(1'b0), .Q(instructions[68]) );
  TLATX4 \instructions_reg[69]  ( .G(1'b0), .D(1'b0), .Q(instructions[69]) );
  TLATX4 \instructions_reg[70]  ( .G(1'b0), .D(1'b0), .Q(instructions[70]) );
  TLATX4 \instructions_reg[71]  ( .G(1'b0), .D(1'b0), .Q(instructions[71]) );
  TLATX4 \instructions_reg[72]  ( .G(1'b0), .D(1'b0), .Q(instructions[72]) );
  TLATX4 \instructions_reg[73]  ( .G(1'b0), .D(1'b0), .Q(instructions[73]) );
  TLATX4 \instructions_reg[74]  ( .G(1'b0), .D(1'b0), .Q(instructions[74]) );
  TLATX4 \instructions_reg[75]  ( .G(1'b0), .D(1'b0), .Q(instructions[75]) );
  TLATX4 \instructions_reg[76]  ( .G(1'b0), .D(1'b0), .Q(instructions[76]) );
  TLATX4 \instructions_reg[77]  ( .G(1'b0), .D(1'b0), .Q(instructions[77]) );
  TLATX4 \instructions_reg[78]  ( .G(1'b0), .D(1'b0), .Q(instructions[78]) );
  TLATX4 \instructions_reg[79]  ( .G(1'b0), .D(1'b0), .Q(instructions[79]) );
  TLATX4 \instructions_reg[80]  ( .G(1'b0), .D(1'b0), .Q(instructions[80]) );
  TLATX4 \instructions_reg[81]  ( .G(1'b0), .D(1'b0), .Q(instructions[81]) );
  TLATX4 \instructions_reg[82]  ( .G(1'b0), .D(1'b0), .Q(instructions[82]) );
  TLATX4 \instructions_reg[83]  ( .G(1'b0), .D(1'b0), .Q(instructions[83]) );
  TLATX4 \instructions_reg[84]  ( .G(1'b0), .D(1'b0), .Q(instructions[84]) );
  TLATX4 \instructions_reg[85]  ( .G(1'b0), .D(1'b0), .Q(instructions[85]) );
  TLATX4 \instructions_reg[86]  ( .G(1'b0), .D(1'b0), .Q(instructions[86]) );
  TLATX4 \instructions_reg[87]  ( .G(1'b0), .D(1'b0), .Q(instructions[87]) );
  TLATX4 \instructions_reg[88]  ( .G(1'b0), .D(1'b0), .Q(instructions[88]) );
  TLATX4 \instructions_reg[89]  ( .G(1'b0), .D(1'b0), .Q(instructions[89]) );
  TLATX4 \instructions_reg[90]  ( .G(1'b0), .D(1'b0), .Q(instructions[90]) );
  TLATX4 \instructions_reg[91]  ( .G(1'b0), .D(1'b0), .Q(instructions[91]) );
  TLATX4 \instructions_reg[92]  ( .G(1'b0), .D(1'b0), .Q(instructions[92]) );
  TLATX4 \instructions_reg[93]  ( .G(1'b0), .D(1'b0), .Q(instructions[93]) );
  TLATX4 \instructions_reg[94]  ( .G(1'b0), .D(1'b0), .Q(instructions[94]) );
  TLATX4 \instructions_reg[95]  ( .G(1'b0), .D(1'b0), .Q(instructions[95]) );
  TLATX4 \instructions_reg[96]  ( .G(1'b0), .D(1'b0), .Q(instructions[96]) );
  TLATX4 \instructions_reg[97]  ( .G(1'b0), .D(1'b0), .Q(instructions[97]) );
  TLATX4 \instructions_reg[98]  ( .G(1'b0), .D(1'b0), .Q(instructions[98]) );
  TLATX4 \instructions_reg[99]  ( .G(1'b0), .D(1'b0), .Q(instructions[99]) );
  TLATX4 \instructions_reg[100]  ( .G(1'b0), .D(1'b0), .Q(instructions[100])
         );
  TLATX4 \instructions_reg[101]  ( .G(1'b0), .D(1'b0), .Q(instructions[101])
         );
  TLATX4 \instructions_reg[102]  ( .G(1'b0), .D(1'b0), .Q(instructions[102])
         );
  TLATX4 \instructions_reg[103]  ( .G(1'b0), .D(1'b0), .Q(instructions[103])
         );
  TLATX4 \instructions_reg[104]  ( .G(1'b0), .D(1'b0), .Q(instructions[104])
         );
  TLATX4 \instructions_reg[105]  ( .G(1'b0), .D(1'b0), .Q(instructions[105])
         );
  TLATX4 \instructions_reg[106]  ( .G(1'b0), .D(1'b0), .Q(instructions[106])
         );
  TLATX4 \instructions_reg[107]  ( .G(1'b0), .D(1'b0), .Q(instructions[107])
         );
  TLATX4 \instructions_reg[108]  ( .G(1'b0), .D(1'b0), .Q(instructions[108])
         );
  TLATX4 \instructions_reg[109]  ( .G(1'b0), .D(1'b0), .Q(instructions[109])
         );
  TLATX4 \instructions_reg[110]  ( .G(1'b0), .D(1'b0), .Q(instructions[110])
         );
  TLATX4 \instructions_reg[111]  ( .G(1'b0), .D(1'b0), .Q(instructions[111])
         );
  TLATX4 \instructions_reg[112]  ( .G(1'b0), .D(1'b0), .Q(instructions[112])
         );
  TLATX4 \instructions_reg[113]  ( .G(1'b0), .D(1'b0), .Q(instructions[113])
         );
  TLATX4 \instructions_reg[114]  ( .G(1'b0), .D(1'b0), .Q(instructions[114])
         );
  TLATX4 \instructions_reg[115]  ( .G(1'b0), .D(1'b0), .Q(instructions[115])
         );
  TLATX4 \instructions_reg[116]  ( .G(1'b0), .D(1'b0), .Q(instructions[116])
         );
  TLATX4 \instructions_reg[117]  ( .G(1'b0), .D(1'b0), .Q(instructions[117])
         );
  TLATX4 \instructions_reg[118]  ( .G(1'b0), .D(1'b0), .Q(instructions[118])
         );
  TLATX4 \instructions_reg[119]  ( .G(1'b0), .D(1'b0), .Q(instructions[119])
         );
  TLATX4 \instructions_reg[120]  ( .G(1'b0), .D(1'b0), .Q(instructions[120])
         );
  TLATX4 \instructions_reg[121]  ( .G(1'b0), .D(1'b0), .Q(instructions[121])
         );
  TLATX4 \instructions_reg[122]  ( .G(1'b0), .D(1'b0), .Q(instructions[122])
         );
  TLATX4 \instructions_reg[123]  ( .G(1'b0), .D(1'b0), .Q(instructions[123])
         );
  TLATX4 \instructions_reg[124]  ( .G(1'b0), .D(1'b0), .Q(instructions[124])
         );
  TLATX4 \instructions_reg[125]  ( .G(1'b0), .D(1'b0), .Q(instructions[125])
         );
  TLATX4 \instructions_reg[126]  ( .G(1'b0), .D(1'b0), .Q(instructions[126])
         );
  TLATX4 \instructions_reg[127]  ( .G(1'b0), .D(1'b0), .Q(instructions[127])
         );
  TLATX4 \instructions_reg[128]  ( .G(1'b0), .D(1'b0), .Q(instructions[128])
         );
  TLATX4 \instructions_reg[129]  ( .G(1'b0), .D(1'b0), .Q(instructions[129])
         );
  TLATX4 \instructions_reg[130]  ( .G(1'b0), .D(1'b0), .Q(instructions[130])
         );
  TLATX4 \instructions_reg[131]  ( .G(1'b0), .D(1'b0), .Q(instructions[131])
         );
  TLATX4 \instructions_reg[132]  ( .G(1'b0), .D(1'b0), .Q(instructions[132])
         );
  TLATX4 \instructions_reg[133]  ( .G(1'b0), .D(1'b0), .Q(instructions[133])
         );
  TLATX4 \instructions_reg[134]  ( .G(1'b0), .D(1'b0), .Q(instructions[134])
         );
  TLATX4 \instructions_reg[135]  ( .G(1'b0), .D(1'b0), .Q(instructions[135])
         );
  TLATX4 \instructions_reg[136]  ( .G(1'b0), .D(1'b0), .Q(instructions[136])
         );
  TLATX4 \instructions_reg[137]  ( .G(1'b0), .D(1'b0), .Q(instructions[137])
         );
  TLATX4 \instructions_reg[138]  ( .G(1'b0), .D(1'b0), .Q(instructions[138])
         );
  TLATX4 \instructions_reg[139]  ( .G(1'b0), .D(1'b0), .Q(instructions[139])
         );
  TLATX4 \instructions_reg[140]  ( .G(1'b0), .D(1'b0), .Q(instructions[140])
         );
  TLATX4 \instructions_reg[141]  ( .G(1'b0), .D(1'b0), .Q(instructions[141])
         );
  TLATX4 \instructions_reg[142]  ( .G(1'b0), .D(1'b0), .Q(instructions[142])
         );
  TLATX4 \instructions_reg[143]  ( .G(1'b0), .D(1'b0), .Q(instructions[143])
         );
  TLATX4 \instructions_reg[144]  ( .G(1'b0), .D(1'b0), .Q(instructions[144])
         );
  TLATX4 \instructions_reg[145]  ( .G(1'b0), .D(1'b0), .Q(instructions[145])
         );
  TLATX4 \instructions_reg[146]  ( .G(1'b0), .D(1'b0), .Q(instructions[146])
         );
  TLATX4 \instructions_reg[147]  ( .G(1'b0), .D(1'b0), .Q(instructions[147])
         );
  TLATX4 \instructions_reg[148]  ( .G(1'b0), .D(1'b0), .Q(instructions[148])
         );
  TLATX4 \instructions_reg[149]  ( .G(1'b0), .D(1'b0), .Q(instructions[149])
         );
  TLATX4 \instructions_reg[150]  ( .G(1'b0), .D(1'b0), .Q(instructions[150])
         );
  TLATX4 \instructions_reg[151]  ( .G(1'b0), .D(1'b0), .Q(instructions[151])
         );
  TLATX4 \instructions_reg[152]  ( .G(1'b0), .D(1'b0), .Q(instructions[152])
         );
  TLATX4 \instructions_reg[153]  ( .G(1'b0), .D(1'b0), .Q(instructions[153])
         );
  TLATX4 \instructions_reg[154]  ( .G(1'b0), .D(1'b0), .Q(instructions[154])
         );
  TLATX4 \instructions_reg[155]  ( .G(1'b0), .D(1'b0), .Q(instructions[155])
         );
  TLATX4 \instructions_reg[156]  ( .G(1'b0), .D(1'b0), .Q(instructions[156])
         );
  TLATX4 \instructions_reg[157]  ( .G(1'b0), .D(1'b0), .Q(instructions[157])
         );
  TLATX4 \instructions_reg[158]  ( .G(1'b0), .D(1'b0), .Q(instructions[158])
         );
  TLATX4 \instructions_reg[159]  ( .G(1'b0), .D(1'b0), .Q(instructions[159])
         );
  TLATX4 \instructions_reg[160]  ( .G(1'b0), .D(1'b0), .Q(instructions[160])
         );
  TLATX4 \instructions_reg[161]  ( .G(1'b0), .D(1'b0), .Q(instructions[161])
         );
  TLATX4 \instructions_reg[162]  ( .G(1'b0), .D(1'b0), .Q(instructions[162])
         );
  TLATX4 \instructions_reg[163]  ( .G(1'b0), .D(1'b0), .Q(instructions[163])
         );
  TLATX4 \instructions_reg[164]  ( .G(1'b0), .D(1'b0), .Q(instructions[164])
         );
  TLATX4 \instructions_reg[165]  ( .G(1'b0), .D(1'b0), .Q(instructions[165])
         );
  TLATX4 \instructions_reg[166]  ( .G(1'b0), .D(1'b0), .Q(instructions[166])
         );
  TLATX4 \instructions_reg[167]  ( .G(1'b0), .D(1'b0), .Q(instructions[167])
         );
  TLATX4 \instructions_reg[168]  ( .G(1'b0), .D(1'b0), .Q(instructions[168])
         );
  TLATX4 \instructions_reg[169]  ( .G(1'b0), .D(1'b0), .Q(instructions[169])
         );
  TLATX4 \instructions_reg[170]  ( .G(1'b0), .D(1'b0), .Q(instructions[170])
         );
  TLATX4 \instructions_reg[171]  ( .G(1'b0), .D(1'b0), .Q(instructions[171])
         );
  TLATX4 \instructions_reg[172]  ( .G(1'b0), .D(1'b0), .Q(instructions[172])
         );
  TLATX4 \instructions_reg[173]  ( .G(1'b0), .D(1'b0), .Q(instructions[173])
         );
  TLATX4 \instructions_reg[174]  ( .G(1'b0), .D(1'b0), .Q(instructions[174])
         );
  TLATX4 \instructions_reg[175]  ( .G(1'b0), .D(1'b0), .Q(instructions[175])
         );
  TLATX4 \instructions_reg[176]  ( .G(1'b0), .D(1'b0), .Q(instructions[176])
         );
  TLATX4 \instructions_reg[177]  ( .G(1'b0), .D(1'b0), .Q(instructions[177])
         );
  TLATX4 \instructions_reg[178]  ( .G(1'b0), .D(1'b0), .Q(instructions[178])
         );
  TLATX4 \instructions_reg[179]  ( .G(1'b0), .D(1'b0), .Q(instructions[179])
         );
  TLATX4 \instructions_reg[180]  ( .G(1'b0), .D(1'b0), .Q(instructions[180])
         );
  TLATX4 \instructions_reg[181]  ( .G(1'b0), .D(1'b0), .Q(instructions[181])
         );
  TLATX4 \instructions_reg[182]  ( .G(1'b0), .D(1'b0), .Q(instructions[182])
         );
  TLATX4 \instructions_reg[183]  ( .G(1'b0), .D(1'b0), .Q(instructions[183])
         );
  TLATX4 \instructions_reg[184]  ( .G(1'b0), .D(1'b0), .Q(instructions[184])
         );
  TLATX4 \instructions_reg[185]  ( .G(1'b0), .D(1'b0), .Q(instructions[185])
         );
  TLATX4 \instructions_reg[186]  ( .G(1'b0), .D(1'b0), .Q(instructions[186])
         );
  TLATX4 \instructions_reg[187]  ( .G(1'b0), .D(1'b0), .Q(instructions[187])
         );
  TLATX4 \instructions_reg[188]  ( .G(1'b0), .D(1'b0), .Q(instructions[188])
         );
  TLATX4 \instructions_reg[189]  ( .G(1'b0), .D(1'b0), .Q(instructions[189])
         );
  TLATX4 \instructions_reg[190]  ( .G(1'b0), .D(1'b0), .Q(instructions[190])
         );
  TLATX4 \instructions_reg[191]  ( .G(1'b0), .D(1'b0), .Q(instructions[191])
         );
  TLATX4 \quantity_reg[2]  ( .G(1'b0), .D(1'b0), .Q(quantity[2]) );
  TLATX4 \quantity_reg[0]  ( .G(1'b0), .D(1'b0), .Q(quantity[0]) );
  TLATX4 \quantity_reg[1]  ( .G(1'b0), .D(1'b1), .Q(quantity[1]) );
  TLATX4 \quantity_reg[3]  ( .G(1'b0), .D(1'b0), .Q(quantity[3]) );
endmodule

