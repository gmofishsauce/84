`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    16:50:24 07/12/2023 
// Design Name:    register file, read one and write one per clock
// Module Name:    top 
// Project Name:   
// Target Devices: 64-pin XC9572XL
// Tool versions:  ISE 14.7 in Linux VM
// Description:
//
// Dependencies:   None 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module top
    (
    input  [15:0] A,
    input  [15:0] B,
    input  C_IN,
    input  [ 1:0] FUNC,
    output [15:0] OUT,
    output C_OUT
    );

    wire [16:0] result; // extra bit for carry    
    
    assign result = (FUNC == 2'b00) ? A + B + C_IN :
                    (FUNC == 2'b01) ? A & ~B :
                    (FUNC == 2'b10) ? A | B  : ~B ;
    assign OUT = result[15:0];
    assign C_OUT = result[16];
endmodule
