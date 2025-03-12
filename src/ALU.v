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
reg [31:0] f;
always @(*) begin
    f = A-B;
    if(ALUctl == 4'b0000)begin
        ALUOut <= A+B;
    end
    if(ALUctl == 4'b0001)begin
        ALUOut <= A-B;
    end
    if(ALUctl == 4'b0010)begin
        ALUOut <= A&B;
    end
    if(ALUctl == 4'b0011)begin
        ALUOut <= A|B;
    end
    if(ALUctl == 4'b0100 )begin
        if(f[31] == 1'b1 || f==0)begin
            ALUOut<=0;
        end else begin ALUOut<=1;
        end
    end
    if(ALUctl == 4'b1001)begin
        ALUOut <= (A+B)&~32'b1;
        
    end 
    
end
    
endmodule

