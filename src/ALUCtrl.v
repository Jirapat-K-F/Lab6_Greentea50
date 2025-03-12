module ALUCtrl (
    input [2:0] ALUOp,          // ALU operation
    input funct7,               // funct7 field of instruction (only 30th bit of instruction)
    input [2:0] funct3,         // funct3 field of instruction
    output reg [3:0] ALUCtl     // ALU control signal
);

    // TODO: implement your ALU control here
    // For testbench verifying, Do not modify input and output pin
    // For funct7, we care only 30th bit of instruction. Why?
    // See all R-type instructions in the lab and observe.

    // Hint: using ALUOp, funct7, funct3 to select exact operation
    
    always @(*) begin
        if (ALUOp == 3'b000 && funct7) begin
            ALUCtl <= 4'b0001; // Sub
        end else begin
            case (ALUOp)
                3'b000, 3'b001: case (funct3)
                    3'b000: ALUCtl <= 4'b0000; // Add/Addi
                    3'b010: ALUCtl <= 4'b0100; // Slt/Slti
                    3'b110: ALUCtl <= 4'b0011; // Or/Ori
                    3'b111: ALUCtl <= 4'b0010; // And/Andi
                endcase
                3'b010, 3'b011, 3'b101, 3'b110: ALUCtl <= 4'b0000; // Lw/Sw/Jal/Jalr
                3'b100: case (funct3)
                    3'b000: ALUCtl <= 4'b1010; // Beq
                    3'b001: ALUCtl <= 4'b1011; // Bne
                    3'b100: ALUCtl <= 4'b1100; // Blt
                    3'b101: ALUCtl <= 4'b1101; // Bge
                endcase
            endcase
        end
    end

endmodule

