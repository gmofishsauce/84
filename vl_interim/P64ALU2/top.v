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
module top
    (
    input  [15:0] A,
    input  [15:0] B,
    input  B_IN,        // borrow
    input  [ 1:0] FUNC,
    output [15:0] OUT,
    output B_OUT
    );

    wire [16:0] result; // extra bit for carry
    wire [15:0] a_side;
    
    assign a_side = (FUNC[0] == 2'b00) ? A : -A;
    assign result = (FUNC[0] == 2'b00) ? B + a_side + C_IN :
                                         B + a_side - C_IN ;
    assign OUT = result[15:0];
    assign C_OUT = result[16];
endmodule

