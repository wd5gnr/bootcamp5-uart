`default_nettype none
`timescale 1ns/10ps

module test(input clk, output RS232_Tx,input RS232_Rx, input PMOD10,output PMOD1,output PMOD2,
	    output LED1, output LED2, output LED3, output LED4, output LED5);
   wire 	   reset;
   reg 		   [4:0] pordone;
   wire 	   por;
   
   assign por=~&pordone;  // since all ice40 registers go zero on reset, this will give us a power on reset (POR)
   
   reg [7:0] char=8'h30;  // send "0" to start
   reg 	     sendchar=1'b0;  // assert to send a character

   wire busy;

   defparam x.BAUD=115200;
   defparam x.CLOCK=12_000_000;
   defparam x.OVERSAMPLE=1;

   
// blinking lights and external reset plus test points
   assign PMOD1= RS232_Tx;
   assign PMOD2= sendchar;
    
   assign reset=PMOD10|por;
   assign LED5=busy;
   assign LED4=char[3];
   assign LED3=char[2];
   assign LED2=char[1];
   assign LED1=char[0];



// clear the POR first time in
   always @(posedge clk)
     begin
     if (por) pordone<=pordone+1;
     end



   
   xmit x(clk,reset,char,sendchar,RS232_Tx,busy);
   
`ifndef FAST  // The code below is for "slow" characters; makes the LEDs pretty and easy to watch on scope
// Use the baudrate generator to make roughly 600uS tick
   brg #(.BAUD(100)) ticker(clk,por,tick);

   wire tick;
   reg [7:0] tickct=8'hff;

// Note: At faster baud rates, sendchar may be on longer than the character and this will cause repeated characters 
   always @(posedge clk)
     begin

	if (tick==1 && reset==0)
	  begin
	     if (tickct==0) 
	       begin 
		  if (busy==0)
		    begin
		       sendchar<=1;
		       if (char==8'h39) char<=8'h30;  else char<=char+1;
		       tickct<=8'hff;
		    end
	       end
	     else 
	       begin
		  tickct<=tickct-1;
		  sendchar<=0;
	       end
	  end // if (tick)
     end
`else  // This sends as fast as the UART will let us
// Note, going this fast (1 stop bit only)
// You may get framing errors when trying to connect
// A reset should clear this (leave the terminal on)
// or add just a little delay before doing a sendchar
   always @(posedge clk)
     begin
     if (reset==0)
       if (busy==0)
	 begin
	    sendchar<=1;
	 end
       else
	 begin
	    sendchar<=0;
	    if (char==8'h39) char<=8'h30; else char<=char+1;
	 end
     end
`endif
endmodule
