`default_nettype none
`timescale 1ns/10ps

module xmit_tb();
   reg clk=1'b0;
   reg reset=1'b0;
   reg [7:0] char=8'h55;
   reg sendchar=1'b0;
   wire txpin, busy;

   defparam dut.BAUD=115200;  // nice for simulation!
   defparam dut.OVERSAMPLE=1;
   xmit dut(clk, reset, char, sendchar, txpin, busy);
   

   always
     #41.667 clk=~clk;

   initial
     begin
	$dumpfile("dumpvars.vcd");
	$dumpvars;
	char=8'h55;
	#10 reset=1'b1;
	#100 reset=1'b0;
	#100 sendchar=1'b1;
	#400 sendchar=1'b0;
	#100000 char=8'h41;
	#10 sendchar=1'b1;
	#100 sendchar=1'b0;
     end

always
  #200_000 $finish;

endmodule   
