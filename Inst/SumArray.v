initial begin

addi $1, $0, 1000    // address
addi $2, $0, 1040    // n
addi $4, $0, 0      // result
lw $3, 0($1)      // operand
add $4, $4, $3      //
addi $1, $1, 4
beq $1, $2, 32
j 12
sw $4, 2000($0)

//1111101000 	 1000
//10000010000	 1040	
end


	{memdata[0],memdata[1],memdata[2],memdata[3]} = {6'd8,5'b0,5'd1,16'd0};
	{memdata[4],memdata[5],memdata[6],memdata[7]} = {6'd8,5'b0,5'd4,16'b0};
	{memdata[8],memdata[9],memdata[10],memdata[11]} = {6'd8,5'b0,5'd2,16'd40};
	{memdata[12],memdata[13],memdata[14],memdata[15]} = {6'd8,5'b0,5'd10,16'd38};
	{memdata[16],memdata[17],memdata[18],memdata[19]} = {6'd35,5'd1,5'd3,16'b0};
	{memdata[20],memdata[21],memdata[22],memdata[23]} = {6'd0,5'd3,5'd4,5'd4,5'd0,6'd32};
	{memdata[24],memdata[25],memdata[26],memdata[27]} = {6'd8,5'd1,5'd1,16'd4};
	{memdata[28],memdata[29],memdata[30],memdata[31]} = {6'd4,5'd1,5'd2,16'd1};
	{memdata[32],memdata[33],memdata[34],memdata[35]} = {6'd2,26'd3};
	{memdata[36],memdata[37],memdata[38],memdata[39]} = {6'd43,5'd0,5'd4,16'd100};