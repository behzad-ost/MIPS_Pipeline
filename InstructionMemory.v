module InstructionMemory(input [31:0]pc, input clk, output reg [31:0]inst);

reg [7:0] memdata [127:0];

initial
        begin

			
				{memdata[0],memdata[1],memdata[2],memdata[3]} = {6'd15,5'b0,5'd8,16'b1000000000000000};
				{memdata[4],memdata[5],memdata[6],memdata[7]} = {6'd35,5'b0,5'd2,16'd0};
				{memdata[8],memdata[9],memdata[10],memdata[11]} = {6'd8,5'd0,5'd6,16'b0};
				{memdata[12],memdata[13],memdata[14],memdata[15]} = {6'd8,5'b0,5'd9,16'b0};
				{memdata[16],memdata[17],memdata[18],memdata[19]} = {6'd8,5'd0,5'd7,16'd20};
				//{memdata[20],memdata[21],memdata[22],memdata[23]} = {6'd8,5'b0,5'd10,16'd38};
				{memdata[24],memdata[25],memdata[26],memdata[27]} = {6'd35,5'd6,5'd1,16'd0};
				{memdata[28],memdata[29],memdata[30],memdata[31]} = {6'd0,5'd2,5'd1,5'd4,5'd0,6'd34};
				{memdata[32],memdata[33],memdata[34],memdata[35]} = {6'd0,5'd4,5'd8,5'd5,5'd0,6'd36};
				{memdata[36],memdata[37],memdata[38],memdata[39]} = {6'd4,5'd5,5'd0,16'd2};
				{memdata[40],memdata[41],memdata[42],memdata[43]} = {6'd0,5'd0,5'd1,5'd2,5'd0,6'd32};
				{memdata[44],memdata[45],memdata[46],memdata[47]} = {6'd0,5'd0,5'd9,5'd3,5'd0,6'd32};	
				{memdata[48],memdata[49],memdata[50],memdata[51]} = {6'd8,5'd9,5'd9,16'd1};			
				{memdata[52],memdata[53],memdata[54],memdata[55]} = {6'd8,5'd6,5'd6,16'd4};
				{memdata[56],memdata[57],memdata[58],memdata[59]} = {6'd4,5'd9,5'd7,16'd1};
				{memdata[60],memdata[61],memdata[62],memdata[63]} = {6'd2,26'd6};
				{memdata[64],memdata[65],memdata[66],memdata[67]} = {6'd43,5'd0,5'd2,16'd100};
				{memdata[68],memdata[69],memdata[70],memdata[71]} = {6'd43,5'd0,5'd3,16'd104};
			
			
        end

		
		//assign inst = {memdata[pc],memdata[pc+1],memdata[pc+2],memdata[pc+3]}; 
always @(*)
 begin
			inst = {memdata[pc],memdata[pc+1],memdata[pc+2],memdata[pc+3]};
        end
endmodule