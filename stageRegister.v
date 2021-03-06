module stageRegister #(parameter size=8) (input clk, ld, rst, input [size-1:0]data, output reg [size-1:0]O);
  //reg [size-1:0]temp;
  always @(posedge clk, posedge rst) begin
    if(rst)
	  O <= {(size){1'b0}};
	else if(ld)
      O <= data;
  end
endmodule	
