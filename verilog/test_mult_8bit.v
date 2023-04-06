`timescale 1ns / 1ps

module test_multiplier_8b;

    // Inputs
    reg [7:0] a, b;
    
    // Outputs
    wire [15:0] result;
    
    // Instantiate the Unit Under Test (UUT)
    multiplier_8b uut (
        .a(a), 
        .b(b), 
        .result(result)
    );
 
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, test_multiplier_8b);
        
        // Initialize Inputs
        a = 5;
        b = 10;
 
        // Wait 100 ns for output to stabilize
        #100;
        
        // Change inputs
        a = 3;
        b = 8;
        
        // Wait 100 ns for output to stabilize
        #100;
        
        // Change inputs
        a = 15;
        b = 7;
        
        // Wait 100 ns for output to stabilize
        #100;
        
        // Change inputs
        a = 0;
        b = 255;
        
        // Wait 100 ns for output to stabilize
        #100;
        
        // Change inputs
        a = 100;
        b = 0;
        
        // Wait 100 ns for output to stabilize
        #100;
        
        $finish;
    end
    
    initial begin
        $monitor("a=%d, b=%d, result=%d", a, b, result);
    end

endmodule