module ForwardUnit(input [4:0]MemRd,WBRd,EXRs,EXRt , input Mem_regwrite, WB_regwrite, output reg [1:0] forwardA ,forwardB);

	always @ (MemRd,WBRd,EXRs,Mem_regwrite,WB_regwrite) begin
		if(Mem_regwrite && ~(MemRd==0) && (MemRd == EXRs))
			forwardA=2'b10;
		else if(WB_regwrite && ~(WBRd==0) && (WBRd==EXRs) && ~(MemRd==EXRs))
			forwardA=2'b01;
		else	
			forwardA=2'b00;
	end
		
	always @ (MemRd,WBRd,EXRs,Mem_regwrite,WB_regwrite) begin
		if(WB_regwrite && ~(WBRd==0) && (WBRd==EXRt) && ~(MemRd==EXRt))
			forwardB=2'b01;
		else if(Mem_regwrite && ~(MemRd==0) && (MemRd == EXRt))
			forwardB=2'b10;
		else	
			forwardB=2'b00;
	end	
	
endmodule
