`timescale 1ns / 1ps

module display(
    input CLK100MHZ,
    output [7:0] AN,
    output CA,CB,CC,CD,CE,CF,CG,DP
    );
    
    wire [7:0] CAs;
    assign CA = CAs[7];
    assign CB = CAs[6];
    assign CC = CAs[5];
    assign CD = CAs[4];
    assign CE = CAs[3];
    assign CF = CAs[2];
    assign CG = CAs[1];
    assign DP = CAs[0];
    
    wire clockWire;
    clock100MHz_to_1kHz setClock(CLK100MHZ,clockWire);
    digit_map mapDigit(clockWire,AN,CAs);
    
endmodule

// 100MHz to 1kHz is 100,000 cycle period
// log2(100000) = 16.6 := 17 bits needed

module clock100MHz_to_1kHz(
    input inClock,
    output reg outClock
    );
    
    reg [16:0] ctr=0;
    
    always @ (posedge inClock) begin
        if(ctr == 49_999) begin
            outClock <= 1'b0;
            ctr <= ctr + 1;            
        end else if(ctr == 99_999) begin
            outClock <= 1'b1;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1'b1;
        end         
    end
endmodule

module digit_map(input clock,
    output reg [7:0] allAN,
    output reg [7:0] allCAs);

    reg [4:0] ctr=0;
    
    always @(posedge clock) begin
        if(ctr == 4'b0000) begin
        
            allAN <= 8'b1111_0111;
            allCAs <= 8'b1001_1111;
            
        end else if(ctr == 4'b0001) begin
        
            allAN <= 8'b1111_1011;
            allCAs <= 8'b0010_0101;
            
        end else if(ctr == 4'b0010) begin
            
            allAN <= 8'b1111_1101;        
            allCAs <= 8'b0000_1101;

        end else if(ctr == 4'b0011) begin
            
            allAN <= 8'b1111_1110;
            allCAs <= 8'b1001_1001;

        end else begin
            
            allAN <= 8'b1111_1111;
            allCAs <= 8'b1111_1111;
           
        end 
        
        if(ctr == 4'b1111) begin
            ctr <= 4'b0000;
        end else begin
            ctr <= ctr + 1'b1;        
        end   
    end
    
endmodule


