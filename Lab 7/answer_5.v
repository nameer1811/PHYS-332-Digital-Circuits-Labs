`timescale 1ns / 1ps

module display(
input CLK100MHZ,
input [5:0] SW,
output CA,CB,CC,CD,CE,CF,CG,DP,
output [7:0] AN );

wire display1a, display1b, display1c, display1d, display1e, display1f, display1g;
wire display2a, display2b, display2c, display2d, display2e, display2f, display2g;

reg [7:0] allAN;
reg [6:0] allCAs;
reg ctr = 0;


clock100MHz_to_1kHz setClock(CLK100MHZ, clock);

display_setup firstDisplay(SW[3], SW[2], SW[1], SW[0], display1a, display1b, display1c, display1d, display1e, display1f, display1g);

display_setup secondDisplay(0,0, SW[5], SW[4], display2a, display2b, display2c, display2d, display2e, display2f, display2g);


assign AN[7:0] = allAN[7:0];
assign CG = allCAs[0];
assign CF = allCAs[1];
assign CE = allCAs[2];
assign CD = allCAs[3];
assign CC = allCAs[4];
assign CB = allCAs[5];
assign CA = allCAs[6];
assign DP=1'b1;

always @(posedge clock) begin

    if(ctr == 0) begin
    
        allAN <= 8'b1111_1110;
        
        allCAs[6] <= ~display1a;
        allCAs[5] <= ~display1b;
        allCAs[4] <= ~display1c;
        allCAs[3] <= ~display1d;
        allCAs[2] <= ~display1e;
        allCAs[1] <= ~display1f;
        allCAs[0] <= ~display1g;
    
    end else if(ctr == 1) begin
    
        allAN <= 8'b1111_1101;
        
        allCAs[6] <= ~display2a;
        allCAs[5] <= ~display2b;
        allCAs[4] <= ~display2c;
        allCAs[3] <= ~display2d;
        allCAs[2] <= ~display2e;
        allCAs[1] <= ~display2f;
        allCAs[0] <= ~display2g;
    end
    
    ctr <= ctr + 1;
    
end


endmodule


// 100MHz to 1kHz is 100,000 cycle period
// log2(100000) = 16.6 := 17 bits needed
module clock100MHz_to_1kHz(
    input CLK_100MHZ,
    output reg clock1kHz
);

    reg[16:0] ctr;
    
    always @(posedge CLK_100MHZ) begin
        if (ctr == 49_999) begin
            clock1kHz <= 1'b1;
            ctr <= ctr + 1;
        end else if (ctr == 99_999) begin
            clock1kHz <= 1'b0;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
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
    assign ten      =  s3 & ~s2 & s1& ~s0;
    assign eleven   =  s3 & ~s2 & s1& s0;
    assign twelve   =  s3 & s2 & ~s1& ~s0;
    assign thirteen =  s3 & s2 & ~s1& s0;
    assign fourteen =  s3 & s2 & s1& ~s0;
    assign fifteen  =  s3 & s2 & s1& s0;
    
    assign da = zero | two | three | five | six | seven | eight | nine | ten | fourteen | fifteen;
    assign db = zero | one | two | three | four | seven | eight | nine | ten | thirteen;
    assign dc = zero | one | three | four | five | six | seven | eight | nine | ten | eleven | thirteen ;
    assign dd = zero | two | three | five | six | eight | eleven | twelve | thirteen | fourteen ;
    assign de = zero | two | six | eight | ten | eleven | twelve | thirteen | fourteen | fifteen ;
    assign df = zero | four | five | six | eight | nine | ten | eleven | fourteen | fifteen ;
    assign dg = two | three | four | five | six | eight | nine | ten | eleven | twelve | thirteen | fourteen | fifteen ;
endmodule