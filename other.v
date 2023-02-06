module FULL_ADDER(

    input a, 
    input b, 
    input cin, 
    output sum,
    output cout

    );

    wire ab_xor = a ^ b;
    assign sum = ab_xor ^ cin;

    assign cout = (ab_xor & cin) | (a & b);

endmodule

module ADDER_4bit(

        input [3:0] a, 
        input [3:0] b, 
        input cin,
        output [3:0] out, 
        output cout

    );

    wire [2:0] carry;

    FULL_ADDER full_adder0(a[0], b[0], cin     , out[0], carry[0]);
    FULL_ADDER full_adder1(a[1], b[1], carry[0], out[1], carry[1]);
    FULL_ADDER full_adder2(a[2], b[2], carry[1], out[2], carry[2]);
    FULL_ADDER full_adder3(a[3], b[3], carry[2], out[3], cout    );

endmodule

module ADDER_8bit(

    input [7:0] a,
    input [7:0] b,
    output [7:0] out,
    output cout

    );

    wire carry;
    wire [3:0] out_low;
    wire [3:0] out_high;

    ADDER_4bit adder_4bit0(a[3:0], b[3:0], 0, out_low, carry);
    ADDER_4bit adder_4bit1(a[7:4], b[7:4], carry, out_high, cout);
    
    assign out = {out_high, out_low};
    
endmodule

module SWITCH_4bit(
    
    input [3:0] in,
    input c,
    output [3:0] out
    
    );

    assign out = {
        in[3] & c,
        in[2] & c,
        in[1] & c,
        in[0] & c
    };

endmodule

module SWITCH_8bit(

    input [7:0] in,
    input c,
    output [7:0] out

    );  

    wire [3:0] out_low;
    wire [3:0] out_high;

    SWITCH_4bit sw0(in[3:0], c, out_low);
    SWITCH_4bit sw1(in[7:4], c, out_high);

    assign out = {out_high, out_low};

endmodule

module DEC_3_8(
    
    input [2:0] in,
    output [7:0] out

    );

    assign out[0] = ~in[2] & ~in[1] & ~in[0];
    assign out[1] = ~in[2] & ~in[1] &  in[0];
    assign out[2] = ~in[2] &  in[1] & ~in[0];
    assign out[3] = ~in[2] &  in[1] &  in[0];
    assign out[4] =  in[2] & ~in[1] & ~in[0];
    assign out[5] =  in[2] & ~in[1] &  in[0];
    assign out[6] =  in[2] &  in[1] & ~in[0];
    assign out[7] =  in[2] &  in[1] &  in[0];

endmodule

