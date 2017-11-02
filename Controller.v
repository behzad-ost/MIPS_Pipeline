module MIPS_Controller(
input [5:0] opcode,
input [5:0]	func,
input zero, 
output reg [1:0] wAddSel,
output reg [1:0] wDataSel,
output reg [1:0] PCMUXSel,
output reg [1:0] IDdatasel,
output reg [2:0] ALUfunc,
output reg PCld,
output reg regwrite,
output reg bdsel,
output reg dsel,
output reg signextend,
output reg memread,
output reg memwrite,
output reg beq,
output reg bnq);

always @ (opcode , func, zero) begin
	wAddSel<=2'b0;
	wDataSel<=2'b0;
	PCMUXSel<=2'b0;
	ALUfunc<=3'b0;
	regwrite<=1'b0;
	dsel<=1'b0;
	signextend<=1'b0;
	beq<=1'b0;
	bnq<=1'b0;
	memread<=1'b0;
	memwrite<=1'b0;
	bdsel<=1'b0;
	IDdatasel=2'b0;
	PCld<=1'b0;

	//ldLoHi <= 1'b0;

//ALU_Controller(func,ALUfunc);

	case (opcode) 
		//R-Type
		0 : case (func) 
				//add
				32 : begin 
					 	wAddSel<=2'b01;
					 	regwrite<=1'b1;
					 	dsel<=1'b1;
					 	ALUfunc<=3'b000;
					 end	
				//sub
				34 : begin
						 wAddSel<=2'b01;
						 regwrite<=1'b1;
						 dsel<=1'b1;
						 ALUfunc<=3'b001;
					 end
				//and
				36 : begin
						 wAddSel<=2'b01;
						 regwrite<=1'b1;
						 dsel<=1'b1;
						 ALUfunc<=3'b010;
					 end	 	
				//or
				37 : begin
					 	wAddSel<=2'b01;
					 	regwrite<=1'b1;
					 	dsel<=1'b1;
					 	ALUfunc<=3'b011;
					 end
				//xor
				38 : begin
						 wAddSel<=2'b01;
						 regwrite<=1'b1;
						 dsel<=1'b1;
						 ALUfunc<=3'b100;
					 end
				//mult
				40 : begin
						 //regwrite<=1'b1;
						 //ldLoHi<=1'b1;
						 ALUfunc<=3'b101;
					 end
				//mflo
				18 : begin
						 wAddSel<=2'b01;
						 regwrite<=1'b1;
						 dsel<=1'b1;
						 ALUfunc<=3'b111;
						 //aluin2sel<=2'b10;
					 end
				//mfhi
				16 : begin
						 wAddSel<=2'b01;
						 regwrite<=1'b1;
						 dsel<=1'b1;
						 ALUfunc<=3'b110;
						 //aluin2sel<=2'b11;
					 end
				//jr
				8  : PCMUXSel<=2'b11;
			   endcase					
		//addi
		8  : begin
				 regwrite<=1'b1;
				 ALUfunc<=3'b000;
				 dsel<=1'b1;
				 signextend<=1'b1;
				 bdsel<=1'b1;
			 end
		//andi
		12 : begin 
			 	 regwrite<=1'b1;
				 ALUfunc<=3'b010;
				 dsel<=1'b1;
				 bdsel<=1'b1;
		     end
		//ori
		13 : begin
				 regwrite<=1'b1;
				 ALUfunc<=3'b011;
				 dsel<=1'b1;
				 bdsel<=1'b1;
			 end
		//xori
		14 : begin
			  	 regwrite<=1'b1;
				 ALUfunc<=3'b100;
				 dsel<=1'b1;
				 bdsel<=1'b1;
			 end
		//lw
		35 : begin
				 //wAddSel<=2'b00;
				 regwrite<=1'b1;
				 //ALUfunc<=3'b000;
				 signextend<=1'b1;
				 memread<=1'b1;
				 bdsel<=1'b1;
			 end
		//sw
		43 : begin
				 //ALUfunc<=3'b000;
				 signextend<=1'b1;
				 memwrite<=1'b1; 
				 bdsel<=1'b1;
			 end
		//lui
		15 : begin
				 //wAddSel<=2'b01;
				 wDataSel<=2'b10;
				 regwrite<=1'b1;
				 bdsel<=1'b1;
				 IDdatasel<=1'b1;
			 end
		//j
		2  : PCMUXSel<=2'b10;
			 
		//jal
		3  : begin
			 	 PCMUXSel<=2'b10;
				 wAddSel<=2'b10;
				 wDataSel<=2'b10;
				 regwrite<=1'b1;
			 end
		//beq
		4  : begin
				 ALUfunc<=3'b001;
				 PCMUXSel <= zero ? 2'b01 : 2'b00;
				 beq<=1'b1;
			 end
		//bnq 
		5  : begin
				 ALUfunc<=3'b001;
				 PCMUXSel <= ~zero ? 2'b01 : 2'b00;
				 bnq<=1'b1;
			 end
	endcase
end
endmodule
