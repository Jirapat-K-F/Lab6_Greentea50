module ALU (
    input [3:0] ALUctl,                     // This will be used to select the operation of ALU
    input brLt,                             // Branch Less Than (for branching instruction)
    input brEq,                             // Branch Equal (for branching instruction)
    input signed [31:0] A,B,                // Operands
    output reg signed [31:0] ALUOut         // Output of ALU
);
    // ALU has two operand, it execute different operator based on ALUctl wire

    // TODO: implement your ALU here
    // Hint: you can use operator to implement

always @(*) begin
    case (ALUctl)
        4'b0000: ALUOut <= A + B; // Add/Lw/Sw
        4'b0001: ALUOut <= A - B; // Sub
        4'b0010: ALUOut <= A & B; // And
        4'b0011: ALUOut <= A | B; // Or
        4'b0100: ALUOut <= (A < B ? 1 : 0); // Slt
        4'b0101: ALUOut <= (brEq ? A+B : A+4); // Beq
        4'b0110: ALUOut <= (!brEq ? A+B : A+4); // Bne
        4'b0111: ALUOut <= (brLt ? A+B : A+4); // Blt
        4'b1000: ALUOut <= (!brLt ? A+B : A+4); // Bge
        4'b1001: ALUOut <= A+B; // Jal/Jalr
    endcase
end
    
endmodule

