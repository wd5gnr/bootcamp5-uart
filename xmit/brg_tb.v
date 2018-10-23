`default_nettype none
`timescale 1ns/10ps
module tb();

reg clk=0;
reg reset=0;
   
wire baud;
  
   brg dut(clk,reset,baud);
  
always
  #41.667 clk=~clk;
  
initial
  begin
  $dumpfile("dumpvars.vcd");
  $dumpvars;
  #10 reset=1'b1;
  #100 reset=1'b0;
  #100000 $finish;
  end
  
endmodule
