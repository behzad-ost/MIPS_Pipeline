module HazardDetect(input [4:0]R1,R2,Rw,input memread,jump , output reg PCld , IF_ID_ld);
	initial begin
		IF_ID_ld=1;
		PCld=1;
	end
	
	always@(R1,R2,Rw,memread,jump)begin	
			if(memread &&((R1==Rw)|(R2==Rw)) | jump)begin
				PCld=0;
				IF_ID_ld=0;
			end
			else begin
				PCld=1;
				IF_ID_ld=1;
			end
	end
endmodule
			
