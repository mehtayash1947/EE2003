//                              -*- Mode: Verilog -*-
// Filename        : seq-mult.v
// Description     : Sequential multiplier
// Author          : Nitin Chandrachoodan

// This implementation corresponds to a sequential multiplier, but
// most of the functionality is missing.  Complete the code so that
// the resulting module implements multiplication of two numbers in
// twos complement format.

// All the comments marked with *** correspond to something you need
// to fill in.

// This style of modeling is 'behavioural', where the desired
// behaviour is described in terms of high level statements ('if'
// statements in verilog).  This is where the real power of the
// language is seen, since such modeling is closest to the way we
// think about the operation.  However, it is also the most difficult
// to translate into hardware, so a good understanding of the
// connection between the program and hardware is important.

// Expected behaviour:
// A sequential multiplier does multiplication of two numbers by using
// a "shift-and-add" approach.  It examines each bit of one of the values
// (called the "multiplier") and if the value is 1, then it adds the
// "multiplicand" to the partial product that has been accumulated up 
// to this point.  Obviously this means it takes multiple clock cycles
// to complete the multiplication.
//
// In the present template, we assume that there is also a "start" signal
// that indicates when the inputs are valid, and that any time the start
// signal is 1, the multiplier should initialize internal variables to a 
// known state.  You can assume that the start signal is only high for 1 
// cycle, and that the multiplication itself should start only when the 
// start signal is removed (made 0).  
// Finally, after performing the multiplication, the module should make
// the "done" signal high and keep it that way till the next start
// signal is received.

`define width 8
`define ctrwidth 4

module seq_mult (
		// Outputs
		p, done, 
		// Inputs
		clk, start, a, b
		) ;
		
	input 		 clk, start;
	input [`width-1:0] 	 a, b;
	
	// *** Output declaration for 'p'

	output reg [2*`width - 1 : 0] p;
	
	output reg done;
   
	// *** Register declarations for p, multiplier, multiplicand
	reg [2*`width - 1 : 0] multiplier;
	reg [2*`width - 1 : 0] multiplicand;
	

	reg [`ctrwidth : 0] 	 ctr;

	always @(posedge clk)
		if (start)
    		begin
    			done 			<= 0;
    			p 				<= 0;
    			ctr 			<= 0;
    			
    			multiplier[`width - 1 : 0] <= a; // remember to sign-extend
    			multiplicand[`width - 1 : 0] <= b;
    			
    			
			    multiplier[2*`width - 1 : `width] <= {8{a[7]}};
			    multiplicand[2*`width - 1 : `width] <= {8{b[7]}};
			
         	end
         	
     	else
         	begin 
         	
    			if (ctr < 2**(`ctrwidth) /* *** How many times should the loop run? */ ) 
    			    
    			    // *** Code for multiplication

        	  		begin
        	  		
        	  		    if(multiplier[ctr])
        	  		        begin
        	  		        
        	  		            p <= p + multiplicand;
        	  		        
        	  		        end
        	  		        
        	  		    ctr <= ctr + 1;
        	  		    multiplicand = multiplicand << 1;
        	  		    
        	  		end
    	  		else
        	  		begin
        	  		
        	     		done <= 1; 		// Assert 'done' signal to indicate end of multiplication
        	  		
        	  		end
        	  		
         	end
   
endmodule // seqmult
