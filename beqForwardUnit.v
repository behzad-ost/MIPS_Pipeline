module beqForwardUnit(input [4:0]EXRd,IDRs,IDRt , input EX_regwrite,beq,bnq, output reg [1:0] forwardA ,forwardB);
	
	always @ (*) begin
		if(beq|bnq) 
			if(EX_regwrite && ~(EXRd==0) && (EXRd==IDRs) )
					forwardA=2'b01;
				else	
					forwardA=2'b00;
			
		else
			forwardA=2'b00;
		
	end
	
	always @ (*) begin
		if(beq|bnq) 
			if(EX_regwrite && ~(EXRd==0) && (EXRd==IDRt) )
					forwardB=2'b01;
				else	
					forwardB=2'b00;
			
		else
			forwardB=2'b00;
		
	end
	
endmodule