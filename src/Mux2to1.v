module Mux2to1 #(
    parameter size = 32
) 
(
    input sel,                      // Selector
    input signed [size-1:0] s0,     // Input 0
    input signed [size-1:0] s1,     // Input 1
    output signed [size-1:0] out    // Output
);
    // TODO: implement your 2to1 multiplexer here
    reg [size-1:0] tmp ;
    always @(*) begin
        if(sel) begin
            tmp = s1;
        end else begin
            tmp = s0;
        end
    end
    assign out = tmp;
endmodule

