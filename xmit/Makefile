# It doesn't make sense to program the chip with test and test.pll
# So the default targets are xmit, testbrg, and testxmit
# If you want xmitpll, specify it yourself on the command line
# also note the Makefile moves the dumpvars.vcd files to keep them from conflicting

# Assumes you have icestorm, icarus, and ice40flow (https://github.com/wd5gnr/ice40flow) installed

all : testxmit xmit testbrg

testbrg : brg.vcd

brg.vcd : brg.v brg_tb.v
	iverilog -o brg brg_tb.v brg.v
	vvp brg
	mv dumpvars.vcd brg.vcd

testxmit: xmit.vcd

xmit.vcd : xmit.v xmit_clk.v brg.v clog2.v xmit_tb.v
	iverilog -o xmit xmit_tb.v xmit.v xmit_clk.v brg.v
	vvp xmit
	mv dumpvars.vcd xmit.vcd

xmit: test.txt

test.txt : xmit.v xmit_clk.v brg.v clog2.v test.v
	ice40flow test

xmitpll : test-pll.txt

test-pll.txt : xmit.v xmit_clk.v brg.v clog2.v test-pll.v
	ice40flow test-pll

clean:
	rm brg.vcd xmit.vcd test.txt test-pll.txt test.bin test-pll.bin test.blif test-pll.blif test.rpt test-pll.rpt brg xmit; true


