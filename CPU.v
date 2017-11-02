module CPU(input clk,PCrst);
wire zero;
wire [5:0]OPcode,func;

wire [1:0] wAddSel,
		   wDataSel, 
		   PCMUXSel,
		   IDdatasel;
		   
wire [2:0] ALUfunc;
wire regwrite,
	 dsel,
	 bdsel,
	 signOrZero,
	 memread,
 	 memwrite,
  	 beq,
 	 bnq,
	 PCld;

MIPS_Controller MIPS_CU(
OPcode,
func,
zero, 
wAddSel,
wDataSel,
PCMUXSel,
IDdatasel,
ALUfunc,
PCld ,
regwrite,
bdsel,
dsel,
signOrZero,
memread,
memwrite,
beq,
bnq);


datapath MIPS_DP
  (clk, regwrite, PCrst,
   wAddSel,
   wDataSel,
   signOrZero,
   bdsel,
   ALUfunc,
   PCMUXSel,
   memread,
   IDdatasel,
   memwrite,
   dsel,
   beq,bnq,
   OPcode,
   func,
   zero
  );
  
 endmodule