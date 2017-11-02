module test_CPU();

reg clk=0 , PCrst=0;
CPU MIPS(clk,PCrst);



initial begin repeat(1000) #50 clk=~clk; end
initial begin #10 PCrst=1;
			  #20 PCrst=0;	
		end


endmodule	