//                              -*- Mode: Verilog -*-
// Filename        : bta.v
// Description     : bus transfer assignment
// Author          : Sriram
// Created On      : Sun Jul 12 22:13:55 2015
// Last Modified By: .
// Last Modified On: .
// Update Count    : 0
// Status          : Unknown, Use with caution!
////////////////////////////////////////////////////

module bta( move,
	    A,
	    rd,
	    wr,
	    clk,
	    cs,
	    reset,
	    D,
	    rega,
	    regb,
	    regc,
	    regd,
	    rege,
	    regf,
	    regg,
	    SP,
	    oe);
   
   
   input move;
   input [2:0] A;
   input rd;
   input wr;
   input clk;
   input cs;
   input reset;
   inout [7:0] D;
   output [7:0] rega;
   output [7:0] regb;
   output [7:0] regc;
   output [7:0] regd;
   output [7:0] rege;
   output [7:0] regf;
   output [7:0] regg;
   output [7:0] SP;
   output 	oe;
   reg 		oe; 
   reg 		flagr;
   reg 		flagw;
   reg [7:0] 	rega;
   reg [7:0] 	regb;
   reg [7:0] 	regc;
   reg [7:0] 	regd;
   reg [7:0] 	rege;
   reg [7:0] 	regf;
   reg [7:0] 	regg;
   reg [7:0] 	SP;
   reg 		flagrw;
   
   
   
   always @(rd or wr)
     begin
	flagr=((~rd)&&(wr));
	flagw=((~wr)&&(rd));
	flagrw=((~wr)||(~rd));
	
     end
   

   assign D=((!flagr)?8'bz:((A==3'b000)?rega:(((A==3'b001))?8'bz:(((A==3'b010))?regc:(((A==3'b011))?regd:(((A==3'b100))?rege:(((A==3'b101))?regf:(((A==3'b110))?regg:(((A==3'b111))?SP:8'bz)))))))));
 

 //  assign D=((!flagr)?8'bz:rega);
   

   
   
   always @(posedge clk or negedge reset)
     begin
	if(~reset)
	  begin
	     oe<=1'b0;
	     rega<=8'b11111110;
	     regb<=8'b0;
	     regc<=8'b0;
	     regd<=8'b0;
	     rege<=8'b0;
	     regf<=8'b0;
	     regg<=8'b0;
	     SP<=8'b0;
	  end // if (~reset)
	else if(cs)
	  begin
	     rega<=rega;
	     regb<=regb;
	     regc<=regc;
	     regd<=regd;
	     rege<=rege;
	     regf<=regf;
	     regg<=regg;
	     SP<=SP;
	  end // if (cs)
	else
	  begin
	     case (A)
	       
	       3'b000: 
		 begin
		    if(move)
		      SP<=rega;
		    else if(flagr)
		      begin
			 oe<=1'b0;
			 //D<=rega;
			      
		      end
		    else if(flagw)
		      begin
			 oe<=1'b1;
		      end
		    else if(flagrw)
		      begin
			 oe<=1'b0;
		      end
		    else
		      begin
			 rega<=rega;
		      end // else: !if(!move)
		 end // case: 000
	       
	       3'b001:
		 begin
		    if(move)
		      SP<=SP;
		    else if(flagw)
		      begin
			 oe<=1'b1;
			 regb<=D;
			 
		      end
		    else if(flagr)
		      begin
			 oe<=1'b1;
		      end
		    else if(flagrw)
		      begin
			 oe<=1'b1;
			 regb<=D;
		      end
		    else
		      regb<=regb;
		    
		 end // case: 001
	       
	       3'b010:
		 begin
		    if(move)
		      SP<=regc;
		    else if(flagr)
		      begin
			 oe<=1'b0;
		      end
		    else if(flagw)
		      begin
			 oe<=1'b1;
			 regc<=D;
		      end
		    else if(flagrw)
		      begin
			 regc<=D;
			 oe<=1'b0;
		      end
		    else
		      regc<=regc;
		    
		 end // case: 3'b010
	       
	      
	       3'b011:
		  begin
		     
		     if(move)
		       SP<=regd;
		     
		     else if(flagr)
		       begin
			  oe<=1'b1;
    
		       end
		    else if(flagw)
		      begin
			 oe<=1'b1;
			 regd<=D;
		      end
		    else if(flagrw)
		      begin
			 oe<=1'b0;
			 regd<=D;
		      end
		    else
		      regd<=regd;
		  end // case: 011   
	       
     
	       3'b100:
		 begin
		    if(move)
		      SP<=rege;
		    else if(flagr)
		      begin
			 oe<=1'b0;
			 
		      end
		    else if(flagw)
		      begin
			 oe<=1'b1;
			 rege<=D;
		      end
		    else if(flagrw)
		      begin
			 rege<=D;
			 oe<=1'b0;
			 
		      end
		    else
		      rege<=rege;
		    
		 end // case: 3'b100
	       

	       3'b101:
		 begin
		    if(move)
		      SP<=regf;
		    else if(flagr)
		      begin
			 oe<=1'b0;
		      end
		    else if(flagw)
		      begin
			 oe<=1'b1;
			 regf<=D;
		      end
		    else if(flagrw)
		      begin
			 regf<=D;
			 oe<=1'b0;
			 
			 end
		    else
		      begin
			 regf<=regf;
		      end
		    
		    
		 end // case: 3'b101
	       

	       
	       3'b110:
		 begin
		    if(move)
		      SP<=regg;
		    
		    else if(flagr)
		      begin
			 oe<=1'b0;
			 
		      end
		    else if((flagw))
		      begin
			 oe<=1'b1;
			 regg<=D;
		      end
		    else if(flagrw)
		      begin
			 regg<=D;
			 oe<=1'b0;
			 
		      end
		    else
		      regg<=regg;
	  
		 end // case: 3'b110
	       

	       3'b111:
		 begin
		    if(flagr)
		      begin
			 oe<=1'b0;			 
		      end
		/*    else if((flagw)&&(move))
		      begin
			 oe<=1'b1;
			 SP<=D;
			 end
		    else if(flagrw)
		      begin
			 oe<=1'b0;
			 SP<=D;
		      end  */
		    else
		      SP<=SP;
		    
		 end // case: 3'b111
	       
	   
	     endcase // case (A)
	     
	  end // else: !if(cs)
	

     end // always @ (posedge clk or negedge reset)

endmodule // bta






		      