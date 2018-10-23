There are several files here:

xmit.v - Transmitter with internal clock
xmit_clk.v - Transmitter with external clock (main code)
brg.v - Baudrate generator
clog2.v - Include file to replace $clog2
brg_tb.v - Testbench for brg.v
xmit_tb.v - Testbench for xmit.v
test.v - Synthesizeable test (12 MHz)
test-pll.v - Same as test.v but uses PLL
pll.v - PLL for test-pll.v
*.pcf - Constrain files
ice40flow.env - Environment for ice40flow driver for icestorm
README.txt - This file
