// 32-bit Ladner-Fischer Parallel Prefix Adder
module ladner_fischer_32bit (
    input  [31:0] A,
    input  [31:0] B,
    input         Cin,
    output [31:0] Sum,
    output        Cout);
    // Pre-processing Stage
    wire [31:0] G;   // Generate
    wire [31:0] P;   // Propagate
    assign G = A & B;
    assign P = A ^ B;
    // Carry Signals
    wire [32:0] C;
    assign C[0] = Cin;
    // Carry Generation Logic
    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1)
        begin : CARRY_GEN

            assign C[i+1] =
                    G[i] |
                   (P[i] & C[i]);
        end
    endgenerate
    // Post-processing Stage
    generate
        for(i = 0; i < 32; i = i + 1)
        begin : SUM_GEN
            assign Sum[i] = P[i] ^ C[i];
        end
    endgenerate
    // Final Carry Out
    assign Cout = C[32];
endmodule