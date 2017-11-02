module Shifter #(parameter busSize=32)
(input [busSize-1:0]I , output [busSize-1:0]O);
	assign O=I<<2;
endmodule
