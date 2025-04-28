`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2025 20:25:28
// Design Name: 
// Module Name: dummy_activation
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

module dummy_activation(
    input wire [2*`dataWidth-1:0] sum,  // Ensure the range is correctly specified
    output wire [`dataWidth-1:0] out  // Correct the 'ouptut' to 'output' and range declaration
);
    
assign out = sum[2*`dataWidth-1-:`dataWidth]; //simply truncate

endmodule
