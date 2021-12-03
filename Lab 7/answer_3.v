`timescale 1ns / 1ps


module binaryCounter(
    input CLK100MHZ,
    output [7:0] LED
    );
    
    wire clockWire;  

    clock100MHz_to_1Hz  setClock(CLK100MHZ, clockWire);
    countInBinary countBin(clockWire, LED);

endmodule


module countInBinary(
    input clock,
    output[7:0] LED 
    );
    
    reg[7:0] ctr = 0;
    assign LED = ctr;
    
    always @ (posedge clock) begin
        if (ctr == 255) begin
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
    
endmodule

// 100MHz to 1Hz is 100,000,000 cycle period
// log2(100,000,000) = 26.6 := 27 bits needed

module clock100MHz_to_1Hz(
    input inClock,
    output reg outClock
    );
    
    reg [26:0] ctr=0;
    
    always @ (posedge inClock) begin
        if(ctr==49_999_999) begin
            outClock <= 1'b0;
            ctr <= ctr + 1;            
        end else if(ctr==99_999_999) begin
            outClock <= 1'b1;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
endmodule