module Mux3to1 #(
    parameter size = 32
) 
(
    input [1:0] sel,                // Selector (2 bits)
    input signed [size-1:0] s0,     // Input 0
    input signed [size-1:0] s1,     // Input 1
    input signed [size-1:0] s2,     // Input 2
    output signed [size-1:0] out    // Output
);
    // TODO: implement your 3to1 multiplexer here
    reg [size-1:0] tmp;
    always @(*) begin
        case(sel)
            2'b00 : tmp = s0;
            2'b01 : tmp = s1;
            2'b10 : tmp = s2;
        endcase
    end
    assign out = tmp;
endmodule

