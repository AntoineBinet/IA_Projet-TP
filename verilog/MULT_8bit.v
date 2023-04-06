module multiplier_8b(a, b, result);
    input [7:0] a, b;
    output reg [15:0] result;
    
    always @(*) begin
        result = a * b;
    end
    
endmodule