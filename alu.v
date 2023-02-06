

module ALU(

    input [3:0] a,
    input [3:0] b,
    input [2:0] opcode,
    output [7:0] out

    );

    wire [7:0] or_out;
    wire [7:0] xor_out;
    wire [7:0] and_out;
    wire [7:0] add_out;
    wire [7:0] sub_out;
    wire [7:0] mul_out;

    OR_4bit   or_4bit(a, b, or_out );
    XOR_4bit xor_4bit(a, b, xor_out);
    AND_4bit and_4bit(a, b, and_out);
    ADD_4bit add_4bit(a, b, add_out);
    SUB_4bit sub_4bit(a, b, sub_out);
    MUL_4bit mul_4bit(a, b, mul_out);

    MUX_8_1 mux(
        or_out,
        xor_out,
        and_out,
        add_out,
        sub_out,
        mul_out,
        0,
        0,
        opcode,
        out
    );

endmodule

module ALU_tb;

    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] opcode;
    wire [7:0] out;

    parameter or_opcode  = 3'd0;
    parameter xor_opcode = 3'd1;
    parameter and_opcode = 3'd2;
    parameter add_opcode = 3'd3;
    parameter sub_opcode = 3'd4;
    parameter mul_opcode = 3'd5;

    ALU alu(a, b, opcode, out);

    initial begin
        
            a = 15; b = 13; opcode = or_opcode;
        #10 a = 11; b = 3;  opcode = xor_opcode;
        #10 a = 15; b = 11; opcode = and_opcode;
        #10 a = 12; b = 15; opcode = add_opcode;
        #10 a = 10; b = 15; opcode = sub_opcode;
        #10 a = 9;  b = 1;  opcode = mul_opcode;
        #10 a = 5;  b = 8;  opcode = 3'd6;
        #10 a = 13; b = 2;  opcode = add_opcode;
        #10 a = 8;  b = 0;  opcode = sub_opcode;
        #10 a = 14; b = 7;  opcode = mul_opcode;

    end

endmodule