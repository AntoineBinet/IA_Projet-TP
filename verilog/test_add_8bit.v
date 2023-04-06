`timescale 1ns/1ps

module test_adder_8bit();

    // Inputs
    reg [7:0] a;
    reg [7:0] b;

    // Outputs
    wire [7:0] result;

    // Instantiate the Unit Under Test (UUT)
    ADD_8bit uut (
        .a(a),
        .b(b),
        .result(result)
    );

    // Stimulus
    initial begin
        $dumpfile("test_adder_8bit.vcd");
        $dumpvars(0, test_adder_8bit);

        a = 8'h00;
        b = 8'h00;
        #10;

        a = 8'h05;
        b = 8'h06;
        #10;

        a = 8'h07;
        b = 8'h08;
        #10;

        a = 8'haa;
        b = 8'h01;
        #10;

        a = 8'hff;
        b = 8'hff;
        #10;

        $finish;
    end

    // Monitor
    initial begin
        $monitor("a = %d, b = %d, result = %d", a, b, result);
    end

endmodule