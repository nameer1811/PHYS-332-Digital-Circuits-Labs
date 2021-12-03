`timescale 1ns / 1ps

module LED_counters(
     input CLK100MHZ,
     output [1:0] LED
);

    wire clock1Hz, clock1kHz;

    clock100MHz_to_1kHz firstLED (CLK100MHZ,clock1kHz);
    clock100MHz_to_1Hz secondLED (CLK100MHZ, clock1Hz);
    
    LED_2son_1soff LEDfirst(clock1Hz, LED[0]);
    LED_1mson_2msoff LEDsecond(clock1kHz, LED[1]);

endmodule

module LED_1mson_2msoff(
    input clock,
    output [0:0] LED
);

    reg[1:0] ctr;
    
    assign LED[0] = ~ctr[0] & ~ctr[1]; 
    always @ (posedge clock) begin        
        if (ctr == 2'b10) begin 
            ctr <= 2'b00;
        end else begin
            ctr <= ctr + 2'b01;
        end
    end
 
endmodule

module LED_2son_1soff(
    input clock,
    output [0:0] LED
 );
 
    reg[1:0] ctr;
    
    assign LED[0] = ctr[0] | ctr[1];
    
    always @ (posedge clock) begin        
        if (ctr == 2'b10) begin 
            ctr <= 2'b00;
        end else begin
            ctr <= ctr + 2'b01;
        end
    end
 
endmodule

// 100MHz to 1Hz is 100,000,000 cycle period
// log2(100,000,000) = 26.6 := 27 bits needed
module clock100MHz_to_1Hz(
    input CLK_100MHZ,
    output reg clock1Hz
);
    reg[26:0] ctr;
    
    always @ (posedge CLK_100MHZ) begin
        if (ctr == 49_999_999) begin
            clock1Hz <= 1'b1;
            ctr <= ctr + 1;            
        end
        else if (ctr == 99_999_999) begin
            clock1Hz <= 1'b0;
            ctr <= 0;
        end
        else begin
            ctr <= ctr + 1;
        end
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