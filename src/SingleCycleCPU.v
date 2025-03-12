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

reg [31:0] pc_i, pc_o;
PC m_PC(
    .clk(clk),
    .rst(start),
    .pc_i(pc_i),
    .pc_o(pc_o)
);

reg [31:0] pc_4;
Adder m_Adder_1(
    .a(pc_o),
    .b(4),
    .sum(pc_4)
);

reg [31:0] inst;
InstructionMemory m_InstMem(
    .readAddr(pc_o),
    .inst(inst)
);

reg memRd, memWr, aluSrc1, aluSrc2, regWr, PCSel;
reg [1:0] memReg;
reg [2:0] aluOp;
Control m_Control(
    .opcode(inst[6:0]),
    .memRead(memRd),
    .memtoReg(memReg),
    .ALUOp(aluOp),
    .memWrite(memWr),
    .ALUSrc1(aluSrc1),
    .ALUSrc2(aluSrc2),
    .regWrite(regWr),
    .PCSel(PCSel)
);

// ------------------------------------------
// For Student:
// Do not change the modules' instance names and I/O port names!!
// Or you will fail validation.
// By the way, you still have to wire up these modules

reg [31:0] rdData1, rdData2, reg5Data, writeData;
Register m_Register(
    .clk(clk),
    .rst(start),
    .regWrite(regWr),
    .readReg1(inst[24:20]),
    .readReg2(inst[19:15]),
    .writeReg(inst[11:7]),
    .writeData(writeData),
    .readData1(rdData1),
    .readData2(rdData2),
    .reg5Data(reg5Data)
);

reg [31:0] rdDataMem;
DataMemory m_DataMemory(
    .rst(start),
    .clk(clk),
    .memWrite(memWr),
    .memRead(memRd),
    .address(aluOut),
    .writeData(rdData2),
    .readData(rdDataMem)
);

// ------------------------------------------

reg signed [31:0] imm;
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

reg [31:0] outALU1, outALU2;
Mux2to1 #(.size(32)) m_Mux_ALU_1(
    .sel(aluSrc1),
    .s0(rdData1),
    .s1(pc_o),
    .out(outALU1)
);

Mux2to1 #(.size(32)) m_Mux_ALU_2(
    .sel(aluSrc2),
    .s0(rdData2),
    .s1(imm),
    .out(outALU2)
);

reg [3:0] aluCtl;
ALUCtrl m_ALUCtrl(
    .ALUOp(aluOp),
    .funct7(inst[31:25]),
    .funct3(inst[14:12]),
    .ALUCtl(aluCtl)
);

reg [31:0] aluOut;
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
    .s1(rdDataMem),
    .s2(pc_4),
    .out(writeData)
);

reg less, equal;
BranchComp m_BranchComp(
    .rs1(rdData1),
    .rs2(rdData2),
    .brLt(less),
    .brEq(equal)
);

endmodule
