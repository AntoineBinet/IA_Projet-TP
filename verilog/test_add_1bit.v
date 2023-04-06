`timescale 1ns / 1ps
module stimulus;
	// Inputs
	reg cin;
	reg x;
	reg y;
	
	// Outputs
	wire z;
	wire cout;
	// Instantiate the Unit Under Test (UUT)
	add_1bit uut (
		cin,
		x, 
		y, 
		cout,
		z
	);
 
	initial begin
	$dumpfile("test.vcd");
    $dumpvars(0,stimulus);
		// Initialize Inputs
		cin = 0;
		x = 0;
		y = 0;

	#20 x = 1;
	#20 y = 1;
	#20 y = 0;	
	#20 x = 1;	  
	#40 ;
 
	end  
 
		initial begin
		 $monitor("t=%4d cin=%d,cout=%d,x=%d,y=%d,z=%d \n",$time,cin,cout,x,y,z, );
		 end
 
endmodule
 
 
