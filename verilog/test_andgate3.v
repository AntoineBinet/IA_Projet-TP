`timescale 1ns / 1ps

module stimulus;
    // Inputs
    reg x;
    reg y;
    reg z;
    // Outputs
    wire s;
    // Instantiate the Unit Under Test (UUT)
    AND_gate3 uut (
        x,
        y,
        z,
        s
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,stimulus);
        // Initialize Inputs
        x = 0;
        y = 0;
        z = 0;

        #20 x = 1;
        #20 y = 1;
        #20 z = 1;
        #20 x = 0;
        #20 y = 0;
        #20 z = 1;
        #40 ;

    end

    initial begin
        $monitor("t=%3d x=%d,y=%d,z=%d,s=%d \n",$time,x,y,z,s);
    end

endmodule