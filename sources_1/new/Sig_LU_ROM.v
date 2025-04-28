`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2025 20:52:10
// Design Name: 
// Module Name: sigmoid_normal
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "include.v"

module Sig_LU_ROM_HALF #(parameter inWidth=10, dataWidth=16) (
    input           clk,
    input           sign_flag,
    input   [inWidth-1:0]   x,
    output  [`ROM_bitwidth-1:0]  out
    );
    
    (* ram_style = "distributed" *) 
    reg [dataWidth-1:0] mem [2**inWidth-1:0]; //only 0.5-1, but 4095 length, LU_LUT has 0-1, also 4095 length
    
    wire [inWidth-1:0] y;
    wire [`ROM_bitwidth-1:0]  bram_out;
    assign y = (sign_flag == 1'b1) ? -x : x;
	
	`ifdef synthesis
         sig_LU_IP sig_LU
          (
            .clka(clk),
            .ena(1'b1),
            .addra(y),
            .douta(bram_out)
          );    
    assign out = (sign_flag == 1'b1) ? 'b000100000000 - bram_out : bram_out;
    
	`else
	
        initial
        begin
            $readmemb("./LU_LUT_HALF.mif",mem);//dataWidth-bit each entry
        end
	
        always @(posedge clk)
        begin
            if((sign_flag == 1'b1))
                y <= -x; // one's complement, and plus 1
            else 
                y <= x;      
        end
        
        assign out = (sign_flag == 1'b1) ? 'b000100000000 - mem[y] : mem[y];
    
    `endif
    
endmodule
