module SingleCycleCPU (
    input   wire        clk,
    input   wire        start,
    output  wire [7:0]  segments,
    output  wire [3:0]  an
);

// When input start is zero, cpu should reset
// When input start is high, cpu start running

// TODO: Connect wires to realize SingleCycleCPU and instantiate all modules related to seven-segment displays
// The following provides simple template,

wire signed [31:0] pc_i, pc_o, next_pc;
PC m_PC(
    .clk(clk),
    .rst(start),
    .pc_i(pc_i),
    .pc_o(pc_o)
);

Adder m_Adder_1(
    .a(pc_o),
    .b(32'd4),
    .sum(next_pc)
);

wire signed [31:0] inst;
InstructionMemory m_InstMem(
    .readAddr(pc_o),
    .inst(inst)
);

wire memRead, memWrite, aluSrc1, aluSrc2, regWrite, PCSel;
wire [1:0] memReg;
wire [2:0] aluOp;
Control m_Control(
    .opcode(inst[6:0]),
    .memRead(memRead),
    .memtoReg(memReg),
    .ALUOp(aluOp),
    .memWrite(memWrite),
    .ALUSrc1(aluSrc1),
    .ALUSrc2(aluSrc2),
    .regWrite(regWrite),
    .PCSel(PCSel)
);

// ------------------------------------------
// For Student:
// Do not change the modules' instance names and I/O port names!!
// Or you will fail validation.
// By the way, you still have to wire up these modules

wire signed [31:0] readData1, readData2, reg5Data, writeData;
Register m_Register(
    .clk(clk),
    .rst(start),
    .regWrite(regWrite),
    .readReg1(inst[19:15]),
    .readReg2(inst[24:20]),
    .writeReg(inst[11:7]),
    .writeData(writeData),
    .readData1(readData1),
    .readData2(readData2),
    .reg5Data(reg5Data)
);

wire signed [31:0] readDataMem;
wire signed [31:0] aluOut;
DataMemory m_DataMemory(
    .rst(start),
    .clk(clk),
    .memWrite(memWrite),
    .memRead(memRead),
    .address(aluOut),
    .writeData(readData2),
    .readData(readDataMem)
);

// ------------------------------------------

wire signed [31:0] imm;
ImmGen m_ImmGen(
    .inst(inst),
    .imm(imm)
);

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(PCSel),
    .s0(pc_4),
    .s1(aluOut),
    .out(pc_i)
);

wire signed [31:0] outALU1, outALU2;
Mux2to1 #(.size(32)) m_Mux_ALU_1(
    .sel(aluSrc1),
    .s0(readData1),
    .s1(pc_o),
    .out(outALU1)
);

Mux2to1 #(.size(32)) m_Mux_ALU_2(
    .sel(aluSrc2),
    .s0(readData2),
    .s1(imm),
    .out(outALU2)
);

wire [3:0] aluCtl;
ALUCtrl m_ALUCtrl(
    .ALUOp(aluOp),
    .funct7(inst[30]),
    .funct3(inst[14:12]),
    .ALUCtl(aluCtl)
);

wire less, equal;
ALU m_ALU(
    .ALUctl(aluCtl),
    .brLt(less),
    .brEq(equal),
    .A(outALU1),
    .B(outALU2),
    .ALUOut(aluOut)
);

Mux3to1 #(.size(32)) m_Mux_WriteData(
    .sel(memReg),
    .s0(aluOut),
    .s1(readDataMem),
    .s2(pc_4),
    .out(writeData)
);

BranchComp m_BranchComp(
    .rs1(readData1),
    .rs2(readData2),
    .brLt(less),
    .brEq(equal)
);

endmodule