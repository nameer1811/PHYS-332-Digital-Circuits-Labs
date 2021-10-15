`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab5
//////////////////////////////////////////////////////////////////////////////////


module lab5a(
    input [3:0] SW,
    output [3:0] LED,
    output LED17_B, 
    output LED17_G,
    output LED17_R
    );
    
    assign LED[0] = SW[0];
    assign LED[1] = SW[1];
    assign LED[2] = SW[2];
    assign LED[3] = SW[3];
    
    assign LED17_B = SW[0] & SW [1];
    assign LED17_G = SW[0] & SW [2];
    assign LED17_R = SW[0] & SW [3];
    
endmodule

module lab5b(
    input [3:0] SW,
    output[2:0] LED
);

wire e,f,g; 
wire a1, a0, b1 ,b0; 

assign a0 = SW[0]; 
assign a1 = SW[1]; 
assign b0 = SW[2]; 
assign b1 = SW[3]; 

assign LED[0] = e; 
assign LED[1] = f; 
assign LED[2] = g; 
   

assign e = (~b1 & ~b0 & ~a1 & ~a0) | (~b1 & b0 & ~a1 & a0) | ( b1 & ~b0 & a1 & ~a0) | (b1 & b0 & a1 & a0);
assign f = (~b1 & ~b0 & ~a1 & a0) | (~b1 & ~b0 & a1 & ~a0) | (~b1 & ~b0 & a1 & a0) | (~b1 & b0 & a1 & ~a0) | (~b1 & b0 & a1 & a0) | (b1 & ~b0 & a1 & a0); 
assign g = ~e & ~f; 

endmodule 
