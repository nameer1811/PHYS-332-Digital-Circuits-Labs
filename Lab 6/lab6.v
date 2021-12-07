`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab6
// Name: Sheikh Fahad
//////////////////////////////////////////////////////////////////////////////////


module fulladder(
    input a,
    input b,
    input c_in,
    output c_out,
    output sum
    );
    assign c_out = (a & b)|(c_in & b)|(c_in & a);
    assign sum = (~a & ~b & c_in)|(~a & b& ~c_in)|(a & b& c_in)|(a & ~b & ~c_in);
endmodule

module display_setup(
    input s3,
    input s2,
    input s1,
    input s0, 
    output da,
    output db,
    output dc,
    output dd,
    output de,
    output df,
    output dg);

    wire zero, one, two, three, four, five, six, seven, eight, nine;
    assign zero     = ~s3 & ~s2 & ~s1 & ~s0;
    assign one      = ~s3 & ~s2 & ~s1 & s0;
    assign two      = ~s3 & ~s2 & s1 & ~s0;
    assign three    = ~s3 & ~s2 & s1 & s0;
    assign four     = ~s3 & s2 & ~s1 & ~s0;
    assign five     = ~s3 & s2 & ~s1 & s0;
    assign six      = ~s3 & s2 & s1 & ~s0;
    assign seven    = ~s3 & s2 & s1 & s0;
    assign eight    =  s3 & ~s2 & ~s1 & ~s0;
    assign nine     =  s3 & ~s2 & ~s1 & s0;
    
    assign da = zero | two | three | five | six | seven | eight | nine;
    assign db = zero | one | two | three | four | seven | eight | nine;
    assign dc = zero | one | three | four | five | six | seven | eight | nine;
    assign dd = zero | two | three | five | six | eight;
    assign de = zero | two | six | eight;
    assign df = zero | four | five | six | eight | nine;
    assign dg = two | three | four | five | six | eight | nine;
endmodule

module module_test(
    input [7:0] SW,
    output [3:0] LED,
    output [7:0] AN,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG
    );
    wire a3, a2, a1, a0, b3, b2, b1, b0;
    wire s3, s2, s1, s0, cin1, cin2, cin3, cout;

    // global inputs
    assign a0 = SW[0];
    assign a1 = SW[1];
    assign a2 = SW[2];
    assign a3 = SW[3];
    assign b0 = SW[4];
    assign b1 = SW[5];
    assign b2 = SW[6];
    assign b3 = SW[7];

    // global outputs
    assign LED[0] = s0;
    assign LED[1] = s1;
    assign LED[2] = s2;
    assign LED[3] = s3;
    
    assign DP = 1'b1;
    
    wire da,db,dc,dd,de,df,dg;

    fulladder firstAdder(a0, b0, 0, cin1, s0);
    fulladder secondAdder(a1, b1, cin1, cin2, s1);
    fulladder thirdAdder(a2, b2, cin2, cin3, s2);
    fulladder fourthAdder(a3, b3, cin3, cout, s3);
    display_setup generate1(s3, s2, s1, s0, da, db, dc, dd, de, df, dg);
    
    assign CA=~da;
    assign CB=~db;
    assign CC=~dc;
    assign CD=~dd;
    assign CE=~de;
    assign CF=~df;
    assign CG=~dg;
    
    assign AN[7:1]=7'b111_1111;
    assign AN[0]=1'b0;

endmodule 
