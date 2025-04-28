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

module Sig_ROM #(parameter inWidth=10, dataWidth=16) (
    input                   clk,
    input   [inWidth-1:0]   x,
    input                   sign_flag,
    output  [`ROM_bitwidth-1:0]  out
    );
	
    `ifdef synthesis
    
    wire [inWidth-1:0] bram_addr;
    wire [`ROM_bitwidth-1:0]  bram_out;
    assign bram_addr = $signed(x) >= 0 ? x+(2**(inWidth-1)) :x-(2**(inWidth-1)) ;  
     sig_normal_IP sig_normal
      (
        .clka(clk),
        .ena(1'b1),
        .addra(bram_addr),
        .douta(bram_out)
      );       
      assign out = (sign_flag == 'b0 && x[inWidth-1])? 'b000100000000 :  bram_out;

	`elsif simulation
	    reg [dataWidth-1:0] mem [2**inWidth-1:0];
        reg [inWidth-1:0] y;
        
        initial
        begin
            $readmemb("./sigContent.mif",mem);//dataWidth-bit each entry
        end
    
        always @(posedge clk)
        begin
            if($signed(x) >= 0)
                y <= x+(2**(inWidth-1));
            else 
                y <= x-(2**(inWidth-1));      
        end
        
        assign out = (sign_flag == 'b0 && x[inWidth-1])? 'b000100000000 :  mem[y];
        
    `endif
    
endmodule
