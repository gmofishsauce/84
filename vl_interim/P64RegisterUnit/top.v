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
(* LOCK_PINS = "all" *)
module top
    (
    input  CLK,
    input  RST,
    input  WREN,        // write enable, negative true
    input  [ 1:0] WSEL, // write register select
    input  [ 2:0] RSEL, // read register select (3 registers, 5 small constants)
    input  OE,          // 3-state output enable, negative true
    input  [15:0] DATA,
    output [15:0] ADDR
    );

    // reg r0 is a source of zeroes
    reg [15:0] r1;
    reg [15:0] r2;
    reg [15:0] r3;
   
    always @(posedge CLK) begin  
        if (RST) begin
            r1 <= 16'b0;
            r2 <= 16'b0;  
            r3 <= 16'b0;
        end else begin
            if (WREN == 0) begin
                case (WSEL)
                2'b00: /* nothing happens */;
                2'b01: r1 <= DATA;
                2'b10: r2 <= DATA;
                2'b11: r3 <= DATA;
                endcase
            end
        end

    end // posedge(CLK)
    
    // If RSEL:2 is implemented by the external circuit,
    // this unit can produce one of four small constants.
    assign ADDR = (OE)  ? 16'bz  : /* output disabled */
        (RSEL == 3'b000) ? 16'b0 :
        (RSEL == 3'b001) ? r1    :
        (RSEL == 3'b010) ? r2    :
        (RSEL == 3'b011) ? r3    :
        (RSEL == 3'b100) ? 16'h0002 :
        (RSEL == 3'b101) ? 16'h0001 :
        (RSEL == 3'b110) ? 16'hFFFE : 16'hFFFF ;
    
endmodule

