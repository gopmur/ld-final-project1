
module ADD_4bit(
    
    input [3:0] a, 
    input [3:0] b, 
    output [7:0] out, 
    output cout

    );

    wire [2:0] carry;

    ADDER_4bit adder_4bit0(a, b, 0, out[3:0], cout);

    assign out[7:4] = { 4{out[3]} };

endmodule

module SUB_4bit(

    input [3:0] a, 
    input [3:0] b, 
    output [7:0] out, 
    output cout
    
    );

    ADDER_4bit adder_4bit0(a, ~b, 1, out[3:0], cout);

    assign out[7:4] = { 4{out[3]} };

endmodule

module OR_4bit(
    
    input [3:0] a,
    input [3:0] b,
    output [7:0] out
    
    );

    assign out[3:0] = a | b;
    assign out[7:4] = 4'b0000;

endmodule

module XOR_4bit(
    
    input [3:0] a, 
    input [3:0] b, 
    output [7:0] out
    
    );

    assign out[3:0] = a ^ b;
    assign out[7:4] = 4'b0000;

endmodule

module AND_4bit(
    
    input [3:0] a, 
    input [3:0] b,
    output [7:0] out
    
    );

    assign out[3:0] = a & b;
    assign out[7:4] = 4'b0000;

endmodule

module MUL_4bit(
    
    input [3:0] a,
    input [3:0] b,
    output [7:0] out
    
    );

    wire [7:0] extended_a = {4'h0, a};
    
    wire [7:0] ab0;
    wire [7:0] ab1;
    wire [7:0] ab2;
    wire [7:0] ab3;

    SWITCH_8bit sw0(extended_a     , b[0], ab0);
    SWITCH_8bit sw1(extended_a << 1, b[1], ab1);
    SWITCH_8bit sw2(extended_a << 2, b[2], ab2);
    SWITCH_8bit sw3(extended_a << 3, b[3], ab3);

    wire [7:0] ab01;
    wire [7:0] ab23;

    ADDER_8bit adder_8bit0(ab0, ab1, ab01);
    ADDER_8bit adder_8bit1(ab2, ab3, ab23);

    ADDER_8bit adder_8bit2(ab01, ab23, out);

endmodule

module MUX_8_1(

    input [7:0] in0,
    input [7:0] in1,
    input [7:0] in2,
    input [7:0] in3,
    input [7:0] in4,
    input [7:0] in5,
    input [7:0] in6,
    input [7:0] in7,

    input [2:0] c,
    output [7:0] out 

    );

    wire [7:0] m;

    DEC_3_8 dec(c, m);

    wire [7:0] x [0:7];

    SWITCH_8bit sw0(in0, m[0], x[0]);
    SWITCH_8bit sw1(in1, m[1], x[1]);
    SWITCH_8bit sw2(in2, m[2], x[2]);
    SWITCH_8bit sw3(in3, m[3], x[3]);
    SWITCH_8bit sw4(in4, m[4], x[4]);
    SWITCH_8bit sw5(in5, m[5], x[5]);
    SWITCH_8bit sw6(in6, m[6], x[6]);
    SWITCH_8bit sw7(in7, m[7], x[7]);

    assign out = x[0] | x[1] | x[2] | x[3] | x[4] | x[5] | x[6] | x[7];

endmodule