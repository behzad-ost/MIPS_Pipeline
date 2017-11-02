module Memory #(parameter width=8, size=3000, addrSize=32)
  (input clk,
   input read,
   input write,
   input [addrSize-1:0]addr,
   output reg [4*width-1:0]rdData,
   input [4*width-1:0]wrData
  );
  
  reg [width-1:0] Mem [0:size-1];
  
  initial begin
	{Mem[0],Mem[1],Mem[2],Mem[3]} = {32'd1};
	{Mem[4],Mem[5],Mem[6],Mem[7]} = {32'd2};
	{Mem[8],Mem[9],Mem[10],Mem[11]} = {32'd3};
	{Mem[12],Mem[13],Mem[14],Mem[15]} = {32'd4};
	{Mem[16],Mem[17],Mem[18],Mem[19]} = {32'd5};
	{Mem[20],Mem[21],Mem[22],Mem[23]} = {32'd6};
	{Mem[24],Mem[25],Mem[26],Mem[27]} = {32'd7};
	{Mem[28],Mem[29],Mem[30],Mem[31]} = {32'd8};
	{Mem[32],Mem[33],Mem[34],Mem[35]} = {32'd9};
	{Mem[36],Mem[37],Mem[38],Mem[39]} = {32'd10};
	{Mem[40],Mem[41],Mem[42],Mem[43]} = {32'd57};
	{Mem[44],Mem[45],Mem[46],Mem[47]} = {32'd23};
	{Mem[48],Mem[49],Mem[50],Mem[51]} = {32'd0};
	{Mem[52],Mem[53],Mem[54],Mem[55]} = {32'd13};
	{Mem[56],Mem[57],Mem[58],Mem[59]} = {32'd9};
	{Mem[60],Mem[61],Mem[62],Mem[63]} = {32'd10};
	{Mem[64],Mem[65],Mem[66],Mem[67]} = {32'd11};
	{Mem[68],Mem[69],Mem[70],Mem[71]} = {32'd18};
	{Mem[72],Mem[73],Mem[74],Mem[75]} = {32'd33};
	{Mem[76],Mem[77],Mem[78],Mem[79]} = {32'd32};
		
  end
  always @(posedge clk) begin
    if(write)
      {Mem[addr], Mem[addr+1], Mem[addr+2], Mem[addr+3]} <= wrData;
//    else
//      rdData <= Mem[addr];
  end
  always @(addr, read)
    if(read) rdData <= {Mem[addr], Mem[addr+1], Mem[addr+2], Mem[addr+3]};
endmodule
  
  
   