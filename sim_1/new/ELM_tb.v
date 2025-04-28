`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2025 16:51:15
// Design Name: 
// Module Name: ELM_tb
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

`timescale 1ns / 1ps

`include "../../sources_1/new/include.v"

module ELM_tb;

// Clock and Reset
reg s_axi_aclk;
reg s_axi_aresetn;

// AXI Stream interface
reg [`dataWidth-1:0] axis_in_data;
reg axis_in_data_valid;
wire axis_in_data_ready;
wire [`numNeuronLayer2*`dataWidth-1:0] x2_out;

// Instantiate DUT (Device Under Test)
ELM dut (
    .s_axi_aclk(s_axi_aclk),
    .s_axi_aresetn(s_axi_aresetn),
    .axis_in_data(axis_in_data),
    .axis_in_data_valid(axis_in_data_valid),
    .axis_in_data_ready(axis_in_data_ready),
    .x2_out(x2_out)
);

// Clock generation
initial begin
    s_axi_aclk = 0;
    forever #5 s_axi_aclk = ~s_axi_aclk; // 100MHz clock
end

// Reset generation
initial begin
    s_axi_aresetn = 0;
    axis_in_data_valid = 0;
    axis_in_data = 0;
    #100;
    s_axi_aresetn = 1; // Release reset
end

// Load input data
reg [`dataWidth-1:0] input_mem [0:`numWeightLayer1]; // Assuming maximum 256 entries (adjust if needed)
integer input_size;
integer i;

initial begin
    // Initialize input memory from MIF
    $readmemb("C:/Users/41536/Desktop/ELM_auto/ELM_auto/ELM_auto.srcs/sources_1/new/input.mif", input_mem);

    // Send input data
    @(posedge s_axi_aresetn);  // Wait until reset is released
    #20;

    input_size = `numWeightLayer1;  // Modify based on your actual input length!

    for (i = 0; i < input_size; i = i + 1) begin
        @(posedge s_axi_aclk);
        axis_in_data <= input_mem[i];
        axis_in_data_valid <= 1'b1;
    end

    // After sending all inputs
    @(posedge s_axi_aclk);
    axis_in_data_valid <= 0;
    axis_in_data <= 0;

    // Wait some cycles to observe output
    #500;
    $finish;
end

endmodule

