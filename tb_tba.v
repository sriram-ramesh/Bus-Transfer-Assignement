//                              -*- Mode: Verilog -*-
// Filename        : tb_tba.v
// Description     : test bench for transfer assignment
// Author          : Sriram
// Created On      : Sun Jul 12 22:45:39 2015
// Last Modified By: .
// Last Modified On: .
// Update Count    : 0
// Status          : Unknown, Use with caution!
///////////////////////////////////////////////////

 `include "bta.v"

module tb_tba();
   
   reg move;
   reg [2:0] A;
   reg 	     rd;
   reg 	     wr;
   reg 	     clk;
   reg 	     cs;
   reg 	     reset;
   wire [7:0] D;
   wire [7:0]  registera;
   wire [7:0]  registerb;
   wire [7:0]  registerc;
   wire [7:0]  registerd;
   wire [7:0]  registere;
   wire [7:0]  registerf;
   wire [7:0]  registerg;
   wire [7:0]  SP;
   wire        oe;

   reg [7:0]   temp;
   
   initial
     begin
	temp=8'b01111111;
	clk=1'b0;
	reset=1'b0;
	rd=1'b1;
	wr=1'b1;
	A=3'b0;
      	move=1'b0;
	cs=1'b1;
	#5 reset=1'b1;
	#5 cs=1'b0;
	
	
	
	
     end // initial begin
   initial
     begin
	A=3'b000;
	#25 A=3'b001;
	#10 A=3'b010;
	#10 A=3'b011;
	#10 A=3'b100;
	#10 A=3'b101;
	#10 A=3'b110;
	#10 A=3'b111;
	
	#70 A=3'b000;
	#10 A=3'b001;
	
	#10 A=3'b010;	
	#10 A=3'b011;
	#10 A=3'b100;
	#10 A=3'b101;
	#10 A=3'b110;
	#10 A=3'b111;
	#10 move=1'b1;
	#10 A=3'b010;
	#10 A=3'b011;
	#10 A=3'b100;
	#10 A=3'b101;
	#10 A=3'b110;
	#10 A=3'b111;
	
     end // initial begin
   
   always
     #5 clk=~clk;
  
   assign 	D=(!wr?temp:8'bz);
   
   initial
     begin
	
	#35 wr=1'b0;
	#10 temp=8'b10000000;
	#20 temp=8'b10000001;
	#10 temp=8'b10000010;
	
	#40 wr=1'b1;
	
	#20 rd=1'b0;
	#100 rd=1'b1;
	
	#300 move=1'b1;
	
     end // initial begin
    
   
   /*	always @(posedge clk)
	  begin
	     A=$random;
*/	     
	  
   initial
     begin
	$monitor($time,"clk=%b,cs=%b,reset=%b,A=%b,oe=%b,move=%b,rd=%b,wr=%b,D=%b,registera=%b,registerb=%b,registerc=%b,registerd=%b,registere=%b,registerf=%b,registerg=%b,SP=%b",clk,cs,reset,A,oe,move,rd,wr,D,registera,registerb,registerc,registerd,registere,registerf,registerg,SP);
	
	$dumpfile("bta.vcd");
	$dumpvars;
	$dumpon;
	#1000 $dumpoff;
	$finish;
     end // initial begin
   
      bta m1(move,
	  A,
	  rd,
	  wr,
	  clk,
	  cs,
	  reset,
	  D,
	  registera,
	  registerb,
	  registerc,
	  registerd,
	  registere,
	  registerf,
	  registerg,
	  SP,
	  oe);
  
endmodule // tb_tba




