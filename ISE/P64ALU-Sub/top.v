`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    16:50:24 07/12/2023 
// Design Name:    register file, read one and write one per clock
// Module Name:    top 
// Project Name:   NARC (Not A Retro Computer)
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
//(* LOCK_PINS = "all" *)
module top
    (
    input  [15:0] A,
    input  [15:0] B,
    input  C_IN,
    input  [ 1:0] FUNC,
    output [15:0] OUT,
    output C_OUT
    );

    wire [16:0] raw_sum;
    wire [15:0] not_x;
 
    // compute A - B - C_IN in a way that allows
    // the synthesis logic to fit the subtraction
    // in the chip. 2'b00 on the function pins is
    // subtract. 01 is xor. 10 and 11 are pass.

    assign not_a = ~A;
    assign raw_sum = B + not_a + C_IN ;
    assign C_OUT = (FUNC == 2'b00) ? raw_sum[16] : 0;
    assign OUT   = (FUNC == 2'b00) ? ~raw_sum : 
                   (FUNC == 2'b01) ? A ^ B :
                   (FUNC == 2'b10) ? A : B ;
endmodule
