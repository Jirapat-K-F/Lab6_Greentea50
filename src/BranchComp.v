module BranchComp(
    input [31:0] rs1,       // First register value
    input [31:0] rs2,       // Second register value
    output brLt,            // Output for less than condition
    output brEq             // Output for equality condition
);

    // TODO: implement your branch comparator here for checking if
    // value is register is less than or equal to another register
    reg lt;
    reg eq;
    always @(*) begin
        if(rs1<rs2)begin
            lt = 1;
            eq = 0;
        end else if (rs1==rs2) begin
            lt = 0;
            eq = 1;
        end else begin
            lt = 0;
            eq = 0;
        end
    end
    assign brLt = lt;
    assign brEq = eq;
endmodule