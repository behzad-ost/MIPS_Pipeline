module ALU
   (input [31:0]dataA,
    input [31:0]dataB,
    input [2:0]sel,
    output reg [31:0]O,
    output reg zero);
    
    wire [31:0]hiReg , lowReg;
		
    always @(sel, dataA, dataB) begin
      case (sel)
        0: O <= dataA + dataB;
        1: O <= dataA - dataB;
        2: O <= dataA & dataB;
        3: O <= dataA | dataB;
        4: O <= dataA ^ dataB;
        6: O <= hiReg;
        7: O <= lowReg;
		default : O<=32'b0;
      endcase
	 zero = (dataA - dataB == 0) ? 1 : 0;
    end
    assign {hiReg , lowReg} = (sel==5) ? dataA * dataB : {hiReg , lowReg};
endmodule