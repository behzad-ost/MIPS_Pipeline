module datapath
  (input clk, regWrite, PCrst,
   input [1:0]wAddSel,
   input [1:0]wDataSel,
   input signOrZero,
   input bdsel,
   input [2:0]ALUfunc,
   input [1:0]PCMUXSel,
   input memRead,
   input [1:0]IDdatasel,
   input memWrite,
   input dSel,
   input beq,bnq,
   output [5:0]OPcode,
   output [5:0]func,
   output zero
  );
  
  supply1 Vcc;
  supply0 Gnd;
  
  wire [31:0]PC;
  wire [31:0]PCIn;

  wire [63:0] IF_ID_out;
  reg IF_ID_flush;
  wire [31:0]Inst;
  wire [31:0]PCPlus4;
  wire [4:0]writeAddr;
  wire [31:0]writeData;
  wire [31:0]beqbnq;
  wire [31:0]shifted;
  wire [31:0]rdDataA ,rdDataB;
  wire [31:0]signExtended;
  wire COut;
  wire [31:0]IDdata;
  wire [31:0]MemOut;
  wire [31:0]ALUOut;
  wire [70:0] Mem_WB_out;  
  wire [72:0] EX_Mem_out;
  wire [125:0] ID_EX_out;
  wire PCld, IF_ID_ld;
  reg PCload;
  
  
  
//---------------------------------------------------IF---------------------------------------------------------------//
  Register #(32) PCReg(clk, PCld, PCrst , PCIn, PC);
  Adder #(32) PCAdder(PC, 32'd4, PCPlus4, COut);
  MUX #(32) PCMUX(PCPlus4, beqbnq, {PCPlus4[31:28],IF_ID_out[25:0],2'b0}, rdDataA, PCMUXSel, PCIn); 

  InstructionMemory InstMem
  (PC,
   clk,
   Inst
  );
  stageRegister #(64) IF_ID(clk, IF_ID_ld , 0 , {PCPlus4,Inst}, IF_ID_out);
  
//----------------------------------------------------ID----------------------------------------------------------------//
  //IF_ID_out[63:32] = PC+4
  //IF_ID_out[31:0]  = Inst
  
  assign OPcode = IF_ID_out[31:26];
  assign func = IF_ID_out[5:0];
  wire [31:0]A , B;
  
  RegFile regFile(
    clk,
    1'b0,   // reset
    Mem_WB_out[70],
    Mem_WB_out[4:0],
    writeData,
    IF_ID_out[25:21],
    A,
    IF_ID_out[20:16],
    B);
  
  HazardDetect hazard_detect(IF_ID_out[25:21],IF_ID_out[20:16],ID_EX_out[14:10], ID_EX_out[123],PCMUXSel[1],PCld,IF_ID_ld);
  
  wire [9:0] ID_ControllSignals;
  equalCheck EQ(rdDataA, rdDataB, zero);
  
  SignExtend sgn(IF_ID_out[15:0], signOrZero, signExtended);
  Adder #(32) BeqBnqAdder(shifted, PCPlus4, beqbnq, COut);
  Shifter #(32) BeqShifetr(signExtended,shifted);
  MUX #(32) ID_data_Mux(signExtended,{IF_ID_out ,16'b0 }, IF_ID_out[63:32], 32'b0, IDdatasel, IDdata);
  wire [9:0]ID_controll_signals;
  assign ID_controll_signals = {regWrite,dSel,memRead,memWrite,ALUfunc,wAddSel,bdsel};
  wire ID_flush_sel ;
  assign ID_flush_sel = (beq&zero) | (bnq& ~zero);
  MUX #(10) ID_flush_Mux(ID_controll_signals , 10'b0, 10'b0, 10'b0, {1'b0,~PCld}, ID_ControllSignals);
  assign ID_flush_sel = 1'b0; /* hazard detect | ID_flush_controller*/  //=>~PCld
  
  wire [1:0] beqfwA,beqfwB;
  
  MUX #(32) regFile_out1_Mux(A,ALUOut,0, 0 , beqfwA, rdDataA);
  MUX #(32) regFile_out2_Mux(B,ALUOut,0, 0 , beqfwB, rdDataB);
  
  beqForwardUnit beqfw(writeAddr,IF_ID_out[25:21],IF_ID_out[20:16] , ID_EX_out[125],beq,bnq, beqfwA ,beqfwB);
  
  
  stageRegister #(126) ID_EX(clk , 1 , 0 , {ID_ControllSignals, rdDataA , rdDataB ,
											IDdata ,IF_ID_out[25:21], IF_ID_out[20:16], IF_ID_out[20:16], IF_ID_out[15:11]} , ID_EX_out); 
											
//-----------------------------------------------------EX-----------------------------------------------------------------//
  //ID_EX_out[0:4] = waddr2 Rd;
  //ID_EX_out[5:9] = waddr1 Rt;
  //ID_EX_out[10:14] = addrA Rt;
  //ID_EX_out[15:19] = addrB Rs;
  //ID_EX_out[20:51] = IDdata;
  //ID_EX_out[52:83] = B;
  //ID_EX_out[84:115] = A;
  //ID_EX_out[116:121] = EX_control;
  //ID_EX_out[122:123] = Mem_control;
  //ID_EX_out[124:125] = WB_control;

  wire [1:0]forwardA,forwardB;
  wire [31:0]ALUin1;
  wire [31:0]ALUin2;
  wire [31:0]bdwire;
  
  wire Z0;

  MUX #(32) bd_Mux(ID_EX_out[83:52], ID_EX_out[51:20], 32'b0 , 32'b0 , {1'b0, ID_EX_out[116]} , bdwire);
  MUX #(32) ALU_in1_Mux(ID_EX_out[115:84], writeData  , EX_Mem_out[68:37], 32'b0, forwardA, ALUin1);
  MUX #(32) ALU_in2_Mux(bdwire, writeData , EX_Mem_out[68:37], 32'b0, forwardB, ALUin2);
  
  ALU myALU(ALUin1, ALUin2, ID_EX_out[121:119]/*ALUfunc*/ , ALUOut, Z0);
  
  wire [3:0] Mem_WB_control;
  MUX #(4) EX_flush_Mux(ID_EX_out[125:122], 4'b0, 4'b0, 4'b0, 2'b0 /*EX_flush  from Hazard detect*/, Mem_WB_control);
  
  MUX #(5) writeAddr_Mux(ID_EX_out[9:5], ID_EX_out[4:0], 5'd31, 5'b0, ID_EX_out[118:117], writeAddr);

  ForwardUnit forward_unit(EX_Mem_out[4:0],Mem_WB_out[4:0],ID_EX_out[19:15],ID_EX_out[14:10],EX_Mem_out[72],ID_EX_out[125],forwardA,forwardB);
  
  wire [31:0]EXdata;
  
  wire EXdata_sel ;
  assign EXdata_sel = ID_EX_out[122] ? ~ID_EX_out[116] : ID_EX_out[116];
  MUX #(32) EX_data_Mux(ID_EX_out[83:52], ID_EX_out[51:20], 32'b0 , 32'b0 , {1'b0, EXdata_sel} , EXdata);
  
  stageRegister #(73) EX_Mem(clk, 1, 0, {Mem_WB_control,ALUOut,EXdata,writeAddr} , EX_Mem_out);
  
 //----------------------------------------------------MEM-------------------------------------------------------------------//
	//EX_Mem_out[72:71] = WB_control;
	//EX_Mem_out[70:69] = Mem_control;
	//EX_Mem_out[68:37] = AluOut;
	//EX_Mem_out[36:5]  = EXdata;
	//EX_Mem_out[4:0]   = writeAddr ;
  
  
  Memory Mem
  (clk,
   EX_Mem_out[70], // read
   EX_Mem_out[69], // write
   EX_Mem_out[68:37],
   MemOut,
   EX_Mem_out[36:5]  // Write Data
  );
  
  wire [31:0] Memdata;
  MUX #(32) Mem_data_Mux(MemOut, EX_Mem_out[36:5], 32'b0 , 32'b0 , {1'b0, ~EX_Mem_out[70]} , Memdata);
  stageRegister #(71) Mem_WB(clk, 1, 0, {EX_Mem_out[72:71], EX_Mem_out[68:37], Memdata, EX_Mem_out[4:0]} , Mem_WB_out);
  
 //----------------------------------------------------WB---------------------------------------------------------------------// 
	//Mem_WB_out[70:69] = WB_control;
	//Mem_WB_out[68:37] = ALUOut;
	//Mem_WB_out[36:5]  = MemOut;
	//Mem_WB_out[4:0]  = writeAddr;

  MUX #(32) wDataMUX(Mem_WB_out[36:5], Mem_WB_out[68:37], 32'b0, 32'b0, {1'b0,Mem_WB_out[69]}, writeData);

endmodule
