module Control (
    input [6:0] opcode,         // opcode field of instruction
    output reg memRead,         // memory read signal
    output reg [1:0] memtoReg,  // memory to register signal
    output reg [2:0] ALUOp,     // ALU operation signal
    output reg memWrite,        // memory write signal
    output reg ALUSrc1,         // ALU source 1 signal (for MUX)
    output reg ALUSrc2,         // ALU source 2 signal (for MUX)
    output reg regWrite,        // register write signal
    output reg PCSel            // PC select signal (for MUX PC)
);

    // TODO: implement your Control here
    // Hint: follow the Architecture (figure in spec) to set output signal

    always @(*) begin
        case (opcode[6:2])
            5'b01100: begin // r type
                memRead <= 0;
                memtoReg <= 0;
                ALUOp <= 3'b000;
                memWrite <= 0;
                ALUSrc1 <= 0;
                ALUSrc2 <= 0;
                regWrite <= 1;
                PCSel <= 0;
            end

            5'b00100: begin // i type
                memRead <= 0;
                memtoReg <= 0;
                ALUOp <= 3'b000;
                memWrite <= 0;
                ALUSrc1 <= 0;
                ALUSrc2 <= 1;
                regWrite <= 1;
                PCSel <= 0;
            end

            5'b00000: begin // i type
                memRead <= 1;
                memtoReg <= 1;
                ALUOp <= 3'b010;
                memWrite <= 0;
                ALUSrc1 <= 0;
                ALUSrc2 <= 1;
                regWrite <= 1;
                PCSel <= 0;
            end

            5'b01000: begin // s type
                memRead <= 0;
                memtoReg <= 0;
                ALUOp <= 3'b010;
                memWrite <= 1;
                ALUSrc1 <= 0;
                ALUSrc2 <= 1;
                regWrite <= 0;
                PCSel <= 0;
            end

            5'b11000: begin // b type
                memRead <= 0;
                memtoReg <= 0;
                ALUOp <= 3'b100;
                memWrite <= 0;
                ALUSrc1 <= 1;
                ALUSrc2 <= 1;
                regWrite <= 0;
                PCSel <= 1;
            end

            5'b11011: begin // j type
                memRead <= 0;
                memtoReg <= 2;
                ALUOp <= 3'b010;
                memWrite <= 0;
                ALUSrc1 <= 1;
                ALUSrc2 <= 1;
                regWrite <= 1;
                PCSel <= 1;
            end

            5'b11001: begin // j type
                memRead <= 0;
                memtoReg <= 2;
                ALUOp <= 3'b010;
                memWrite <= 0;
                ALUSrc1 <= 0;
                ALUSrc2 <= 1;
                regWrite <= 1;
                PCSel <= 1;
            end
        endcase
    end

endmodule