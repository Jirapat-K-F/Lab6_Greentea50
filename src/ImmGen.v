module ImmGen (
    input [31:0] inst,                  // instruction
    output reg signed [31:0] imm        // imm value (output)
);
    // ImmGen generate imm value base opcode

    wire [6:0] opcode = inst[6:0];
    always @(*) begin
        case(opcode)
            // TODO: implement your ImmGen here
            // Hint: follow the RV32I opcode map (table in spec) to set imm value
            0010011: begin 
                imm[31:12] = imm[31];
                imm[11:0] = inst[31:20];
            end
            0000011: begin 
                imm[31:12] = imm[31];
                imm[11:0] = inst[31:20];
            end
            0100011: begin 
                imm[31:12] = imm[31];
                imm[11:5] = inst[31:25];
                imm[4:0] = inst[11:7];
            end
            1100011: begin
                imm[31:13] = imm[31];
                imm[12] = inst[31];
                imm[11] = inst[7];
                imm[10:5] = inst[30:25];
                imm[4:1] = inst[11:8];
                imm[0] = 0;
            end
            1101111: begin
                imm[31:21] = imm[31];
                imm[20] = inst[31];
                imm[19:12] = inst[19:12];
                imm[11] = inst[20];
                imm[10:1] = inst[30:21];
                imm[0] = 0;
            end
            1100111: begin
                imm[31:12] = imm[31];
                imm[11:0] = inst[31:20];
            end
        endcase
    end

endmodule

